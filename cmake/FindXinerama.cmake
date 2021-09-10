find_path(XINERAMA_INCLUDE_DIR
          NAMES X11/extensions/Xinerama.h
          PATHS /opt/X11/include
          PATH_SUFFIXES X11/extensions
          DOC "The Xinerama include directory")

find_library(XINERAMA_LIBRARY
             NAMES Xinerama
             PATHS /opt/X11/lib
             DOC "The Xinerama library")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Xinerama
                                  DEFAULT_MSG
                                  XINERAMA_LIBRARY
                                  XINERAMA_INCLUDE_DIR)

if(XINERAMA_FOUND)
  set(XINERAMA_LIBRARIES ${XINERAMA_LIBRARY})
  set(XINERAMA_INCLUDE_DIRS ${XINERAMA_INCLUDE_DIR})
endif()

mark_as_advanced(XINERAMA_INCLUDE_DIR XINERAMA_LIBRARY)