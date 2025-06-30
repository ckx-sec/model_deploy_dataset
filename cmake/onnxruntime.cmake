# --- Find ONNXRuntime ---
# This script will be responsible for finding the ONNXRuntime libraries and headers.
# For now, it's a placeholder.

message(STATUS "Looking for ONNXRuntime...")

set(ONNXRUNTIME_ROOT_DIR "${CMAKE_SOURCE_DIR}/third_party/onnxruntime")

find_path(ONNXRUNTIME_INCLUDE_DIR onnxruntime_cxx_api.h
    PATHS "${ONNXRUNTIME_ROOT_DIR}/include"
    NO_DEFAULT_PATH
)

# Find either .so on Linux or .dylib on macOS
find_library(ONNXRUNTIME_LIBRARY 
    NAMES onnxruntime
    PATHS "${ONNXRUNTIME_ROOT_DIR}/lib"
    NO_DEFAULT_PATH
)

if(ONNXRUNTIME_INCLUDE_DIR AND ONNXRUNTIME_LIBRARY)
    set(ONNXRuntime_FOUND TRUE)
    set(ONNXRUNTIME_INCLUDE_DIRS ${ONNXRUNTIME_INCLUDE_DIR})
    set(ONNXRUNTIME_LIBRARIES ${ONNXRUNTIME_LIBRARY})
    
    add_library(ONNXRuntime::onnxruntime SHARED IMPORTED)
    set_target_properties(ONNXRuntime::onnxruntime PROPERTIES
        IMPORTED_LOCATION "${ONNXRUNTIME_LIBRARIES}"
        INTERFACE_INCLUDE_DIRECTORIES "${ONNXRUNTIME_INCLUDE_DIRS}"
    )
    message(STATUS "Found ONNXRuntime: ${ONNXRUNTIME_LIBRARIES}")
    message(STATUS "Found ONNXRuntime Includes: ${ONNXRUNTIME_INCLUDE_DIRS}")
else()
    message(FATAL_ERROR "ONNXRuntime not found in third_party directory!")
endif() 