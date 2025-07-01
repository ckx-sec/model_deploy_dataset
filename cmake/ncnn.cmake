message(STATUS "Looking for NCNN...")

set(NCNN_ROOT_DIR "${CMAKE_SOURCE_DIR}/third_party/ncnn")
set(NCNN_INCLUDE_DIR "${NCNN_ROOT_DIR}/include")
set(NCNN_LIB_DIR "${NCNN_ROOT_DIR}/lib")

find_library(NCNN_LIBRARY NAMES ncnn PATHS ${NCNN_LIB_DIR} NO_DEFAULT_PATH)

if(NOT NCNN_LIBRARY)
    message(FATAL_ERROR "NCNN library not found in ${NCNN_LIB_DIR}")
endif()

add_library(NCNN::ncnn SHARED IMPORTED)
set_target_properties(NCNN::ncnn PROPERTIES
    IMPORTED_LOCATION "${NCNN_LIBRARY}"
    INTERFACE_INCLUDE_DIRECTORIES "${NCNN_INCLUDE_DIR}/ncnn"
)
message(STATUS "Found NCNN: ${NCNN_LIBRARY}") 