find_package(PkgConfig)

PKG_CHECK_MODULES(PC_GR_NACL gnuradio-nacl)

FIND_PATH(
    GR_NACL_INCLUDE_DIRS
    NAMES gnuradio/nacl/api.h
    HINTS $ENV{NACL_DIR}/include
        ${PC_NACL_INCLUDEDIR}
    PATHS ${CMAKE_INSTALL_PREFIX}/include
          /usr/local/include
          /usr/include
)

FIND_LIBRARY(
    GR_NACL_LIBRARIES
    NAMES gnuradio-nacl
    HINTS $ENV{NACL_DIR}/lib
        ${PC_NACL_LIBDIR}
    PATHS ${CMAKE_INSTALL_PREFIX}/lib
          ${CMAKE_INSTALL_PREFIX}/lib64
          /usr/local/lib
          /usr/local/lib64
          /usr/lib
          /usr/lib64
          )

include("${CMAKE_CURRENT_LIST_DIR}/gnuradio-naclTarget.cmake")

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(GR_NACL DEFAULT_MSG GR_NACL_LIBRARIES GR_NACL_INCLUDE_DIRS)
MARK_AS_ADVANCED(GR_NACL_LIBRARIES GR_NACL_INCLUDE_DIRS)
