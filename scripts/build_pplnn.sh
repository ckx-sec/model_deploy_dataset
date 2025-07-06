#!/bin/bash
#
# Build script for ppl.nn to create static libraries.
#
# This script uses the project's Docker environment to build ppl.nn from source.
# Currently, it focuses on building the static library as the project's CMake
# is primarily configured for static builds.
#

set -e # Exit immediately if a command exits with a non-zero status.

# --- Configuration ---
SCRIPT_DIR=$(cd $(dirname $0); pwd)
PROJECT_ROOT_HOST="$SCRIPT_DIR/../.."
PPLNN_SOURCE_DIR_HOST="$PROJECT_ROOT_HOST/model_deploy_dataset/third_party_builds/ppl.nn"
OUTPUT_DIR_HOST="$PROJECT_ROOT_HOST/model_deploy_dataset/third_party/pplnn"
DOCKER_IMAGE="mei-builder"

# --- Prepare Output Directories on Host ---
echo "=> Preparing output directories..."
mkdir -p "$OUTPUT_DIR_HOST/lib"
mkdir -p "$OUTPUT_DIR_HOST/include"
echo "Output directories are ready at $OUTPUT_DIR_HOST"
echo ""

# --- Build Function ---
build_pplnn_in_docker() {
    echo "--------------------------------------------------"
    echo "=> Starting ppl.nn build for static libraries..."
    echo "--------------------------------------------------"

    local project_root_container="/workspace"
    local pplnn_source_dir_container="${project_root_container}/model_deploy_dataset/third_party_builds/ppl.nn"
    
    # Create a unique build directory for this build type
    local build_dir_container="${pplnn_source_dir_container}/build"
    mkdir -p "$PPLNN_SOURCE_DIR_HOST/build"
    
    # We will install directly to the final destination
    local install_dir_container="${project_root_container}/model_deploy_dataset/third_party/pplnn"

    # Command to be executed inside Docker
    local build_cmds="
        echo '--- Configuring ppl.nn with CMake ---' &&
        cmake .. \
            -DCMAKE_INSTALL_PREFIX=${install_dir_container} \
            -DPPLNN_USE_AARCH64=ON \
            -DPPLNN_USE_X86_64=OFF \
            -DPPLNN_ENABLE_PYTHON_API=OFF \
            -DPPLNN_BUILD_SAMPLES=OFF \
            -DPPLNN_BUILD_TESTS=OFF \
            -DPPLNN_BUILD_TOOLS=OFF \
            -DCMAKE_BUILD_TYPE=Release &&
        
        echo '--- Building ppl.nn static library ---' &&
        make -j4 &&

        echo '--- Installing ppl.nn static library ---' &&
        make install
    "
    
    # Execute build in Docker
    docker run --rm \
        -v "$PROJECT_ROOT_HOST:$project_root_container" \
        -w "$build_dir_container" \
        "$DOCKER_IMAGE" \
        bash -c "$build_cmds"

    echo "=> ppl.nn static library build finished."
    echo ""
}

# --- Main Execution ---
# Clean previous build artifacts
echo "=> Cleaning previous build artifacts..."
rm -rf "$PPLNN_SOURCE_DIR_HOST/build"
# Clear out the destination directories
rm -rf "$OUTPUT_DIR_HOST/lib/*"
rm -rf "$OUTPUT_DIR_HOST/include/*"


build_pplnn_in_docker

echo "----------------------------"
echo "--- ppl.nn Build Complete! ---"
echo "----------------------------"
echo "Static libraries have been installed to:"
echo "  - Libs:    $OUTPUT_DIR_HOST/lib/"
echo "  - Headers: $OUTPUT_DIR_HOST/include/"
echo "" 