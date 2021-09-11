cmake_minimum_required(VERSION 3.18)
project(dwm VERSION 6.2 LANGUAGES C)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)
add_executable(dwm dwm.c)
set_target_properties(dwm PROPERTIES C_STANDARD 99)
target_include_directories(dwm PUBLIC "${PROJECT_SOURCE_DIR}" "${PROJECT_SOURCE_DIR}/cmake" "${PROJECT_BINARY_DIR}")
target_link_libraries(dwm PUBLIC "drw.h")
configure_file(config.h.in config.h)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release")
else()
  message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
endif()

find_package(X11 REQUIRED COMPONENTS Xinerama Xft xcb)
find_package(Yajl REQUIRED)
find_package(Freetype REQUIRED)
find_package(Fontconfig REQUIRED)

link_libraries(
  ${X11_LIBRARIES}
  ${YAJL_LIBRARIES}
  ${FREETYPE_LIBRARIES}
  ${Fontconfig_LIBRARIES}
)
include_directories(
  ${X11_INCLUDE_DIR}
  ${YAJL_INCLUDE_DIRS}
  ${FREETYPE_INCLUDE_DIRS}
  ${Fontconfig_INCLUDE_DIRS}
)

message(STATUS "VARS: \n
  PROJECT_SOURCE_DIR ${PROJECT_SOURCE_DIR}
  X11 libs ${X11_LIBRARIES} dir ${X11_INCLUDE_DIR}\n
  yajl libs: ${YAJL_LIBRARIES} dirs: ${YAJL_INCLUDE_DIRS}, \n
  freetype libs: ${FREETYPE_LIBRARIES} dirs: ${FREETYPE_INCLUDE_DIRS} \n
  Fontconfig libs: ${Fontconfig_LIBRARIES} dirs ${Fontconfig_INCLUDE_DIRS} \n
")

set(CPPFLAGS -D_DEFAULT_SOURCE -D_BSD_SOURCE
                        -D_POSIX_C_SOURCE=200809L
                        -DXINERAMA)

target_compile_options(dwm PUBLIC -pedantic -Wall
                        -Wno-deprecated-declarations -Os
                        ${CPPFLAGS})