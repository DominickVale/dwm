find_path(YAJL_INCLUDE_DIR yajl/yajl_common.h)

set(YAJL_NAMES ${YAJL_NAMES} yajl libyajl)
find_library(YAJL_LIBRARY NAMES ${YAJL_NAMES} PATH)

if(YAJL_INCLUDE_DIR AND YAJL_LIBRARY)
	set(YAJL_FOUND TRUE)
endif()

if(YAJL_FOUND)
	if(NOT Yajl_FIND_QUIETLY)
		message(STATUS "Found Yajl: ${YAJL_LIBRARY}")
	endif ()
else()
	if(Yajl_FIND_REQUIRED)
		message(FATAL_ERROR "Could not find yajl")
	endif()
endif()