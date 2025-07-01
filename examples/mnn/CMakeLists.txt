set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${EXECUTABLE_OUTPUT_PATH})

# 示例：后续可添加MNN相关的demo
# add_executable(mnn_example mnn_example.cpp)
# target_link_libraries(mnn_example PRIVATE
#     multi_engine_lib
#     ${OpenCV_LIBRARIES}
# )
# target_include_directories(mnn_example PRIVATE ${OpenCV_INCLUDE_DIRS})
# if(MEI_ENABLE_MNN)
#     target_link_libraries(mnn_example PRIVATE MNN::MNN)
# endif() 