FIND_PACKAGE(PkgConfig)
pkg_check_modules(YAJL yajl)
SET(YAJL_DEFINITIONS ${YAJL_CFLAGS_OTHER})

IF( YAJL_INCLUDE_DIR AND YAJL_LIBRARIES )
    SET(YAJL_FIND_QUIETLY TRUE)
ENDIF( YAJL_INCLUDE_DIR AND YAJL_LIBRARIES )

FIND_PATH(YAJL_INCLUDE_DIR yajl/yajl_common.h)

SET(YAJL_NAMES ${YAJL_NAMES} yajl libyajl)
FIND_LIBRARY(YAJL_LIBRARIES NAMES ${YAJL_NAMES} PATH)


# handle the QUIETLY and REQUIRED arguments and set YAJL_FOUND to TRUE if 
# all listed variables are TRUE
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(Yajl DEFAULT_MSG YAJL_LIBRARIES YAJL_INCLUDE_DIR)

IF(YAJL_FOUND)
  SET( HAVE_YAJL TRUE )
  SET( YAJL_INCLUDE_DIRS ${YAJL_INCLUDE_DIRS} ${YAJL_INCLUDE_DIR} )
ENDIF(YAJL_FOUND)

MARK_AS_ADVANCED(YAJL_INCLUDE_DIR YAJL_LIBRARIES)