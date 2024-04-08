RepRap Firmware LPC/STM32F4 Port unified build
==================================

This repository contains the build system for the LPC and STM32F4 port of RRF V3.3 and later.

To build RRF you will require additional repositories. These should be cloned into the RRFBuild directory. To create a specific version of RRF please checkout the various branches using the associated tags.
* RepRapFirmware - the main RRF source code https://github.com/gloomyandy/RepRapFirmware
* RRFLibraries - Support libraries for RRF https://github.com/gloomyandy/RRFLibraries
* CoreN2G - MCU specific support for LPC and STM32F4 builds https://github.com/gloomyandy/CoreN2G
* FreeRTOS - RTOS support package https://github.com/gloomyandy/FreeRTOS
* CANLib - Common files used by CAN and standard build https://github.com/gloomyandy/CANlib
* DuetWifiSocketServer - WiFi interface https://github.com/gloomyandy/DuetWiFiSocketServer
* Duet3Expansion - CAN-FD expansion board firmware https://github.com/gloomyandy/Duet3Expansion
* IAP - Bootloader and SBC update firmware https://github.com/gloomyandy/IAP
The latest WiFi firmware (version 2) should also be checked out (but uses different tags):
* ESP32 SDK: https://github.com/gloomyandy/esp-idf/tree/dwss_support_2.1
* ESP8266 SDK: https://github.com/Duet3D/ESP8266_RTOS_SDK/tree/dwss_support
* WifiSocketServer: https://github.com/gloomyandy/WiFiSocketServerRTOS/commits/ethernet/

