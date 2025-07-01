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

# 将 clean_assets 集成到所有 example 可执行文件的 POST_BUILD 步骤
set(EXAMPLE_TARGETS example ultraface_detector yolov5_detector pfld_landmarks fsanet_headpose gender_googlenet emotion_ferplus)
foreach(target ${EXAMPLE_TARGETS})
    add_dependencies(${target} clean_assets)
endforeach() 