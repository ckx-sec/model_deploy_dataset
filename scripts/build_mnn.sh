#!/bin/bash
#
# Build script for MNN to create both shared and static libraries.
#
# This script uses the project's Docker environment to build MNN from source.
# It performs two separate builds: one for the shared library (.so) and one for
# the static library (.a), and installs them into the third_party directory.
#

set -e # Exit immediately if a command exits with a non-zero status.

# --- Configuration ---
SCRIPT_DIR=$(cd $(dirname $0); pwd)
PROJECT_ROOT_HOST="$SCRIPT_DIR/../.."
MNN_SOURCE_DIR_HOST="$PROJECT_ROOT_HOST/model_deploy_dataset/third_party_builds/MNN"
OUTPUT_DIR_HOST="$PROJECT_ROOT_HOST/model_deploy_dataset/third_party/mnn"
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
build_mnn_in_docker() {
    local build_dir_name=$1
    local shared_libs_option=$2
    local build_type_name="shared"
    if [ "$shared_libs_option" == "OFF" ]; then
        build_type_name="static"
    fi

    echo "--------------------------------------------------"
    echo "=> Starting MNN build for ${build_type_name} libraries..."
    echo "--------------------------------------------------"

    # Define paths inside the container
    local project_root_container="/workspace"
    local mnn_source_dir_container="${project_root_container}/model_deploy_dataset/third_party_builds/MNN"
    local output_dir_container="${project_root_container}/model_deploy_dataset/third_party/mnn"
    
    # CMake and Make commands to be executed inside Docker
    local build_cmds="
        echo '--- Configuring MNN (${build_type_name}) ---' &&
        mkdir -p ${build_dir_name} &&
        cd ${build_dir_name} &&
        cmake .. \
            -DCMAKE_INSTALL_PREFIX=${output_dir_container} \
            -DMNN_BUILD_SHARED_LIBS=${shared_libs_option} \
            -DCMAKE_BUILD_TYPE=Release \
            -DMNN_BUILD_DEMO=OFF \
            -DMNN_BUILD_TOOLS=OFF \
            -DMNN_BUILD_CONVERTER=OFF &&
        
        echo '--- Compiling MNN (${build_type_name}) ---' &&
        make -j\$(nproc) &&

        echo '--- Installing MNN (${build_type_name}) ---' &&
        make install &&

        echo '--- Cleaning up build directory ---' &&
        cd .. &&
        rm -rf ${build_dir_name}
    "

    # Execute the build inside a Docker container
    docker run --rm \
        -v "$PROJECT_ROOT_HOST:$project_root_container" \
        -w "$mnn_source_dir_container" \
        "$DOCKER_IMAGE" \
        bash -c "$build_cmds"

    echo "=> MNN ${build_type_name} library build complete!"
    echo ""
}

# --- Main Execution ---
# 1. Build Shared Library
build_mnn_in_docker "build_shared" "ON"

# 2. Build Static Library
build_mnn_in_docker "build_static" "OFF"

echo "---------------------------"
echo "--- MNN Build Complete! ---"
echo "---------------------------"
echo "Shared and static libraries have been installed to:"
echo "  - Libs:    $OUTPUT_DIR_HOST/lib/"
echo "  - Headers: $OUTPUT_DIR_HOST/include/"
echo "" 