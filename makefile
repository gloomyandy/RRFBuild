CORE ?= STM32
MCU ?= STM32H7
PROJECT ?= RepRapFirmware
MAKE_DIR ?= Makefiles/$(PROJECT)/$(MCU)
include $(MAKE_DIR)/makefile
