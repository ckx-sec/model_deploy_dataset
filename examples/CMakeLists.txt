add_subdirectory(onnxruntime)
add_subdirectory(mnn)

# Copy assets to the build directory
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin)
set(ASSETS_DIR ${CMAKE_SOURCE_DIR}/assets)
file(COPY ${ASSETS_DIR}/
    DESTINATION ${EXECUTABLE_OUTPUT_PATH}/assets/
)

# 添加自定义target用于删除拷贝的assets目录
add_custom_target(clean_assets
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${EXECUTABLE_OUTPUT_PATH}/assets
    COMMENT "Remove copied assets directory after build"
)

# 将 clean_assets 集成到所有 onnxruntime example 可执行文件的 POST_BUILD 步骤
set(EXAMPLE_TARGETS example_onnxruntime ultraface_detector_onnxruntime yolov5_detector_onnxruntime pfld_landmarks_onnxruntime fsanet_headpose_onnxruntime gender_googlenet_onnxruntime emotion_ferplus_onnxruntime)
foreach(target ${EXAMPLE_TARGETS})
    add_dependencies(${target} clean_assets)
endforeach() 