cmake_minimum_required(VERSION 3.10)
project(dwm VERSION 6.2 LANGUAGES C)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
configure_file(config.h.in config.h)
add_executable(dwm dwm.c drw.c util.c)
set_target_properties(dwm PROPERTIES C_STANDARD 99)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release")
else()
  message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
endif()

set(X11INC "/usr/X11R6/include")
set(X11LIB "/usr/X11R6/lib")

set(XINERAMALIBS "-lXinerama")
set(XINERAMAFLAGS "-DXINERAMA")

set(FREETYPELIBS "-lfontconfig -lXft")
set(FREETYPEINC "/usr/include/freetype2")

set(YAJLLIBS "-lyajl")
set(YAJLINC "/usr/include/yajl")

set(INCS -I${X11INC} -I${FREETYPEINC} -I${YAJLINC})
set(LIBS -L${X11LIB} -lX11 ${XINERAMALIBS} ${FREETYPELIBS}
                        ${YAJLLIBS} -lX11-xcb -lxcb -lxcb-res)
                      
target_link_libraries(dwm ${LIBS})
target_include_directories(dwm PUBLIC "${PROJECT_BINARY_DIR}" ${INCS})

set(CPPFLAGS -D_DEFAULT_SOURCE -D_BSD_SOURCE
                        -D_POSIX_C_SOURCE=200809L
                        ${XINERAMAFLAGS})

target_compile_options(dwm PUBLIC -pedantic -Wall
                        -Wno-deprecated-declarations -Os
                        ${INCS} ${CPPFLAGS})
