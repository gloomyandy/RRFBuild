CORE_DIR = $(CORESTM_DIR)


#Core
CORE_SRC_DIRS  = src src/STM32BTC src/STM32BTC/DMA
CORE_SRC_DIRS += src/STM32BTC/system src/SPI
CORE_SRC_DIRS += src/STM32BTC/system/STM32H7xx/CMSIS/Device/ST/STM32H7xx/Include
CORE_SRC_DIRS += src/STM32BTC/system/STM32H7xx/STM32H7xx_HAL_Driver/Inc src/STM32BTC/system/STM32H7xx/STM32H7xx_HAL_Driver/Src
CORE_SRC_DIRS += src/STM32BTC/system/STM32H7xx/CMSIS/Core/Include
CORE_SRC_DIRS += src/STM32BTC/variants/$(VARIANT) src/STM32BTC/ConfigurableUART src/STM32BTC/SharedSPI src/STM32BTC/PWM src/STM32BTC/SDIO src/STM32BTC/CRC32
ifneq ($(USETINYUSB), true)
    CORE_SRC_DIRS += src/STM32BTC/usb2
endif

CORE_SRC = $(CORE_DIR) $(addprefix $(CORE_DIR)/, $(CORE_SRC_DIRS))
CORE_INCLUDES = $(addprefix -I, $(CORE_SRC))

#Find all c and c++ files for Core
CORE_OBJ_SRC_C    += $(foreach src, $(CORE_SRC), $(wildcard $(src)/*.c))
CORE_OBJ_SRC_CXX   += $(foreach src, $(CORE_SRC), $(wildcard $(src)/*.cpp))
CORE_OBJS = $(patsubst %.c,$(BUILD_DIR)/%.o,$(CORE_OBJ_SRC_C)) $(patsubst %.cpp,$(BUILD_DIR)/%.o,$(CORE_OBJ_SRC_CXX))
CORE_OBJS += $(BUILD_DIR)/CoreN2G/src/STM32BTC/startup_stm32yyxx.o
