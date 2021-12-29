CORE ?= STM32
MCU ?= STM32F4
MAKE_DIR ?= CoreN2G/src/$(CORE)/makefiles/$(MCU)
include $(MAKE_DIR)/makefile
