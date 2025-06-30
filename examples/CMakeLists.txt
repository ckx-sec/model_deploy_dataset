set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${EXECUTABLE_OUTPUT_PATH})

add_executable(example example.cpp)

target_link_libraries(example PRIVATE
    multi_engine_lib
    ${OpenCV_LIBRARIES}
)
target_include_directories(example PRIVATE ${OpenCV_INCLUDE_DIRS})

if(MEI_ENABLE_ONNXRUNTIME)
    target_link_libraries(example PRIVATE ONNXRuntime::onnxruntime)
endif()

# Copy assets to the build directory
set(ASSETS_DIR ${CMAKE_SOURCE_DIR}/assets)
file(COPY ${ASSETS_DIR}/
    DESTINATION ${EXECUTABLE_OUTPUT_PATH}/assets/
) 