CORE_DIR = $(COREN2G_DIR)


#Core
CORE_SRC_DIRS  = src src/RP2040 src/RP2040/include/$(MCU_DIR)/pico_base src/RP2040/MCP2517FD src/RP2040/SharedSPI src/SPI src/I2C

CORE_SRC = $(CORE_DIR) $(addprefix $(CORE_DIR)/, $(CORE_SRC_DIRS))
CORE_INCLUDES = $(addprefix -I, $(CORE_SRC))
SDK_INCLUDE_DIRS = boards/include common/pico_base_headers/include common/pico_sync/include common/pico_time/include rp2_common/cmsis/include rp2_common/hardware_base/include
SDK_INCLUDE_DIRS += rp2_common/hardware_dma/include rp2_common/hardware_gpio/include rp2_common/hardware_irq/include rp2_common/hardware_sync/include rp2_common/hardware_timer/include
SDK_INCLUDE_DIRS += rp2_common/hardware_watchdog/include $(MCU_DIR)/pico_platform/include $(MCU_DIR)/hardware_regs/include $(MCU_DIR)/hardware_structs/include
SDK_INCLUDE_DIRS += rp2_common/cmsis/stub/CMSIS/Core/include rp2_common/cmsis/stub/CMSIS/Device/RP2040/Include rp2_common/hardware_adc/include rp2_common/pico_platform_compiler/include
SDK_INCLUDE_DIRS += rp2_common/pico_unique_id/include rp2_common/hardware_pwm/include rp2_common/pico_multicore/include rp2_common/hardware_pio/include rp2_common/pico_platform_sections/include
SDK_INCLUDE_DIRS += rp2_common/hardware_spi/include rp2_common/hardware_i2c/include rp2_common/pico_bootrom/include rp2_common/hardware_flash/include rp2_common/pico_platform_panic/include
SDK_INCLUDE_DIRS += rp2_common/hardware_sync_spin_lock/include rp2_common/pico_runtime_init/include rp2_common/pico_runtime/include common/pico_stdlib_headers/include
SDK_INCLUDE_DIRS += rp2_common/pico_stdio/include rp2_common/hardware_uart/include rp2_common/hardware_resets/include rp2_common/hardware_clocks/include rp2_common/hardware_ticks/include
SDK_INCLUDE_DIRS += rp2_common/pico_platform_common/include
SDK_INCLUDE_PATHS = $(addprefix $(SDK_DIR)/src/, $(SDK_INCLUDE_DIRS))
SDK_INCLUDE_PATHS += $(addprefix $(SDK_DIR)/, lib/tinyusb/src)
SDK_INCLUDES = $(addprefix -I, $(SDK_INCLUDE_PATHS))
#Find all c and c++ files for Core
CORE_OBJ_SRC_C    += $(foreach src, $(CORE_SRC), $(wildcard $(src)/*.c))
CORE_OBJ_SRC_CXX   += $(foreach src, $(CORE_SRC), $(wildcard $(src)/*.cpp))
CORE_OBJS = $(patsubst %.c,$(BUILD_DIR)/%.o,$(CORE_OBJ_SRC_C)) $(patsubst %.cpp,$(BUILD_DIR)/%.o,$(CORE_OBJ_SRC_CXX))
