#
#  Copyright (c) 2020, The OpenThread Authors.
#  All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions are met:
#  1. Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
#  2. Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
#  3. Neither the name of the copyright holder nor the
#     names of its contributors may be used to endorse or promote products
#     derived from this software without specific prior written permission.
#
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
#  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
#  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
#  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
#  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
#  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
#  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
#  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
#  POSSIBILITY OF SUCH DAMAGE.
#

add_executable(ot-central-controller
    temperature_map.cpp
    cli_uart.cpp
    main.c
)

target_include_directories(ot-central-controller PRIVATE ${COMMON_INCLUDES})

if(NOT DEFINED OT_PLATFORM_LIB_FTD)
    set(OT_PLATFORM_LIB_FTD ${OT_PLATFORM_LIB})
endif()

target_link_libraries(ot-central-controller PRIVATE
    openthread-cli-ftd
    ${OT_PLATFORM_LIB_FTD}
    openthread-ftd
    ${OT_PLATFORM_LIB_FTD}
    openthread-cli-ftd
    ${OT_MBEDTLS}
    ot-config-ftd
    ot-config
)

if(OT_LINKER_MAP)
    if("${CMAKE_CXX_COMPILER_ID}" MATCHES "AppleClang")
        target_link_libraries(ot-central-controller PRIVATE -Wl,-map,ot-central-controller.map)
    else()
        target_link_libraries(ot-central-controller PRIVATE -Wl,-Map=ot-central-controller.map)
    endif()
endif()

install(TARGETS ot-central-controller
    DESTINATION bin)
