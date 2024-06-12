#!/bin/bash

set -e 

# Update submodule to correct submodule.
git submodule update --init --recursive 

# In an effort to use submodules for OpenThread and the ot-nrf528xx
# repos, we copy the app and an updated CMake file into the openthread
# repo to utilize the default build system.
cp -r tutorial_app/central_controller_app ot-nrf528xx/openthread/examples/apps 
cp tutorial_app/CMakeLists.txt ot-nrf528xx/openthread/examples/apps

# Invoke build script within ot-nrf528xx repo, convert to hex file,
# and flash the file to the board.
cd ot-nrf528xx
./script/build nrf52840 UART_trans
arm-none-eabi-objcopy -O ihex build/bin/ot-central-controller ot-central-controller.hex
nrfjprog -f nrf52 --chiperase --program ot-central-controller.hex --reset --verify

