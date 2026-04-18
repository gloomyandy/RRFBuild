
#RTOS location
RTOS_SRC = $(FREERTOS_DIR)/src
RTOS_INCLUDE = $(RTOS_SRC)/include/
RTOS_SRC_PORTABLE = $(RTOS_SRC)/portable/GCC/ARM_CM4F

RTOS_CONFIG_INCLUDE = CoreN2G/src/STM32/FreeRTOSConfig



#RTOS Sources (selected dirs only)
RTOS_CORE_SRC    += $(RTOS_SRC) $(RTOS_SRC_PORTABLE)
RTOS_CORE_OBJ_SRC_C  += $(foreach src, $(RTOS_CORE_SRC), $(wildcard $(src)/*.c) )
#RTOS Dynamic Memory Management
#RTOS_CORE_OBJ_SRC_C  += $(RTOS_SRC)/portable/MemMang/heap_5.c

CORE_OBJS += $(patsubst %.c,$(BUILD_DIR)/%.o,$(RTOS_CORE_OBJ_SRC_C))

#RTOS Includes
CORE_INCLUDES   += -I$(RTOS_INCLUDE) -I$(RTOS_SRC_PORTABLE)
CORE_INCLUDES   += -I$(RTOS_CONFIG_INCLUDE)
