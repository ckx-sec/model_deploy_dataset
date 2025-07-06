#!/bin/bash
#
# Build script for ncnn to create both shared and static libraries.
#
# This script uses the project's Docker environment to build ncnn from source.
# It performs two separate builds: one for the shared library (.so) and one for
# the static library (.a), and installs them into the third_party directory.
#

set -e # Exit immediately if a command exits with a non-zero status.

# --- Configuration ---
# Get the directory of the script itself
SCRIPT_DIR=$(cd $(dirname $0); pwd)
PROJECT_ROOT_HOST="$SCRIPT_DIR/../.."
NCNN_SOURCE_DIR_HOST="$PROJECT_ROOT_HOST/model_deploy_dataset/third_party_builds/ncnn"
OUTPUT_DIR_HOST="$PROJECT_ROOT_HOST/model_deploy_dataset/third_party/ncnn"
DOCKER_IMAGE="mei-builder" # As specified in the main build.sh

# --- Prepare Output Directories on Host ---
echo "=> Preparing output directories..."
mkdir -p "$OUTPUT_DIR_HOST/lib"
mkdir -p "$OUTPUT_DIR_HOST/include"
echo "Output directories are ready at $OUTPUT_DIR_HOST"
echo ""

# --- Build Function ---
# This function runs the build process inside a Docker container.
# $1: Build directory name (e.g., build_shared)
# $2: CMake option for library type (ON for shared, OFF for static)
build_ncnn_in_docker() {
    local build_dir_name=$1
    local shared_libs_option=$2
    local build_type_name="shared"
    if [ "$shared_libs_option" == "OFF" ]; then
        build_type_name="static"
    fi

    echo "--------------------------------------------------"
    echo "=> Starting ncnn build for ${build_type_name} libraries..."
    echo "--------------------------------------------------"

    # Define paths inside the container
    local project_root_container="/workspace"
    local ncnn_source_dir_container="${project_root_container}/model_deploy_dataset/third_party_builds/ncnn"
    # NCNN install path needs to be absolute inside the container
    local output_dir_container="${project_root_container}/model_deploy_dataset/third_party/ncnn/install"

    # CMake and Make commands to be executed inside Docker
    # NCNN uses a different install path structure, so we adjust CMAKE_INSTALL_PREFIX
    local build_cmds="
        echo '--- Configuring ncnn (${build_type_name}) ---' &&
        mkdir -p ${build_dir_name} &&
        cd ${build_dir_name} &&
        cmake .. \
            -DCMAKE_INSTALL_PREFIX=${output_dir_container} \
            -DNCNN_SHARED_LIB=${shared_libs_option} \
            -DCMAKE_BUILD_TYPE=Release \
            -DNCNN_VULKAN=OFF \
            -DNCNN_BUILD_TOOLS=OFF \
            -DNCNN_BUILD_EXAMPLES=OFF &&
        
        echo '--- Compiling ncnn (${build_type_name}) ---' &&
        make -j\$(nproc) &&

        echo '--- Installing ncnn (${build_type_name}) ---' &&
        make install &&

        echo '--- Cleaning up build directory ---' &&
        cd .. &&
        rm -rf ${build_dir_name}
    "

    # Execute the build inside a Docker container
    docker run --rm \
        -v "$PROJECT_ROOT_HOST:$project_root_container" \
        -w "$ncnn_source_dir_container" \
        "$DOCKER_IMAGE" \
        bash -c "$build_cmds"

    echo "=> ncnn ${build_type_name} library build complete!"
    echo ""
}

# --- Main Execution ---
# Clean previous install destination to avoid mixing libs
echo "=> Cleaning previous build artifacts in $OUTPUT_DIR_HOST/install"
rm -rf "$OUTPUT_DIR_HOST/install"

# 1. Build Shared Library
build_ncnn_in_docker "build_shared" "ON"

# 2. Build Static Library
build_ncnn_in_docker "build_static" "OFF"

# NCNN installs into 'install/lib' and 'install/include', let's move them up
echo "=> Consolidating installed files..."
if [ -d "$OUTPUT_DIR_HOST/install/lib" ]; then
    # Move all contents from install/lib to the final lib directory
    cp -r $OUTPUT_DIR_HOST/install/lib/* $OUTPUT_DIR_HOST/lib/
fi
if [ -d "$OUTPUT_DIR_HOST/install/include" ]; then
    # Move all contents from install/include to the final include directory
    cp -r $OUTPUT_DIR_HOST/install/include/* $OUTPUT_DIR_HOST/include/
fi
# Clean up the now-empty install folder
rm -rf "$OUTPUT_DIR_HOST/install"


echo "----------------------------"
echo "--- ncnn Build Complete! ---"
echo "----------------------------"
echo "Shared and static libraries have been installed to:"
echo "  - Libs:    $OUTPUT_DIR_HOST/lib/"
echo "  - Headers: $OUTPUT_DIR_HOST/include/"
echo "" 