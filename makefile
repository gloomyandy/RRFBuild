CORE ?= STM32
MCU ?= STM32F4
MAKE_DIR ?= RepRapFirmware/makefiles/$(MCU)
include $(MAKE_DIR)/makefile
