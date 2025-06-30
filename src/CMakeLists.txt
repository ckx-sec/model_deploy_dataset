add_library(multi_engine_lib SHARED
    dummy.cpp
)

target_include_directories(multi_engine_lib PUBLIC
    $<INSTALL_INTERFACE:include>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
)

# This is where we would find and link against different inference engines
# based on the MEI_ENABLE_* options.

# if(MEI_ENABLE_ONNXRUNTIME)
#   find_package(ONNXRuntime REQUIRED)
#   target_link_libraries(multi_engine_lib PRIVATE ONNXRuntime::onnxruntime)
# endif() 