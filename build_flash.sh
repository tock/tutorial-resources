#!/bin/bash

cd ot-nrf528xx
./script/build nrf52840 UART_trans
arm-none-eabi-objcopy -O ihex build/bin/ot-central-controller ot-central-controller.hex
nrfjprog -f nrf52 --chiperase --program ot-central-controller.hex --reset --verify

