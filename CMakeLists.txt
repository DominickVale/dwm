cmake_minimum_required(VERSION 3.19)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)
set(CMAKE_C_COMPILER "cc")
project(dwm VERSION 6.2 LANGUAGES C)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release")
else()
  message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
endif()
 
find_package(X11 REQUIRED COMPONENTS Xinerama Xft xcb)
find_package(Yajl REQUIRED)
find_package(Freetype REQUIRED)
find_package(Xcb REQUIRED COMPONENTS RES)
find_package(Fontconfig REQUIRED)

set(LIBS
  ${X11_LIBRARIES}
  X11::Xft
  ${X11_X11_xcb_LIB}
  ${Xcb_LIBRARIES}
  ${Xcb_RES_LIBRARIES}
  ${YAJL_LIBRARY}
  Freetype::Freetype
  Fontconfig::Fontconfig
  -lxcb
)

set(INCS
  ${X11_INCLUDE_DIR}
  ${X11_X11_xcb_INCLUDE_PATH}
  ${Xcb_INCLUDE_DIRS}
  ${Xcb_RES_INCLUDE_DIRS}
  ${YAJL_INCLUDE_DIRS}
)

set(CPPFLAGS -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_POSIX_C_SOURCE=200809L -DVERSION="${PROJECT_VERSION}")

add_executable(dwm drw.c dwm.c util.c)
set_target_properties(dwm PROPERTIES C_STANDARD 99)
target_include_directories(dwm PUBLIC "${PROJECT_SOURCE_DIR}" "${PROJECT_BINARY_DIR}" ${INCS})
target_link_libraries(dwm ${LIBS})
target_compile_options(dwm PUBLIC -pedantic -Wall
                        -Wno-deprecated-declarations -Os
                        ${CPPFLAGS})

include(CMakePrintHelpers)
cmake_print_variables(PROJECT_SOURCE_DIR)
cmake_print_variables(X11_LIBRARIES)
cmake_print_variables(X11_INCLUDE_DIR)
cmake_print_variables(X11_X11_xcb_LIB)
cmake_print_variables(X11_X11_xcb_INCLUDE_PATH)
cmake_print_variables(Xcb_LIBRARIES)
cmake_print_variables(Xcb_INCLUDE_DIRS)
cmake_print_variables(Xcb_RES_LIBRARIES)
cmake_print_variables(Xcb_RES_INCLUDE_DIRS)
cmake_print_variables(YAJL_LIBRARY)
cmake_print_variables(YAJL_INCLUDE_DIR)
cmake_print_variables(CPPFLAGS)
