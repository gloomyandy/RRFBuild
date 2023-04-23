CORE ?= STM32
MCU ?= STM32F4
MAKE_DIR ?= CoreN2G/src/$(CORE)/makefiles/$(MCU)
GCC_PATH ?= "/c/Program Files (x86)/GNU Arm Embedded Toolchain/10 2021.10/bin/"
include $(MAKE_DIR)/makefile
