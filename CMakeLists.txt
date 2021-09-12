cmake_minimum_required(VERSION 3.19)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)
set(CMAKE_C_COMPILER "cc")
project(dwm VERSION 6.2 LANGUAGES C)

configure_file(config-version.h.in config-version.h)
add_executable(dwm drw.c dwm.c util.c)
set_target_properties(dwm PROPERTIES C_STANDARD 99)
target_include_directories(dwm PUBLIC "${PROJECT_SOURCE_DIR}" "${PROJECT_BINARY_DIR}")

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
  ${X11_Xft_LIB}
  ${X11_X11_xcb_LIB}
  ${Xcb_LIBRARIES}
  ${Xcb_RES_LIBRARIES}
  ${YAJL_LIBRARY}
  ${FREETYPE_LIBRARY}
  ${Fontconfig_LIBRARIES}
  -lxcb
)

set(INCS
  ${X11_INCLUDE_DIR}
  ${X11_Xft_INCLUDE_PATH}
  ${X11_X11_xcb_INCLUDE_PATH}
  ${Xcb_INCLUDE_DIRS}
  ${Xcb_RES_INCLUDE_DIRS}
  ${YAJL_INCLUDE_DIRS}
  ${FREETYPE_INCLUDE_DIRS}
  ${Fontconfig_INCLUDE_DIRS}
)

target_link_libraries(dwm ${LIBS})
target_include_directories(dwm PUBLIC ${INCS})

set(CPPFLAGS -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_POSIX_C_SOURCE=200809L)

target_compile_options(dwm PUBLIC -pedantic -Wall
                        -Wno-deprecated-declarations -Os
                        ${CPPFLAGS})


message(STATUS "VARS: \n
  PROJECT_SOURCE_DIR ${PROJECT_SOURCE_DIR}
  X11 libs ${X11_LIBRARIES} dir ${X11_INCLUDE_DIR}\n
  X11 Xft lib ${X11_Xft_LIB} dir ${X11_Xft_INCLUDE_PATH}\n
  X11 xcb lib ${X11_X11_xcb_LIB} dir ${X11_X11_xcb_INCLUDE_PATH}\n
  XCB libs ${Xcb_LIBRARIES} dir ${Xcb_INCLUDE_DIRS}\n
  XCB-res libs ${Xcb_RES_LIBRARIES} dir ${Xcb_RES_INCLUDE_DIRS}\n
  yajl libs: ${YAJL_LIBRARY} dirs: ${YAJL_INCLUDE_DIR}, \n
  freetype libs: ${FREETYPE_LIBRARIES} dirs: ${FREETYPE_INCLUDE_DIRS} \n
  Fontconfig libs: ${Fontconfig_LIBRARIES} dirs ${Fontconfig_INCLUDE_DIRS} \n
  CPPFLAGS: ${CPPFLAGS}
")
