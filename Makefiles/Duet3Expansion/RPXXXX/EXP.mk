#---EXP---
EXP_SRC_BASE  = $(EXP_DIR)/src

EXP_SRC_DIRS = CAN ClosedLoop CommandProcessing Config Fans FilamentMonitors GPIO Hardware/RP2040 Hardware Heating Heating/Sensors InputMonitors 
EXP_SRC_DIRS += Movement Movement/StepperDrivers Movement/Kinematics Hardware/Drivers Platform LedStrips libc
#Find the c and cpp source files
EXP_SRC = $(addprefix $(EXP_SRC_BASE)/, $(EXP_SRC_DIRS)) $(EXP_SRC_BASE)
EXP_OBJ_SRC_C	   += $(foreach src, $(EXP_SRC), $(wildcard $(src)/*.c) ) 
EXP_OBJ_SRC_CXX   += $(foreach src, $(EXP_SRC), $(wildcard $(src)/*.cpp) )

EXP_OBJS = $(patsubst %.c,$(BUILD_DIR)/%.o,$(EXP_OBJ_SRC_C)) $(patsubst %.cpp,$(BUILD_DIR)/%.o,$(EXP_OBJ_SRC_CXX))
ifeq ($(PROCESSOR),RP2040)
EXP_OBJS += $(EXP_SRC_BASE)/Hardware/RP2040/boot2_w25q080_2_padded_checksum.o
endif
EXP_INCLUDES = $(addprefix -I, $(EXP_SRC))

#end IAP


