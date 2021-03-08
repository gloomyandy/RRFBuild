Timers
======
* TIM1 : Software UART (16bit Baud rate * 4 (overampling))
* TIM2 : Hardware PWM
* TIM3 : Hardware PWM
* TIM4 : Hardware PWM
* TIM5 : Step Timer (32 bit 1MHz)
* TIM6 : Unused
* TIM7 : Software PWM (16 bit 1MHz)
* TIM8 : Hardware PWM
* TIM9 : Hardware PWM
* TIM10 : Hardware PWM
* TIM11 : Hardware PWM
* TIM12 : Hardware PWM
* TIM13 : Hardware PWM
* TIM14 : Hardware PWM
* WWDG : Watchdog

SPI
===
* SPI1 : Shared SPI, Master, main usage SD card interface, does not use DMA
* SPI2 : Slave, SBC or WiFi interface, uses DMA (DMA1_Stream3, DMA1_Stream4)
* SPI3 : Shared SPI, Master, main usage TMC SPI interface
* SWSSP0 : Software SPI, Shared, main usage Thermocouples etc.
* SWSSP1 : Software SPI, Shared, main usage LCD display
* SWSSP2 : Software SPI, shared, main usage TMC SPI interface

SDIO
====
* SDIO : SD card interface on some boards, uses DMA (DMA2_Stream3, DMA2_Stream6)

ADC
===
* ADC1 : 12Bit Analog in + internal ref, uses DMA (DMA2_Stream4)
* ADC2 : unused
* ADC3 : 12Bit Analog in, uses DMA (DMA2_Stream0)

DMA
===
* DMA1_Stream0 : SPI3 RX
* DMA1_Stream1 : Unused
* DMA1_Stream2 : Unused
* DMA1_Stream3 : SPI2 RX
* DMA1_Stream4 : SPI2 TX
* DMA1_Stream5 : SPI3 TX
* DMA1_Stream6 : unused
* DMA1_Stream7 : unused
* DMA2_Stream0 : ADC3
* DMA2_Stream1 : unused
* DMA2_Stream2 : unused
* DMA2_Stream3 : SDIO RX
* DMA2_Stream4 : ADC1
* DMA2_Stream5 : TIM1/GPIO (Soft UART)
* DMA2_Stream6 : SDIO TX
* DMA2_Stream7 : unused

CRC Unit
========
* CRC32 : Used for file I/O and SBC buffers

Flash Memory
============
* 0x8000000 : 32K Bootloader (provided by board)
* 0x8008000 : 16K Interrupt vectors and startup code (bootloader starts loading here)
* 0x800C000 : 16K Reset data (holds diagnostics from previous board resets)
* 0x8010000 : 1024K - 64K Main firmware start

RAM
===
* 0x20000000 : 128K General purpose RAM
* 0x10000000 : 64K CCMRAM unused
