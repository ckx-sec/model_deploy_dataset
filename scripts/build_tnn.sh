#!/bin/bash
#
# Build script for TNN to create both shared and static libraries.
#
# This script uses the project's Docker environment to build TNN from source.
# It performs two separate builds: one for the shared library (.so) and one for
# the static library (.a), and installs them into the third_party directory.
#

set -e # Exit immediately if a command exits with a non-zero status.

# --- Configuration ---
SCRIPT_DIR=$(cd $(dirname $0); pwd)
PROJECT_ROOT_HOST="$SCRIPT_DIR/../.."
TNN_SOURCE_DIR_HOST="$PROJECT_ROOT_HOST/model_deploy_dataset/third_party_builds/TNN"
OUTPUT_DIR_HOST="$PROJECT_ROOT_HOST/model_deploy_dataset/third_party/tnn"
DOCKER_IMAGE="mei-builder"

# --- Prepare Output Directories on Host ---
echo "=> Preparing output directories..."
mkdir -p "$OUTPUT_DIR_HOST/lib"
mkdir -p "$OUTPUT_DIR_HOST/include"
echo "Output directories are ready at $OUTPUT_DIR_HOST"
echo ""

# --- Build Function ---
# This function runs the build process inside a Docker container.
# $1: Build type ('shared' or 'static')
# $2: CMake flag for the build type
build_tnn_in_docker() {
    local build_type_name=$1
    local cmake_flag=$2

    echo "--------------------------------------------------"
    echo "=> Starting TNN build for ${build_type_name} libraries..."
    echo "--------------------------------------------------"

    local project_root_container="/workspace"
    local tnn_source_dir_container="${project_root_container}/model_deploy_dataset/third_party_builds/TNN"
    
    # Create a unique build directory for this build type
    local build_dir_container="${tnn_source_dir_container}/build_${build_type_name}"
    mkdir -p "$TNN_SOURCE_DIR_HOST/build_${build_type_name}"
    
    # We will install to a temporary location and then copy
    local install_dir_container="${build_dir_container}/install"

    # Command to be executed inside Docker
    local build_cmds="
        echo '--- Configuring TNN with CMake for ${build_type_name} libs ---' &&
        cmake .. \
            -DCMAKE_INSTALL_PREFIX=${install_dir_container} \
            -DTNN_BUILD_SHARED=${cmake_flag} \
            -DTNN_CPU_ENABLE=ON \
            -DTNN_X86_ENABLE=OFF \
            -DTNN_ARM_ENABLE=ON \
            -DTNN_OPENCL_ENABLE=OFF \
            -DTNN_METAL_ENABLE=OFF \
            -DTNN_TEST_ENABLE=OFF \
            -DTNN_UNIT_TEST_ENABLE=OFF \
            -DTNN_BENCHMARK_MODE=OFF &&
        
        echo '--- Building TNN ${build_type_name} library ---' &&
        make -j4
    "
    
    # Execute build in Docker
    docker run --rm \
        -v "$PROJECT_ROOT_HOST:$project_root_container" \
        -w "$build_dir_container" \
        "$DOCKER_IMAGE" \
        bash -c "$build_cmds"

    echo "=> TNN ${build_type_name} library build finished."

    # --- Consolidate Files (on HOST) ---
    echo "=> Consolidating ${build_type_name} library files from host..."
    local install_dir_host="$TNN_SOURCE_DIR_HOST/build_${build_type_name}/install"

    # It might take a moment for the filesystem to sync after docker exits
    sleep 2
    
    # Manually find and copy the library files
    echo "Finding and copying library files..."
    find "${TNN_SOURCE_DIR_HOST}/build_${build_type_name}" -name "libTNN.*" -exec cp {} "$OUTPUT_DIR_HOST/lib/" \;

    # Manually copy the include headers
    echo "Copying include files..."
    if [ -d "${TNN_SOURCE_DIR_HOST}/include" ]; then
        cp -r "${TNN_SOURCE_DIR_HOST}/include"/* "$OUTPUT_DIR_HOST/include/"
    else
        echo "Warning: TNN include directory not found at ${TNN_SOURCE_DIR_HOST}/include"
    fi
    echo ""
}

# --- Main Execution ---
# Clean previous build artifacts
echo "=> Cleaning previous build artifacts..."
rm -rf "$TNN_SOURCE_DIR_HOST/build_shared"
rm -rf "$TNN_SOURCE_DIR_HOST/build_static"
rm -rf "$OUTPUT_DIR_HOST/lib/*"
rm -rf "$OUTPUT_DIR_HOST/include/*"

# 1. Build Shared Library
build_tnn_in_docker "shared" "ON"

# 2. Build Static Library
build_tnn_in_docker "static" "OFF"

echo "----------------------------"
echo "--- TNN Build Complete! ---"
echo "----------------------------"
echo "Shared and static libraries have been installed to:"
echo "  - Libs:    $OUTPUT_DIR_HOST/lib/"
echo "  - Headers: $OUTPUT_DIR_HOST/include/"
echo "" 