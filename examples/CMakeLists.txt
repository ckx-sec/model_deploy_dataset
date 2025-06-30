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

add_executable(ultraface_detector ultraface_detector.cpp)
target_link_libraries(ultraface_detector PRIVATE
    multi_engine_lib
    ${OpenCV_LIBRARIES}
)
target_include_directories(ultraface_detector PRIVATE ${OpenCV_INCLUDE_DIRS})
if(MEI_ENABLE_ONNXRUNTIME)
    target_link_libraries(ultraface_detector PRIVATE ONNXRuntime::onnxruntime)
endif()

add_executable(yolov5_detector yolov5_detector.cpp)
target_link_libraries(yolov5_detector PRIVATE
    multi_engine_lib
    ${OpenCV_LIBRARIES}
)
target_include_directories(yolov5_detector PRIVATE ${OpenCV_INCLUDE_DIRS})
if(MEI_ENABLE_ONNXRUNTIME)
    target_link_libraries(yolov5_detector PRIVATE ONNXRuntime::onnxruntime)
endif()

add_executable(emotion_ferplus emotion_ferplus.cpp)
target_link_libraries(emotion_ferplus PRIVATE
    multi_engine_lib
    ${OpenCV_LIBRARIES}
)
target_include_directories(emotion_ferplus PRIVATE ${OpenCV_INCLUDE_DIRS})
if(MEI_ENABLE_ONNXRUNTIME)
    target_link_libraries(emotion_ferplus PRIVATE ONNXRuntime::onnxruntime)
endif()

add_executable(fsanet_headpose fsanet_headpose.cpp)
target_link_libraries(fsanet_headpose PRIVATE
    multi_engine_lib
    ${OpenCV_LIBRARIES}
)
target_include_directories(fsanet_headpose PRIVATE ${OpenCV_INCLUDE_DIRS})
if(MEI_ENABLE_ONNXRUNTIME)
    target_link_libraries(fsanet_headpose PRIVATE ONNXRuntime::onnxruntime)
endif()

add_executable(gender_googlenet gender_googlenet.cpp)
target_link_libraries(gender_googlenet PRIVATE
    multi_engine_lib
    ${OpenCV_LIBRARIES}
)
target_include_directories(gender_googlenet PRIVATE ${OpenCV_INCLUDE_DIRS})
if(MEI_ENABLE_ONNXRUNTIME)
    target_link_libraries(gender_googlenet PRIVATE ONNXRuntime::onnxruntime)
endif()

add_executable(pfld_landmarks pfld_landmarks.cpp)
target_link_libraries(pfld_landmarks PRIVATE
    multi_engine_lib
    ${OpenCV_LIBRARIES}
)
target_include_directories(pfld_landmarks PRIVATE ${OpenCV_INCLUDE_DIRS})
if(MEI_ENABLE_ONNXRUNTIME)
    target_link_libraries(pfld_landmarks PRIVATE ONNXRuntime::onnxruntime)
endif()

# add_executable(ssrnet_age ssrnet_age.cpp)
# target_link_libraries(ssrnet_age PRIVATE
#     multi_engine_lib
#     ${OpenCV_LIBRARIES}
# )
# target_include_directories(ssrnet_age PRIVATE ${OpenCV_INCLUDE_DIRS})
# if(MEI_ENABLE_ONNXRUNTIME)
#     target_link_libraries(ssrnet_age PRIVATE ONNXRuntime::onnxruntime)
# endif()

# Copy assets to the build directory
set(ASSETS_DIR ${CMAKE_SOURCE_DIR}/assets)
file(COPY ${ASSETS_DIR}/
    DESTINATION ${EXECUTABLE_OUTPUT_PATH}/assets/
) 