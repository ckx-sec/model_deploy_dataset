#!/bin/bash
#
# Build script for ONNX Runtime to create both shared and static libraries.
#
# This script leverages the project's Docker environment and ONNX Runtime's
# own build infrastructure to produce libraries. It runs two builds to get
# both library types and installs them into the third_party directory.
#

set -e # Exit immediately if a command exits with a non-zero status.

# --- Configuration ---
SCRIPT_DIR=$(cd $(dirname $0); pwd)
PROJECT_ROOT_HOST="$SCRIPT_DIR/../.."
ORT_SOURCE_DIR_HOST="$PROJECT_ROOT_HOST/model_deploy_dataset/third_party_builds/onnxruntime_source"
OUTPUT_DIR_HOST="$PROJECT_ROOT_HOST/model_deploy_dataset/third_party/onnxruntime"
DOCKER_IMAGE="mei-builder"

# --- Prepare Output Directories ---
echo "=> Preparing output directories..."
mkdir -p "$OUTPUT_DIR_HOST/lib"
mkdir -p "$OUTPUT_DIR_HOST/include"
echo "Output directories are ready at $OUTPUT_DIR_HOST"
echo ""

# --- Build Function ---
# This function runs the ONNX Runtime build process inside a Docker container.
# $1: Build type ('shared' or 'static')
# $2: Additional flags for the build.sh script
build_ort_in_docker() {
    local build_type_name=$1
    local extra_build_flags=$2

    echo "--------------------------------------------------"
    echo "=> Starting ONNX Runtime build for ${build_type_name} libraries..."
    echo "--------------------------------------------------"

    local project_root_container="/workspace"
    local ort_source_dir_container="${project_root_container}/model_deploy_dataset/third_party_builds/onnxruntime_source"
    
    # ONNX Runtime's build script creates its own build directory.
    # We specify a unique name to avoid conflicts.
    local build_dir_name="build_${build_type_name}"
    local build_dir_container="${ort_source_dir_container}/${build_dir_name}"

    # We need to install to a temporary location inside the build directory
    # and then copy the results to the final destination.
    local install_dir_container="${build_dir_container}/install"

    # Command to be executed inside Docker
    local build_cmds="
        echo '--- Updating CA certificates to fix potential SSL issues ---' &&
        apt-get update -y && apt-get install -y --no-install-recommends ca-certificates &&

        echo '--- Running ONNX Runtime build script for ${build_type_name} libs ---' &&
        ./build.sh \
            --build_dir ${build_dir_container} \
            --config Release \
            --parallel \
            --skip_tests \
            --allow_running_as_root \
            ${extra_build_flags} \
            --cmake_extra_defines CMAKE_INSTALL_PREFIX=${install_dir_container} onnxruntime_USE_KLEIDIAI=OFF &&

        echo '--- Build for ${build_type_name} complete, installing... ---' &&
        cmake --build ${build_dir_container}/Release --target install
    "
    
    # Execute build in Docker
    docker run --rm \
        -v "$PROJECT_ROOT_HOST:$project_root_container" \
        -w "$ort_source_dir_container" \
        "$DOCKER_IMAGE" \
        bash -c "$build_cmds"

    echo "=> ONNX Runtime ${build_type_name} library build finished."
    
    # --- Consolidate Files (on HOST) ---
    echo "=> Consolidating ${build_type_name} library files from host..."
    local install_dir_host="$ORT_SOURCE_DIR_HOST/$build_dir_name/install"

    # It might take a moment for the filesystem to sync after docker exits
    sleep 2

    if [ -d "${install_dir_host}/lib" ]; then
        echo "Found lib dir at ${install_dir_host}/lib, copying contents..."
        cp -r "${install_dir_host}/lib"/* "$OUTPUT_DIR_HOST/lib/"
    else
        echo "Warning: lib dir not found at ${install_dir_host}/lib"
    fi

    if [ -d "${install_dir_host}/include" ]; then
        echo "Found include dir at ${install_dir_host}/include, copying contents..."
        # The actual headers are in a subdirectory, handle that robustly.
        cp -r "${install_dir_host}/include"/* "$OUTPUT_DIR_HOST/include/"
    else
        echo "Warning: include dir not found at ${install_dir_host}/include"
    fi
    echo ""
}

# --- Main Execution ---
# Clean previous build artifacts
echo "=> Cleaning previous build artifacts..."
rm -rf "$ORT_SOURCE_DIR_HOST/build_shared"
rm -rf "$ORT_SOURCE_DIR_HOST/build_static"
rm -rf "$OUTPUT_DIR_HOST/lib/*"
rm -rf "$OUTPUT_DIR_HOST/include/*"


# 1. Build Shared Library
build_ort_in_docker "shared" "--build_shared_lib"

# 2. Build Static Library
# By default, ONNX Runtime builds a static library, so no extra flag is needed.
build_ort_in_docker "static" ""

echo "------------------------------------"
echo "--- ONNX Runtime Build Complete! ---"
echo "------------------------------------"
echo "Shared and static libraries have been installed to:"
echo "  - Libs:    $OUTPUT_DIR_HOST/lib/"
echo "  - Headers: $OUTPUT_DIR_HOST/include/"
echo "" 