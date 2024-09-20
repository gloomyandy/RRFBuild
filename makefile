CORE ?= STM32
MCU ?= STM32F4
MAKE_DIR ?= RepRapFirmware/makefiles/$(MCU)
GCC_PATH ?= "/c/Program Files (x86)/Arm GNU Toolchain arm-none-eabi/12.2 mpacbti-rel1/bin/"
include $(MAKE_DIR)/makefile
