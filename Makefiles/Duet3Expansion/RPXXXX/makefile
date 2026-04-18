PROCESSOR ?= $(CORE)

BOARD ?= FLY36RRF
#BOARD ?= RPI_PICO
BOARD_REV ?= 1
CANFLAGS ?= -DUSE_SPICAN
BUILD_DIR ?= ./expbuild
EXP_DIR ?= ./Duet3Expansion
REPRAPFIRMWARE_DIR ?= ./RepRapFirmware
RRFLIBRARIES_DIR ?= ./RRFLibraries
COREN2G_DIR ?= ./CoreN2G
FREERTOS_DIR ?= ./FreeRTOS
CANLIB_DIR ?= ./CANlib
SDK_DIR ?= $(COREN2G_DIR)/src/RP2040/pico-sdk
LDNAME ?= rp2040_flash
OUTPUT_NAME ?= Duet3Firmware_$(BOARD)

BUILD ?= Debug

#Comment out to show compilation commands (verbose)
V=@

$(info Building RepRapFirmware Duet3Expansion:)

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
include $(MAKE_DIR)/FreeRTOS.mk
#include $(MAKE_DIR)/RepRapLibc.mk
include $(MAKE_DIR)/CANLib.mk
include $(MAKE_DIR)/EXP.mk

FLAGS=
ifeq ($(PROCESSOR),RP2040)
	FLAGS  += -D__RP2040__ -D$(BOARD) $(CANFLAGS) -DBOARD_REV=$(BOARD_REV) -DPICO_RP2040=1
	PROCFLAGS = -mfp16-format=ieee -mcpu=cortex-m0plus -mthumb -fno-math-errno
    $(info - Processor: $(PROCESSOR))
    $(info - Board: $(BOARD)  Rev: $(BOARD_REV))
    $(info - Can options: $(CANFLAGS))
	MCU_DIR = rp2040
	LDNAME = rp2040_flash
endif
ifeq ($(PROCESSOR),RP2350)
	FLAGS  += -D__RP2350__ -D$(BOARD) $(CANFLAGS) -DBOARD_REV=$(BOARD_REV) -DPICO_RP2350=1
	PROCFLAGS = -mcpu=cortex-m33 -march=armv8-m.main+fp+dsp -mfloat-abi=softfp -mcmse -mfp16-format=ieee -mthumb -fno-math-errno
    $(info - Processor: $(PROCESSOR))
    $(info - Board: $(BOARD)  Rev: $(BOARD_REV))
    $(info - Can options: $(CANFLAGS))
	MCU_DIR = rp2350
	LDNAME = rp2350_flash
endif


ifeq ($(BUILD),Debug)
#	DEBUG_FLAGS = -O3 -g -DDEBUG=1
	DEBUG_FLAGS = -g
        $(info - Build: Debug) 
else
	DEBUG_FLAGS =
        $(info - Build: Release)
endif
	

#Linker script
LINKER_SCRIPT_BASE = $(EXP_DIR)/src/Hardware/RP2040/
ifeq ($(PROCESSOR),RP2040)
	LINK_WRAP = -Wl,--wrap=acos -Wl,--wrap=acosf\
		 -Wl,--wrap=acosh -Wl,--wrap=acoshf -Wl,--wrap=__aeabi_cdcmpeq -Wl,--wrap=__aeabi_cdcmple -Wl,--wrap=__aeabi_cdrcmple\
		 -Wl,--wrap=__aeabi_cfcmpeq -Wl,--wrap=__aeabi_cfcmple -Wl,--wrap=__aeabi_cfrcmple -Wl,--wrap=__aeabi_d2f\
		 -Wl,--wrap=__aeabi_d2iz -Wl,--wrap=__aeabi_d2lz -Wl,--wrap=__aeabi_d2uiz -Wl,--wrap=__aeabi_d2ulz -Wl,--wrap=__aeabi_dadd\
		 -Wl,--wrap=__aeabi_dcmpeq -Wl,--wrap=__aeabi_dcmpge -Wl,--wrap=__aeabi_dcmpgt -Wl,--wrap=__aeabi_dcmple\
		 -Wl,--wrap=__aeabi_dcmplt -Wl,--wrap=__aeabi_dcmpun -Wl,--wrap=__aeabi_ddiv -Wl,--wrap=__aeabi_dmul -Wl,--wrap=__aeabi_drsub\
		 -Wl,--wrap=__aeabi_dsub -Wl,--wrap=__aeabi_f2d -Wl,--wrap=__aeabi_f2iz -Wl,--wrap=__aeabi_f2lz -Wl,--wrap=__aeabi_f2uiz\
		 -Wl,--wrap=__aeabi_f2ulz -Wl,--wrap=__aeabi_fadd -Wl,--wrap=__aeabi_fcmpeq -Wl,--wrap=__aeabi_fcmpge\
		 -Wl,--wrap=__aeabi_fcmpgt -Wl,--wrap=__aeabi_fcmple -Wl,--wrap=__aeabi_fcmplt -Wl,--wrap=__aeabi_fcmpun\
		 -Wl,--wrap=__aeabi_fdiv -Wl,--wrap=__aeabi_fmul -Wl,--wrap=__aeabi_frsub -Wl,--wrap=__aeabi_fsub -Wl,--wrap=__aeabi_i2d\
		 -Wl,--wrap=__aeabi_i2f -Wl,--wrap=__aeabi_idiv -Wl,--wrap=__aeabi_idivmod -Wl,--wrap=__aeabi_l2d -Wl,--wrap=__aeabi_l2f\
		 -Wl,--wrap=__aeabi_ldivmod -Wl,--wrap=__aeabi_lmul -Wl,--wrap=__aeabi_memcpy -Wl,--wrap=__aeabi_memcpy4\
		 -Wl,--wrap=__aeabi_memcpy8 -Wl,--wrap=__aeabi_memset -Wl,--wrap=__aeabi_memset4 -Wl,--wrap=__aeabi_memset8\
		 -Wl,--wrap=__aeabi_ui2d -Wl,--wrap=__aeabi_ui2f -Wl,--wrap=__aeabi_uidiv -Wl,--wrap=__aeabi_uidivmod -Wl,--wrap=__aeabi_ul2d\
		 -Wl,--wrap=__aeabi_ul2f -Wl,--wrap=__aeabi_uldivmod -Wl,--wrap=asin -Wl,--wrap=asinf -Wl,--wrap=asinh -Wl,--wrap=asinhf\
		 -Wl,--wrap=atan -Wl,--wrap=atan2 -Wl,--wrap=atan2f -Wl,--wrap=atanf -Wl,--wrap=atanh -Wl,--wrap=atanhf -Wl,--wrap=cbrt\
		 -Wl,--wrap=cbrtf -Wl,--wrap=ceil -Wl,--wrap=ceilf -Wl,--wrap=__clz -Wl,--wrap=__clzdi2 -Wl,--wrap=__clzl -Wl,--wrap=__clzll\
		 -Wl,--wrap=__clzsi2 -Wl,--wrap=copysign -Wl,--wrap=copysignf -Wl,--wrap=cos -Wl,--wrap=cosf -Wl,--wrap=cosh -Wl,--wrap=coshf\
		 -Wl,--wrap=__ctzdi2 -Wl,--wrap=__ctzsi2 -Wl,--wrap=drem -Wl,--wrap=dremf -Wl,--wrap=exp -Wl,--wrap=exp10 -Wl,--wrap=exp10f\
		 -Wl,--wrap=exp2 -Wl,--wrap=exp2f -Wl,--wrap=expf -Wl,--wrap=expm1 -Wl,--wrap=expm1f -Wl,--wrap=floor -Wl,--wrap=floorf\
		 -Wl,--wrap=fma -Wl,--wrap=fmaf -Wl,--wrap=fmod -Wl,--wrap=fmodf -Wl,--wrap=hypot -Wl,--wrap=hypotf -Wl,--wrap=ldexp\
		 -Wl,--wrap=ldexpf -Wl,--wrap=log -Wl,--wrap=log10 -Wl,--wrap=log10f -Wl,--wrap=log1p -Wl,--wrap=log1pf -Wl,--wrap=log2\
		 -Wl,--wrap=log2f -Wl,--wrap=logf -Wl,--wrap=__popcountsi2 -Wl,--wrap=pow -Wl,--wrap=powf -Wl,--wrap=powint -Wl,--wrap=powintf\
		 -Wl,--wrap=remainder -Wl,--wrap=remainderf -Wl,--wrap=remquo -Wl,--wrap=remquof -Wl,--wrap=round -Wl,--wrap=roundf\
		 -Wl,--wrap=sin -Wl,--wrap=sincos -Wl,--wrap=sincosf -Wl,--wrap=sinf -Wl,--wrap=sinh -Wl,--wrap=sinhf -Wl,--wrap=sqrt\
		 -Wl,--wrap=sqrtf -Wl,--wrap=tan -Wl,--wrap=tanf -Wl,--wrap=tanh -Wl,--wrap=tanhf -Wl,--wrap=trunc -Wl,--wrap=truncf
endif
ifeq ($(PROCESSOR),RP2040)
	LINK_WRAP = -Wl,--wrap=acos -Wl,--wrap=acosf -Wl,--wrap=acosh -Wl,--wrap=acoshf -Wl,--wrap=__aeabi_cdcmpeq -Wl,--wrap=__aeabi_cdcmple\
		 -Wl,--wrap=__aeabi_cdrcmple -Wl,--wrap=__aeabi_d2f -Wl,--wrap=__aeabi_d2iz -Wl,--wrap=__aeabi_d2lz -Wl,--wrap=__aeabi_d2uiz\
		 -Wl,--wrap=__aeabi_d2ulz -Wl,--wrap=__aeabi_dadd -Wl,--wrap=__aeabi_dcmpeq -Wl,--wrap=__aeabi_dcmpge -Wl,--wrap=__aeabi_dcmpgt\
		 -Wl,--wrap=__aeabi_dcmple -Wl,--wrap=__aeabi_dcmplt -Wl,--wrap=__aeabi_dcmpun -Wl,--wrap=__aeabi_ddiv -Wl,--wrap=__aeabi_dmul\
		 -Wl,--wrap=__aeabi_drsub -Wl,--wrap=__aeabi_dsub -Wl,--wrap=__aeabi_i2d -Wl,--wrap=__aeabi_l2d -Wl,--wrap=__aeabi_ui2d\
		 -Wl,--wrap=__aeabi_ul2d -Wl,--wrap=asin -Wl,--wrap=asinf -Wl,--wrap=asinh -Wl,--wrap=asinhf -Wl,--wrap=atan -Wl,--wrap=atan2\
		 -Wl,--wrap=atan2f -Wl,--wrap=atanf -Wl,--wrap=atanh -Wl,--wrap=atanhf -Wl,--wrap=cbrt -Wl,--wrap=cbrtf -Wl,--wrap=ceil\
		 -Wl,--wrap=ceilf -Wl,--wrap=copysign -Wl,--wrap=copysignf -Wl,--wrap=cos -Wl,--wrap=cosf -Wl,--wrap=cosh -Wl,--wrap=coshf\
		 -Wl,--wrap=__ctzdi2 -Wl,--wrap=drem -Wl,--wrap=dremf -Wl,--wrap=exp -Wl,--wrap=exp10 -Wl,--wrap=exp10f -Wl,--wrap=exp2\
		 -Wl,--wrap=exp2f -Wl,--wrap=expf -Wl,--wrap=expm1 -Wl,--wrap=expm1f -Wl,--wrap=floor -Wl,--wrap=floorf -Wl,--wrap=fma\
		 -Wl,--wrap=fmaf -Wl,--wrap=fmod -Wl,--wrap=fmodf -Wl,--wrap=hypot -Wl,--wrap=hypotf -Wl,--wrap=ldexp -Wl,--wrap=ldexpf\
		 -Wl,--wrap=log -Wl,--wrap=log10 -Wl,--wrap=log10f -Wl,--wrap=log1p -Wl,--wrap=log1pf -Wl,--wrap=log2 -Wl,--wrap=log2f\
		 -Wl,--wrap=logf -Wl,--wrap=pow -Wl,--wrap=powf -Wl,--wrap=powint -Wl,--wrap=powintf -Wl,--wrap=remainder -Wl,--wrap=remainderf\
		 -Wl,--wrap=remquo -Wl,--wrap=remquof -Wl,--wrap=round -Wl,--wrap=roundf -Wl,--wrap=sin -Wl,--wrap=sincos -Wl,--wrap=sincosf\
		 -Wl,--wrap=sinf -Wl,--wrap=sinh -Wl,--wrap=sinhf -Wl,--wrap=sqrt -Wl,--wrap=tan -Wl,--wrap=tanf -Wl,--wrap=tanh\
		 -Wl,--wrap=tanhf -Wl,--wrap=trunc -Wl,--wrap=truncf -Wl,--wrap=memcpy
endif

#Path to the linker Script
LINKER_SCRIPT  = $(LINKER_SCRIPT_BASE)$(LDNAME).ld
$(info - Linker Script used: $(LINKER_SCRIPT))
$(info - Output name: $(OUTPUT_NAME))

#Flags common for Core in c and c++
FLAGS  += -DRTOS $(PROCFLAGS) -DSUPPORT_CAN=1 -DSUPPORT_USB=1
#Build config flags
FLAGS +=  -Wall -c -ffunction-sections -fdata-sections -Werror=return-type
FLAGS += -nostdlib -Wdouble-promotion -fsingle-precision-constant
#FLAGS += -Wfloat-equal
#FLAGS += -Wundef
FLAGS += $(DEBUG_FLAGS)
#FLAGS += -MMD -MP 

CFLAGS   = $(FLAGS) -std=gnu99 -O2 -Dnoexcept= 
CXXFLAGS = $(FLAGS) -std=gnu++17 -O3 -fno-threadsafe-statics -fno-exceptions -fno-rtti -Wno-register -Wsuggest-override
CXXFLAGS_RRFL = $(FLAGS) -std=gnu++17 -O2 -fno-threadsafe-statics -fno-exceptions -fno-rtti -Wno-register -Wsuggest-override
CXXFLAGS_CORE = $(FLAGS) -std=gnu++17 -O3 -fno-threadsafe-statics -fno-exceptions -fno-rtti -Wno-register -Wsuggest-override
CXXFLAGS_RTOS = $(FLAGS) -std=gnu++17 -O3 -fno-threadsafe-statics -fno-exceptions -fno-rtti -Wno-register -Wsuggest-override
CXXFLAGS_CANLIB = $(FLAGS) -std=gnu++17 -O2 -fno-threadsafe-statics -fno-exceptions -fno-rtti -Wno-register -Wsuggest-override

#$(info  - SDK Include: $(SDK_INCLUDES))

#all Includes (RRF + Core)
INCLUDES = $(EXP_INCLUDES) $(CORE_INCLUDES) $(RTOS_INCLUDES) $(RRFLIBRARIES_INCLUDES) $(RRFLIBC_INCLUDES) $(SDK_INCLUDES) $(CANLIB_INCLUDES)


DEPS = $(CORE_OBJS:.o=.d)
DEPS = $(RTOS_OBJS:.o=.d)
DEPS += $(IAP_OBJS:.o=.d)
DEPS += $(RRFLIBC_OBJS:.o=.d)
DEPS += $(RRFLIBRARIES_OBJS:.o=.d)
DEPS += $(EXP_OBJS:.o=.d)

default: all

all: firmware

-include $(DEPS)

firmware:  $(BUILD_DIR)/$(OUTPUT_NAME).elf

$(BUILD_DIR)/libCoreN2G.a: $(CORE_OBJS)
	$(V)$(AR) rcs $@ $(CORE_OBJS)
	@echo "\nBuilt STMCore\n"

$(BUILD_DIR)/libRRFLibraries.a: $(RRFLIBRARIES_OBJS)
	$(V)$(AR) rcs $@ $(RRFLIBRARIES_OBJS)
	@echo "\nBuilt RRF Libraries\n"

$(BUILD_DIR)/libCANlib.a: $(CANLIB_OBJS)
	$(V)$(AR) rcs $@ $(CANLIB_OBJS)
	@echo "\nBuilt CANlib\n"

$(BUILD_DIR)/libFreeRTOS.a: $(RTOS_OBJS)
	$(V)$(AR) rcs $@ $(RTOS_OBJS)
#	$(V)$(AR) rcs $@ ./expbuild/./FreeRTOS/src/event_groups.o ./expbuild/./FreeRTOS/src/list.o ./expbuild/./FreeRTOS/src/portable/GCC/ARM_CM0/port.o ./expbuild/./FreeRTOS/src/queue.o ./expbuild/./FreeRTOS/src/stream_buffer.o ./expbuild/./FreeRTOS/src/tasks.o ./expbuild/./FreeRTOS/src/timers.o
	@echo "\nBuilt FreeRTOS lib\n"

$(BUILD_DIR)/$(OUTPUT_NAME).elf: $(BUILD_DIR)/libCoreN2G.a $(BUILD_DIR)/libFreeRTOS.a $(BUILD_DIR)/libRRFLibraries.a $(BUILD_DIR)/libCANlib.a $(EXP_OBJS)
	@echo "\nCreating $(OUTPUT_NAME).bin"
	$(V)$(MKDIR) $(dir $@)
	$(V)$(CXX) -L$(BUILD_DIR)/ -L$(COREN2G_DIR)/src/RP2040/lib/$(MCU_DIR)/ -Os --specs=nano.specs -Wl,--gc-sections -Wl,--fatal-warnings\
		-Wl,--no-warn-rwx-segment -fno-exceptions -mcpu=cortex-m0plus -T$(LINKER_SCRIPT) $(LINK_WRAP) \
		-Wl,--undefined=runtime_init_install_ram_vector_table\
		-Wl,--undefined=__pre_init_runtime_init_clocks\
		-Wl,--undefined=__pre_init_runtime_init_bootrom_reset\
		-Wl,--undefined=__pre_init_runtime_init_early_resets\
		-Wl,--undefined=__pre_init_runtime_init_usb_power_down\
		-Wl,--undefined=__pre_init_runtime_init_clocksa\
		-Wl,--undefined=__pre_init_runtime_init_post_clock_resets\
		-Wl,--undefined=__pre_init_runtime_init_spin_locks_reset\
		-Wl,--undefined=__pre_init_runtime_init_boot_locks_reset\
		-Wl,--undefined=__pre_init_runtime_init_bootrom_locking_enable\
		-Wl,--undefined=__pre_init_runtime_init_mutex\
		-Wl,--undefined=__pre_init_runtime_init_default_alarm_pool\
		-Wl,--undefined=__pre_init_first_per_core_initializer\
		-Wl,--undefined=__pre_init_runtime_init_per_core_bootrom_reset\
		-Wl,--undefined=__pre_init_runtime_init_per_core_h3_irq_registers\
		-Wl,--undefined=__pre_init_runtime_init_per_core_irq_priorities\
		 -Wl,-Map,$(BUILD_DIR)/$(OUTPUT_NAME).map -o $(BUILD_DIR)/$(OUTPUT_NAME).elf $(EXP_OBJS) -lRRFLibraries -lCoreN2G -lCANlib\
		 -lFreeRTOS -lpico -lRRFLibraries -lCoreN2G -lCANlib -lFreeRTOS -lpico
#	$(V)$(CXX) -L$(BUILD_DIR)/ -L$(COREN2G_DIR)/src/RP2040/Tools/Build-pico-sdk/build/ -Os --specs=nano.specs -Wl,--gc-sections -Wl,--fatal-warnings -Wl,--no-warn-rwx-segment -fno-exceptions -mcpu=cortex-m0plus -T$(LINKER_SCRIPT) -Wl,-Map,$(BUILD_DIR)/$(OUTPUT_NAME).map -o $(BUILD_DIR)/$(OUTPUT_NAME).elf $(EXP_OBJS) -lRRFLibraries -lCoreN2G -lCANlib -lFreeRTOS -lpico -lRRFLibraries -lCoreN2G -lCANlib -lFreeRTOS -lpico
	$(V)$(OBJCOPY) --strip-unneeded -O binary $(BUILD_DIR)/$(OUTPUT_NAME).elf $(BUILD_DIR)/$(OUTPUT_NAME).bin
	$(V)$(SIZE) $(BUILD_DIR)/$(OUTPUT_NAME).elf
#	$(V)python $(REPRAPFIRMWARE_DIR)/Tools/uf2conv/uf2conv.py  -b 0x10000000 -f 0xe48bff56 -c -o $(BUILD_DIR)/$(OUTPUT_NAME).uf2 $(BUILD_DIR)/$(OUTPUT_NAME).bin
	$(V)$(COREN2G_DIR)/src/RP2040/picotool/picotool uf2 convert $(BUILD_DIR)/$(OUTPUT_NAME).elf -t elf $(BUILD_DIR)/$(OUTPUT_NAME).uf2
$(BUILD_DIR)/$(FREERTOS_DIR)/%.o : $(FREERTOS_DIR)/%.c
	@echo "[$<]"
	$(V)$(MKDIR) $(dir $@)
	$(V)$(CC)  $(CFLAGS) $(DEFINES) $(INCLUDES) -MMD -MP -MM -MF $(patsubst %.o,%.d,$@) $<
	$(V)$(CC)  $(CFLAGS) $(DEFINES) $(INCLUDES) -MMD -MP -o $@ $<

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

$(BUILD_DIR)/$(COREN2G_DIR)/%.o : $(COREN2G_DIR)/%.cpp
	@echo "CORE [$<]"
	$(V)$(MKDIR) $(dir $@)
	$(V)$(CXX) $(CXXFLAGS_CORE) $(DEFINES) $(INCLUDES) -MMD -MP -MM -MF $(patsubst %.o,%.d,$@) $<
#	$(V)$(CXX) -Wa,-ahl=$@.s $(CXXFLAGS_CORE) $(DEFINES) $(INCLUDES) -MMD -MP -o $@ $<
	$(V)$(CXX) $(CXXFLAGS_CORE) $(DEFINES) $(INCLUDES) -MMD -MP -o $@ $<

$(BUILD_DIR)/$(CANLIB_DIR)/%.o : $(CANLIB_DIR)/%.cpp
	@echo "CANLIB [$<]"
	$(V)$(MKDIR) $(dir $@)
	$(V)$(CXX) $(CXXFLAGS_CANLIB) $(DEFINES) $(INCLUDES) -MMD -MP -MM -MF $(patsubst %.o,%.d,$@) $<
	$(V)$(CXX) $(CXXFLAGS_CANLIB) $(DEFINES) $(INCLUDES) -MMD -MP -o $@ $<

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

$(BUILD_DIR)/$(COREN2G_DIR)/%.o: $(COREN2G_DIR)/%.S
	@echo "[$<]"
	$(V)$(MKDIR) $(dir $@)
	$(V)$(CXX) -x assembler-with-cpp $(CXXFLAGS) $(DEFINES) $(INCLUDES) -MMD -MP -MM -MF $(patsubst %.o,%.d,$@) $<
	$(V)$(CXX) -x assembler-with-cpp $(CXXFLAGS) $(DEFINES) $(INCLUDES) -MMD -MP -o $@ $<

$(BUILD_DIR)/%.o: %.S
	@echo "[$<]"
	$(V)$(MKDIR) $(dir $@)
	$(V)$(CXX) -x assembler-with-cpp $(CXXFLAGS) $(DEFINES) $(INCLUDES) -MMD -MP -MM -MF $(patsubst %.o,%.d,$@) $<
	$(V)$(CXX) -x assembler-with-cpp $(CXXFLAGS) $(DEFINES) $(INCLUDES) -MMD -MP -o $@ $<

clean: distclean

distclean:
	-rm -rf $(BUILD_DIR)/ 

.PHONY: all firmware clean distclean $(BUILD_DIR)/$(OUTPUT_NAME).elf
