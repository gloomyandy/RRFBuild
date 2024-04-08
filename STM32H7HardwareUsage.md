Introduction
============
This document provides a brief overview of how the STM32H73/STM32H742 version of RRF makes use of the
MCU hardware.

GPIO
====
RRF makes use of the interrupt on change EXI feature for the WiFi, accelerometer, 
some filament sensors and the DHT sensor interfaces. This requires that the pins 
selected for these functions must be on different pins within a port. I.E.
if pin A.1 is used then no other 1 pin (B.1, C.1 etc) can be used. This applies
to the following GPIO pins:
* ESPTfrReady
* ESP chip select
* Accelerometer int1pin
* Other pins that may be used for filament sensors

GPIO pins are used to drive the stepper motor step/dir pins. If all of the step pins
are on the same port the RRF can use a more efficient mechanism when stepping multiple
drivers.

Timers
======
* TIM1 : Software UART (16bit Baud rate * 4 (oversampling)) and Neopixels
* TIM2 : Hardware PWM
* TIM3 : Hardware PWM
* TIM4 : Hardware PWM
* TIM5 : Step Timer (32 bit 750KHz)
* TIM6 : Unused
* TIM7 : Software PWM (16 bit 1MHz)
* TIM8 : Hardware PWM
* TIM12 : Hardware PWM
* TIM13 : Hardware PWM
* TIM14 : Hardware PWM
* TIM15 : Hardware PWM
* TIM16 : Hardware PWM
* TIM17 : Hardware PWM
* IWDG : Watchdog

PWM outputs
===========
* Hardware PWM is provided using the STM32F4 timers
* Each timer can drive up to 4 GPIO pins, all pins sharing a timer must use the same base frequency
* RRF supports up to 16 software driven PWM channels, these may be used with any GPIO pin

The current allocation of pins to timers may vary between STM32H723 and STM32H743 boards the current allocation
can be found here:
CoreN2G\src\STM32\variants\STM32H723\PeripheralPins.c
CoreN2G\src\STM32\variants\STM32H743\PeripheralPins.c

In the current release there is a fixed mapping between a selected pin and the timer used to
drive it via PWM. Future versions may relax this and allow the selection of timer based on
pin and selected frequency.

SPI
===
* SPI1 : Shared SPI, Master, uses DMA (DMA1_Stream6, DMA1_Stream7)
* SPI2 : Slave, SBC or WiFi interface, uses DMA (DMA1_Stream3, DMA1_Stream4)
* SPI3 : Shared SPI, Master, main usage TMC SPI interface (DMA1_Stream5, DMA1_Stream0) 
* SPI4 : Shared SPI, Master, main usage TMC SPI interface (DMA1_Stream1, DMA1_Stream2) 
* SPI5 : Shared SPI, Master 
* SPI6 : Shared SPI, Master
* SWSSP0 : Software SPI, Shared, main usage Thermocouples etc.
* SWSSP1 : Software SPI, Shared, main usage LCD display
* SWSSP2 : Software SPI, shared, main usage TMC SPI interface

Note the above usage for SPI1/SPI4 is the the most common configuration. It is possible
to operate these devices in Master or Slave mode and all make use of DMA.

SDIO
====
* SDIO : SD card interface on some boards, uses the built in SDIO DMA interface

ADC
===
* ADC1 : 12Bit Analog in + internal ref + mcu temp, uses DMA (DMA2_Stream4)
* ADC2 : unused
* ADC3 : 12Bit Analog in, uses DMA (DMA2_Stream0)
RRF currently uses the ADC in 12 mode along with oversampling to provide an effective 14bit resolution.

DMA
===
* DMA1_Stream0 : SPI3 RX
* DMA1_Stream1 : SPI4
* DMA1_Stream2 : SPI4
* DMA1_Stream3 : SPI2 RX
* DMA1_Stream4 : SPI2 TX
* DMA1_Stream5 : SPI3 TX
* DMA1_Stream6 : SPI1
* DMA1_Stream7 : SPI1
* DMA2_Stream0 : ADC3
* DMA2_Stream1 : unused
* DMA2_Stream2 : unused
* DMA2_Stream3 : unused
* DMA2_Stream4 : ADC1
* DMA2_Stream5 : TIM1/GPIO (Soft UART/NeoPixels)
* DMA2_Stream6 : unused
* DMA2_Stream7 : unused

CRC Unit
========
* CRC32 : Used for file I/O and SBC buffers

USARTs
======
RRF currently uses only two serial devices, AUX and the WiFi interface. These are
mapped based upon the selected pins to an actual hardware UART device. In versions 
prior to V3.3-beta3 the only hardware UARTS enabled were 1, 3 and 6. In v3.3-beta3
and later UARTS 1-6 are all available.

TMC drivers that have a UART interface are driven via a DMA based software UART
that can drive any pin in half duplex mode.

Flash Memory
============
STM32H723:
* 0x8000000 : 128K Bootloader (provided by board)
* 0x8020000 : 1024K - 256K Interrupt vectors and RRF
* 0x80E0000 : 128K Reset data (holds diagnostics from previous board resets)

RAM
===
    DTCMRAM 0x20000000:	128K Unused
    ITCMRAM	0x00000000: 64K Unused
    RAM_D1 0x24000000: 320K - 32K General purpose RAM
    RAM_D1NC 0x24048000: 32K SD card Buffers (must be in D1 RAM and not cached for DMA access)
    RAM_D2 0x30000000: 32K I/O buffers (must not be cached for DMA usage)
    RAM_D3 0x38000000: 16K Unused

STM32H743:
* 0x8000000 : 128K Bootloader (provided by board)
* 0x8020000 : 2048K - 256K Interrupt vectors and RRF
* 0x81E0000 : 128K Reset data (holds diagnostics from previous board resets)

RAM
===
    DTCMRAM 0x20000000:	128K Unused
    ITCMRAM	0x00000000: 64K Unused
    RAM_D1 0x24000000: 512K - 64K General purpose RAM
    RAM_D1NC 0x24070000: 64K SD card Buffers (must be in D1 RAM and not cached for DMA access)
    RAM_D2 0x30000000: 288K I/O buffers (must not be cached for DMA usage)
    RAM_D3 0x38000000: 64K Unused

CAN-FD
======
CAN-FD support is provided via the built in CAN-FD module. RRF uses FDCAN1, FDCAN2 is currently
unused.

SD Card access and RRF configuration
====================================
To enable RRF to operate on a number of different boards it uses a file (board.txt) to specify how the
hardware is configured. However this means we need to be able to identify how to access the SD card on
a particular board. From version 3.5.0-rc.4 onwards we use a small in flash file system to contains two
files rrfboot.txt and rrfpins.txt these files hold information about the board hardware (and so are
different for each board) and pin usage. This information is loaded at boot time before any user supplied
board.txt file is loaded. 