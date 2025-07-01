# TNN cmake module
set(TNN_ROOT "${CMAKE_CURRENT_LIST_DIR}/../third_party/tnn")
set(TNN_INCLUDE_DIR "${TNN_ROOT}/include")
set(TNN_LIB_DIR "${TNN_ROOT}/lib")
set(TNN_LIB "${TNN_LIB_DIR}/libTNN.so")

if(NOT EXISTS ${TNN_LIB})
    message(FATAL_ERROR "TNN lib not found: ${TNN_LIB}")
endif()

message(STATUS "TNN include: ${TNN_INCLUDE_DIR}")
message(STATUS "TNN lib: ${TNN_LIB}") 