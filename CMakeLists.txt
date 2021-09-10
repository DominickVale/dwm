cmake_minimum_required(VERSION 3.10)
project(dwm VERSION 6.2 LANGUAGES C)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)
configure_file(config.h.in config.h)
add_executable(dwm dwm.c drw.c util.c)
set_target_properties(dwm PROPERTIES C_STANDARD 99)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release")
else()
  message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
endif()

find_package(X11 REQUIRED COMPONENTS Xft xcb)
find_package(Xinerama REQUIRED)
find_package(yajl REQUIRED)
find_package(Freetype REQUIRED)
find_package(Fontconfig REQUIRED)

target_include_directories(dwm PUBLIC "${PROJECT_BINARY_DIR}" "${PROJECT_BINARY_DIR}/cmake")

link_libraries(
  ${X11_LIBRARIES}
  ${XINERAMA_LIBRARIES}
  ${YAJL_LIBRARIES}
  ${FREETYPE_LIBRARIES}
  ${FONTCONFIG_LIBRARIES}
)
include_directories(
  ${X11_LIBRARIES}
  ${XINERAMA_DIRS}
  ${YAJL_DIRS}
  ${FREETYPE_DIRS}
  ${FONTCONFIG_DIRS}
  "/usr/include/freetype2"
)

set(CPPFLAGS -D_DEFAULT_SOURCE -D_BSD_SOURCE
                        -D_POSIX_C_SOURCE=200809L
                        -DXINERAMA)

target_compile_options(dwm PUBLIC -pedantic -Wall
                        -Wno-deprecated-declarations -Os
                        ${CPPFLAGS})