
#RTOS location
RTOS_SRC = $(FREERTOS_DIR)/src
RTOS_INCLUDE = $(RTOS_SRC)/include/
ifeq ($(PROCESSOR),RP2040)
RTOS_SRC_PORTABLE = $(RTOS_SRC)/portable/GCC/ARM_CM0
endif
ifeq ($(PROCESSOR),RP2350)
RTOS_SRC_PORTABLE = $(RTOS_SRC)/portable/GCC/ARM_CM33_NTZ/non_secure
endif


RTOS_CONFIG_INCLUDE = CoreN2G/src/RP2040/FreeRTOSConfig



#RTOS Sources (selected dirs only)
RTOS_CORE_SRC    += $(RTOS_SRC) $(RTOS_SRC_PORTABLE)
RTOS_CORE_OBJ_SRC_C  += $(foreach src, $(RTOS_CORE_SRC), $(wildcard $(src)/*.c) )
#RTOS Dynamic Memory Management
#RTOS_CORE_OBJ_SRC_C  += $(RTOS_SRC)/portable/MemMang/heap_5.c

RTOS_OBJS += $(patsubst %.c,$(BUILD_DIR)/%.o,$(RTOS_CORE_OBJ_SRC_C))

#RTOS Includes
RTOS_INCLUDES   += -I$(RTOS_INCLUDE) -I$(RTOS_SRC_PORTABLE)
RTOS_INCLUDES   += -I$(RTOS_CONFIG_INCLUDE)

