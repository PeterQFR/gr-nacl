# Copyright 2020 Free Software Foundation, Inc.
#
# This file is part of GNU Radio
#
# SPDX-License-Identifier: GPL-3.0-or-later
#

########################################################################
# Check if there is C++ code at all
########################################################################
if(NOT nacl_sources)
    message(STATUS "No C++ sources... skipping python bindings")
    return()
endif(NOT nacl_sources)

########################################################################
# Check for pygccxml
########################################################################
gr_python_check_module_raw("pygccxml" "import pygccxml" PYGCCXML_FOUND)

include(GrPybind)

########################################################################
# Python Bindings
########################################################################

list(APPEND nacl_python_files
    crypt_tagged_stream_python.cc
    decrypt_public_python.cc
    decrypt_secret_python.cc
    encrypt_public_python.cc
    encrypt_secret_python.cc
    generate_key_python.cc
    generate_keypair_python.cc python_bindings.cc)

gr_pybind_make_oot(nacl ../../.. gr::nacl "${nacl_python_files}" EXTRA_ARGS "--defines ''")

# copy bindings extension for use in QA test module
add_custom_command(
    TARGET nacl_python
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:nacl_python>
            ${PROJECT_BINARY_DIR}/test_modules/gnuradio/nacl/)

install(
    TARGETS nacl_python
    DESTINATION ${GR_PYTHON_DIR}/gnuradio/nacl
    COMPONENT pythonapi)
