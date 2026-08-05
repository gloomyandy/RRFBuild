PROCESSOR = STM32H7

VARIANT ?= STM32H743
BUILD_DIR ?= ./iapbuild
IAP_DIR ?= ./IAP
REPRAPFIRMWARE_DIR ?= ./RepRapFirmware
RRFLIBRARIES_DIR ?= ./RRFLibraries
CANLIB_DIR ?= ./CANlib
CORESTM_DIR ?= ./CoreN2G
CONFIG ?= IAP_SPI_LOADER
USE_SD ?= 0
USE_CAN ?= 0
CAN_READ ?= PB_8
CAN_WRITE ?= PB_9
BUILD ?= Debug
BOARD_NAME ?= "expansion"
LED_PIN ?= NoPin
CAN_ADDRESS ?= 119

GCC_PATH ?=

STARTUP_DELAY ?= -DSTARTUP_DELAY=10000

#Comment out to show compilation commands (verbose)
V=@

$(info Building RepRapFirmware IAP for STM32H7 based boards:)
$(info  - Variant: $(VARIANT))
$(info  - SD: $(USE_SD))
$(info  - CAN: $(USE_CAN))
$(info  - CAN Read: $(CAN_READ))
$(info  - CAN Write: $(CAN_WRITE))
$(info  - CAN Address: $(CAN_ADDRESS))

ifeq ($(CONFIG),IAP_BOOT_LOADER)
ifeq ($(SDTYPE),2)
BUILDCONFIG = -DUSE_SDIO=1
else
BUILDCONFIG = -DUSE_SSP1=1 -DUSE_SSP2=1 -DUSE_SSP3=1
endif
BUILDCONFIG += -DBOARD_NAME=\"$(BOARD_NAME)\" -DLED_PIN=$(LED_PIN) -DCAN_ADDRESS=$(CAN_ADDRESS) -DFF_LRU=0
LDNAME=iapbl
VECTOR= -DVECT_TAB_OFFSET=0x0000
else
BUILDCONFIG = -DUSE_SSP1=1 -DUSE_SSP2=1 -DUSE_SSP3=1
SDTYPE=255
LDNAME=iapspi
ifeq ($(VARIANT),STM32H723)
	VECTOR= -DVECT_TAB_SRAM -DVECT_TAB_OFFSET=0x38000
else
	VECTOR= -DVECT_TAB_SRAM -DVECT_TAB_OFFSET=0x60000
endif
endif

## Cross-compilation commands 
CC      = $(GCC_PATH)arm-none-eabi-gcc
CXX     = $(GCC_PATH)arm-none-eabi-g++
LD      = $(GCC_PATH)arm-none-eabi-gcc
AR      = $(GCC_PATH)arm-none-eabi-ar
AS      = $(GCC_PATH)arm-none-eabi-as
OBJCOPY = $(GCC_PATH)arm-none-eabi-objcopy
OBJDUMP = $(GCC_PATH)arm-none-eabi-objdump
SIZE    = $(GCC_PATH)arm-none-eabi-size

MKDIR = mkdir -p

$(info  - MAKE_DIR: $(MAKE_DIR))
include $(MAKE_DIR)/Core.mk
include $(MAKE_DIR)/RRFLibraries.mk
include $(MAKE_DIR)/RepRapLibc.mk
include $(MAKE_DIR)/IAP.mk

ifeq ($(BUILD),Debug)
	DEBUG_FLAGS = -Os -g -DSTM32_DEBUG -DDEBUG=1 $(STARTUP_DELAY)
        $(info - Build: Debug) 
else
	DEBUG_FLAGS = -Os
        $(info - Build: Release)
endif
	

#Linker script to avoid built in Bootloader
LINKER_SCRIPT_BASE = $(IAP_DIR)/src/STM32/variants/$(VARIANT)/



#Path to the linker Script
LINKER_SCRIPT  = $(LINKER_SCRIPT_BASE)$(LDNAME).ld
$(info  - Linker Script used: $(LINKER_SCRIPT))
$(info - Output name: $(OUTPUT_NAME))

#Flags common for Core in c and c++
FLAGS  = -D__$(PROCESSOR)__ -D_XOPEN_SOURCE -DSTM32 -DSTM32H7 -D$(VARIANT)xx -DSTM32H7xx
#Build config flags
FLAGS += -D$(CONFIG)=1 -DSDTYPE=$(SDTYPE) $(BUILDCONFIG) -DUSE_SD=$(USE_SD) -DUSE_CAN=$(USE_CAN) -DCAN_READ=$(CAN_READ) -DCAN_WRITE=$(CAN_WRITE)
FLAGS += -DSUPPORT_USB=1 -DUSBCON -DUSBD_USE_CDC -DUSB_PRODUCT=\"RepRapFirmware\" $(VECTOR)
FLAGS += -DSTM32BTC=1 -DHAL_RRF=1 -DNO_PRINTF_FLOAT -DSUPPORT_CAN=$(USE_CAN)
FLAGS +=  -Wall -c -mfpu=fpv5-d16 -mfloat-abi=hard -mfp16-format=ieee -mcpu=cortex-m7 -mthumb -fno-math-errno -mno-unaligned-access -ffunction-sections -fdata-sections
FLAGS += -nostdlib -Wdouble-promotion -fsingle-precision-constant -fstack-usage
#FLAGS += -Wfloat-equal
#FLAGS += -Wundef
FLAGS += $(DEBUG_FLAGS)
FLAGS += -MMD -MP 

CFLAGS   = $(FLAGS) -std=gnu11 -fgnu89-inline -Dnoexcept=
CXXFLAGS = $(FLAGS) -std=c++20 -fno-threadsafe-statics -fno-exceptions -fno-unwind-tables -fno-rtti -Wno-register
CXXFLAGS_RRFL = $(FLAGS) -std=c++20 -fno-threadsafe-statics -fno-exceptions -fno-unwind-tables -fno-rtti -Wno-register
CXXFLAGS_CORE = $(FLAGS) -std=c++20 -fno-threadsafe-statics -fno-exceptions -fno-unwind-tables -fno-rtti -Wno-register


#all Includes (RRF + Core)
INCLUDES = $(IAP_INCLUDES) $(CORE_INCLUDES) $(RRFLIBRARIES_INCLUDES) $(RRFLIBC_INCLUDES)


DEPS = $(CORE_OBJS:.o=.d)
DEPS += $(IAP_OBJS:.o=.d)
DEPS += $(RRFLIBC_OBJS:.o=.d)
DEPS += $(RRFLIBRARIES_OBJS:.o=.d)

default: all

all: firmware

-include $(DEPS)

firmware:  $(BUILD_DIR)/$(OUTPUT_NAME).elf

coreSTM: $(BUILD_DIR)/core.a

$(BUILD_DIR)/libSTMCore.a: $(CORE_OBJS)
	$(V)$(AR) rcs $@ $(CORE_OBJS)
	@echo "\nBuilt STMCore\n"

$(BUILD_DIR)/libRRFLibraries.a: $(RRFLIBRARIES_OBJS)
	$(V)$(AR) rcs $@ $(RRFLIBRARIES_OBJS)
	@echo "\nBuilt RRF Libraries\n"

$(BUILD_DIR)/$(OUTPUT_NAME).elf: $(BUILD_DIR)/libSTMCore.a $(BUILD_DIR)/libRRFLibraries.a $(RRFLIBC_OBJS) $(IAP_OBJS)
	@echo "\nCreating $(OUTPUT_NAME).bin"
	$(V)$(MKDIR) $(dir $@)
	$(V)$(LD) -L$(BUILD_DIR)/ --specs=nosys.specs -Xlinker -z -Xlinker muldefs -Os -Wl,--fatal-warnings -fno-exceptions -fno-unwind-tables -fmerge-all-constants -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mfp16-format=ieee -mcpu=cortex-m7 -mthumb -fno-math-errno -T$(LINKER_SCRIPT) -Wl,-Map,$(BUILD_DIR)/$(OUTPUT_NAME).map -o $(BUILD_DIR)/$(OUTPUT_NAME).elf -Wl,--cref -Wl,--check-sections -Wl,--gc-sections,--relax -Wl,--entry=Reset_Handler -Wl,--unresolved-symbols=report-all -Wl,--warn-common -Wl,--warn-unresolved-symbols -Wl,--no-warn-rwx-segment -Wl,--defsym=LD_MAX_SIZE=2097152 -Wl,--defsym=LD_MAX_DATA_SIZE=524288 -Wl,--defsym=LD_FLASH_OFFSET=0x0 -Wl,--start-group $(RRFLIBC_OBJS) $(IAP_OBJS) -lSTMCore -lRRFLibraries -lc -lm -lgcc -lstdc++ -Wl,--end-group
	$(V)$(OBJCOPY) --strip-unneeded -O binary $(BUILD_DIR)/$(OUTPUT_NAME).elf $(BUILD_DIR)/$(OUTPUT_NAME).bin
	$(V)$(SIZE) $(BUILD_DIR)/$(OUTPUT_NAME).elf
	-@$(MAKE_DIR)/staticMemStats.sh $(BUILD_DIR)/$(OUTPUT_NAME)
	
$(BUILD_DIR)/%.o: %.c
	@echo "[$<]"
	$(V)$(MKDIR) $(dir $@)
	$(V)$(CC)  $(CFLAGS) $(DEFINES) $(INCLUDES) -MMD -MP -MM -MF $(patsubst %.o,%.d,$@) $<
	$(V)$(CC)  $(CFLAGS) $(DEFINES) $(INCLUDES) -MMD -MP -o $@ $<

$(BUILD_DIR)/$(RRFLIBRARIES_DIR)/%.o : $(RRFLIBRARIES_DIR)/%.cpp
	@echo "RRFL [$<]"
	$(V)$(MKDIR) $(dir $@)
	$(V)$(CXX) $(CXXFLAGS_RRFL) $(DEFINES) $(INCLUDES) -MMD -MP -MM -MF $(patsubst %.o,%.d,$@) $<
	$(V)$(CXX) $(CXXFLAGS_RRFL) $(DEFINES) $(INCLUDES) -MMD -MP -o $@ $<

$(BUILD_DIR)/$(CORESTM_DIR)/%.o : $(CORESTM_DIR)/%.cpp
	@echo "CORE [$<]"
	$(V)$(MKDIR) $(dir $@)
	$(V)$(CXX) $(CXXFLAGS_CORE) $(DEFINES) $(INCLUDES) -MMD -MP -MM -MF $(patsubst %.o,%.d,$@) $<
	$(V)$(CXX) $(CXXFLAGS_CORE) $(DEFINES) $(INCLUDES) -MMD -MP -o $@ $<

$(BUILD_DIR)/%.o: %.cpp
	@echo "[$<]"
	$(V)$(MKDIR) $(dir $@)
	$(V)$(CXX) $(CXXFLAGS) $(DEFINES) $(INCLUDES) -MMD -MP -MM -MF $(patsubst %.o,%.d,$@) $<
	$(V)$(CXX) $(CXXFLAGS) $(DEFINES) $(INCLUDES) -MMD -MP -o $@ $<

$(BUILD_DIR)/%.o: %.cc
	@echo "[$<]"
	$(V)$(MKDIR) $(dir $@)
	$(V)$(CXX) $(CXXFLAGS) $(DEFINES) $(INCLUDES) -MMD -MP -MM -MF $(patsubst %.o,%.d,$@) $<
	$(V)$(CXX) $(CXXFLAGS) $(DEFINES) $(INCLUDES) -MMD -MP -o $@ $<

$(BUILD_DIR)/$(CORESTM_DIR)/%.o: $(CORESTM_DIR)/%.S
	@echo "[$<]"
	$(V)$(MKDIR) $(dir $@)
	$(V)$(CXX) -x assembler-with-cpp $(CXXFLAGS) $(DEFINES) $(INCLUDES) -MMD -MP -MM -MF $(patsubst %.o,%.d,$@) $<
	$(V)$(CXX) -x assembler-with-cpp $(CXXFLAGS) $(DEFINES) $(INCLUDES) -MMD -MP -o $@ $<

$(BUILD_DIR)/%.o: %.S
	@echo "[$<]"
	$(V)$(MKDIR) $(dir $@)
	$(V)$(CXX) -x assembler-with-cpp $(CXXFLAGS) $(DEFINES) $(INCLUDES) -MMD -MP -MM -MF $(patsubst %.o,%.d,$@) $<
	$(V)$(CXX) -x assembler-with-cpp $(CXXFLAGS) $(DEFINES) $(INCLUDES) -MMD -MP -o $@ $<

cleancore:
	-rm -f $(CORE_OBJS) $(BUILD_DIR)/libLPCCore.a

clean: distclean

distclean:
	-rm -rf $(BUILD_DIR)/ 

upload:
	ST-LINK_CLI.exe -c SWD -P "$(BUILD_DIR)/firmware.bin" 0x8008000 -ClrBP -NoPrompt -Rst -Run

.PHONY: all firmware clean distclean $(BUILD_DIR)/$(OUTPUT_NAME).elf
