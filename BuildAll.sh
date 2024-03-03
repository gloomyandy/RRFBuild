#!/bin/sh
./BuildRelease.sh Debug STM32 STM32H7 STM32H743 WIFI firmware-stm32h7-wifi
./BuildRelease.sh Debug STM32 STM32H7 STM32H723 WIFI firmware-stm32h723-wifi
./BuildRelease.sh Debug STM32 STM32H7 STM32H723 SBC firmware-stm32h723-sbc
./BuildRelease.sh Debug STM32 STM32H7 STM32H743 SBC firmware-stm32h7-sbc
./BuildRelease.sh Debug STM32 STM32F4 "" SBC
./BuildRelease.sh Debug STM32 STM32F4 "" WIFI
./BuildIAPRelease.sh Debug STM32 STM32H7 STM32H723 SBC firmware-stm32h723-sbc stm32h723_iap_SBC
./BuildIAPRelease.sh Debug STM32 STM32H7 STM32H743 SBC firmware-stm32h7-sbc stm32h7_iap_SBC
./BuildIAPRelease.sh Debug STM32 STM32F4 "" SBC firmware-stm32f4-sbc stm32f4_iap_SBC
./BuildIAPBLRelease.sh Debug STM32 STM32H7 2
./BuildExpRelease.sh Debug RP2040 FLY36RRF 0 "-DUSE_PICOCAN" "FLY36RRF-picocan"
./BuildExpRelease.sh Debug RP2040 FLY36RRF 1 "-DUSE_SPICAN" "FLY36RRF"
./BuildExpRelease.sh Debug RP2040 FLYSB2040V1_0 0 "-DUSE_PICOCAN" "FLYSB2040V1_0-picocan"
./BuildExpRelease.sh Debug RP2040 SHT36 3 "-DUSE_SPICAN" "SHT36V3"
./BuildExpRelease.sh Debug RP2040 MKSTHR3642 1 "-DUSE_PICOCAN" "MKSTHR3642v1_0-picocan"
./BuildExpRelease.sh Debug RP2040 PITBV1_0 0 "-DUSE_PICOCAN" "PITBV1_0-picocan"
./BuildExpRelease.sh Debug RP2040 PITBV2_0 0 "-DUSE_SPICAN" "PITBV2_0"
./BuildExpRelease.sh Debug RP2040 STRIDEMAXV2_0 0 "-DUSE_SPICAN" "STRIDEMAXV2_0"
./BuildBoardRelease.sh Debug STM32H7 SBC fly_super5
./BuildBoardRelease.sh Debug STM32H7 WIFI fly_super5
./BuildBoardRelease.sh Debug STM32H7 SBC fly_super8_pro
./BuildBoardRelease.sh Debug STM32H7 WIFI fly_super8_pro
./BuildBoardRelease.sh Debug STM32H7 SBC biquskr_se_bx_2.0
./BuildBoardRelease.sh Debug STM32H7 WIFI biquskr_se_bx_2.0
./BuildBoardRelease.sh Debug STM32H7 SBC biquskr_3
./BuildBoardRelease.sh Debug STM32H7 WIFI biquskr_3
./BuildBoardRelease.sh Debug STM32H723 SBC fly_super5_h723
./BuildBoardRelease.sh Debug STM32H723 WIFI fly_super5_h723
./BuildBoardRelease.sh Debug STM32H723 SBC fly_super8_pro_h723
./BuildBoardRelease.sh Debug STM32H723 WIFI fly_super8_pro_h723
./BuildBoardRelease.sh Debug STM32H723 SBC fly_openpnp_tool
./BuildBoardRelease.sh Debug STM32H723 WIFI fly_openpnp_tool
./BuildBoardRelease.sh Debug STM32H723 SBC biquskr_3_h723
./BuildBoardRelease.sh Debug STM32H723 WIFI biquskr_3_h723
./BuildBoardRelease.sh Debug STM32H723 SBC biqukraken_h723
./BuildBoardRelease.sh Debug STM32H723 WIFI biqukraken_h723
./BuildBoardRelease.sh Debug STM32H723 SBC biquoctopuspro_V1.1_h723
./BuildBoardRelease.sh Debug STM32H723 WIFI biquoctopuspro_V1.1_h723
./BuildBoardRelease.sh Debug STM32H723 SBC fysetc_spider_king723
./BuildBoardRelease.sh Debug STM32H723 WIFI fysetc_spider_king723
./BuildBoardRelease.sh Debug STM32F4 SBC biquskrpro_1.1
./BuildBoardRelease.sh Debug STM32F4 WIFI biquskrpro_1.1
./BuildBoardRelease.sh Debug STM32F4 SBC biqugtr_1.0
./BuildBoardRelease.sh Debug STM32F4 WIFI biqugtr_1.0
./BuildBoardRelease.sh Debug STM32F4 SBC fly_e3_pro
./BuildBoardRelease.sh Debug STM32F4 WIFI fly_e3_pro
./BuildBoardRelease.sh Debug STM32F4 SBC fly_e3_prov3
./BuildBoardRelease.sh Debug STM32F4 WIFI fly_e3_prov3
./BuildBoardRelease.sh Debug STM32F4 SBC fly_f407zg
./BuildBoardRelease.sh Debug STM32F4 WIFI fly_f407zg
./BuildBoardRelease.sh Debug STM32F4 WIFI fly_e3
./BuildBoardRelease.sh Debug STM32F4 WIFI fly_e3_v2
./BuildBoardRelease.sh Debug STM32F4 WIFI fly_cdyv2
./BuildBoardRelease.sh Debug STM32F4 WIFI fly_cdyv3
./BuildBoardRelease.sh Debug STM32F4 WIFI fly_super8
./BuildBoardRelease.sh Debug STM32F4 SBC fly_gemini
./BuildBoardRelease.sh Debug STM32F4 SBC fly_geminiv1.1 
./BuildBoardRelease.sh Debug STM32F4 SBC fly_geminiv2.0
./BuildBoardRelease.sh Debug STM32F4 SBC fly_geminiv3.0
./BuildBoardRelease.sh Debug STM32F4 WIFI biquskr_rrf_e3_1.1
./BuildBoardRelease.sh Debug STM32F4 WIFI biquskr_2
./BuildBoardRelease.sh Debug STM32F4 SBC biquskr_2
./BuildBoardRelease.sh Debug STM32F4 WIFI biquoctopus_1.1
./BuildBoardRelease.sh Debug STM32F4 SBC biquoctopus_1.1
./BuildBoardRelease.sh Debug STM32F4 WIFI biquoctopuspro_1.0
./BuildBoardRelease.sh Debug STM32F4 SBC biquoctopuspro_1.0
./BuildBoardRelease.sh Debug STM32F4 WIFI troodon_v2
./BuildBoardRelease.sh Debug STM32F4 WIFI fysetc_spider
./BuildBoardRelease.sh Debug STM32F4 SBC fysetc_spider
./BuildBoardRelease.sh Debug STM32F4 WIFI fysetc_spider_king407
