message(STATUS "Looking for MNN...")

set(MNN_ROOT_DIR "${CMAKE_SOURCE_DIR}/third_party/mnn")
set(MNN_INCLUDE_DIR "${MNN_ROOT_DIR}/include")
set(MNN_LIB_DIR "${MNN_ROOT_DIR}/lib")

find_library(MNN_LIBRARY NAMES MNN PATHS ${MNN_LIB_DIR} NO_DEFAULT_PATH)

if(NOT MNN_LIBRARY)
    message(FATAL_ERROR "MNN library not found in ${MNN_LIB_DIR}")
endif()

add_library(MNN::MNN SHARED IMPORTED)
set_target_properties(MNN::MNN PROPERTIES
    IMPORTED_LOCATION "${MNN_LIBRARY}"
    INTERFACE_INCLUDE_DIRECTORIES "${MNN_INCLUDE_DIR}"
)
message(STATUS "Found MNN: ${MNN_LIBRARY}") 