#---RepRapFirmware---
RRF_SRC_BASE  = $(REPRAPFIRMWARE_DIR)/src

#end RRF

#Libc and libcpp in RRF
RRFLIBC_SRC_DIRS = libc libcpp
ifeq ($(CONFIG),IAP_BOOT_LOADER)
RRFLIBC_SRC_DIRS += targets/STM32/FatFS
endif
RRFLIBC_SRC = $(addprefix $(RRF_SRC_BASE)/, $(RRFLIBC_SRC_DIRS))
RRFLIBC_OBJ_SRC_C	  += $(foreach src, $(RRFLIBC_SRC), $(wildcard $(src)/*.c) ) 
RRFLIBC_OBJ_SRC_CXX   += $(foreach src, $(RRFLIBC_SRC), $(wildcard $(src)/*.cpp) )
RRFLIBC_OBJ_SRC_CC    += $(foreach src, $(RRFLIBC_SRC), $(wildcard $(src)/*.cc) )
RRFLIBC_OBJ_SRC_C	  += $(RRF_SRC_BASE)/targets/common/FatFS/ff.c  $(RRF_SRC_BASE)/targets/common/FatFS/ffunicode.c

RRFLIBC_INCLUDES = $(addprefix -I, $(RRFLIBC_SRC))
ifeq ($(CONFIG),IAP_BOOT_LOADER)
RRFLIBC_INCLUDES += -I$(RRF_SRC_BASE)/targets/common/FatFS/
endif
RRFLIBC_OBJS = $(patsubst %.c,$(BUILD_DIR)/%.o,$(RRFLIBC_OBJ_SRC_C)) $(patsubst %.cpp,$(BUILD_DIR)/%.o,$(RRFLIBC_OBJ_SRC_CXX))
RRFLIBC_OBJS += $(patsubst %.cc,$(BUILD_DIR)/%.o,$(RRFLIBC_OBJ_SRC_CC))


#


