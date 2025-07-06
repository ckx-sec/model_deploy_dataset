#!/bin/bash
#
# Unified build script for the multi-engine-inference project.
#
# This script automates the build process inside a Docker container,
# allowing for easy selection of compilers and build types (Debug/Release).
#

set -e # Exit immediately if a command exits with a non-zero status.

# --- Default Configuration ---
COMPILER="gcc"
BUILD_TYPE="release"
DOCKER_IMAGE="mei-builder" # As specified in README.md

# --- Help Function ---
print_usage() {
    echo "Usage: $0 [-c <compiler>] [-t <build_type>] [-h]"
    echo ""
    echo "Options:"
    echo "  -c <compiler>   Specify the compiler. Options: gcc, clang. (Default: gcc)"
    echo "  -t <build_type>   Specify the build type. Options: release, debug. (Default: release)"
    echo "  -h                Show this help message and exit."
    echo ""
    echo "Example:"
    echo "  # Build with clang in debug mode"
    echo "  ./build.sh -c clang -t debug"
}

# --- Argument Parsing ---
while getopts "c:t:h" opt; do
    case ${opt} in
        c) COMPILER=$(echo "${OPTARG}" | tr '[:upper:]' '[:lower:]') ;;
        t) BUILD_TYPE=$(echo "${OPTARG}" | tr '[:upper:]' '[:lower:]') ;;
        h) print_usage; exit 0 ;;
        \?) echo "Invalid option: -${OPTARG}" >&2; print_usage; exit 1 ;;
    esac
done

# --- Validate Arguments ---
if [[ "$COMPILER" != "gcc" && "$COMPILER" != "clang" ]]; then
    echo "Error: Invalid compiler '$COMPILER'. Supported options are 'gcc' or 'clang'." >&2
    print_usage
    exit 1
fi

if [[ "$BUILD_TYPE" != "release" && "$BUILD_TYPE" != "debug" ]]; then
    echo "Error: Invalid build type '$BUILD_TYPE'. Supported options are 'release' or 'debug'." >&2
    print_usage
    exit 1
fi

# --- Set CMake and Environment Variables based on selection ---
if [[ "$COMPILER" == "gcc" ]]; then
    C_COMPILER="gcc"
    CXX_COMPILER="g++"
else # clang
    C_COMPILER="clang"
    CXX_COMPILER="clang++"
fi

if [[ "$BUILD_TYPE" == "release" ]]; then
    BUILD_TYPE_CMAKE="Release"
else # debug
    BUILD_TYPE_CMAKE="Debug"
fi

# --- Define Directories and Docker Image ---
PROJECT_ROOT_HOST=$(pwd)
BUILD_DIR="build_${COMPILER}_${BUILD_TYPE}" # e.g., build_gcc_release

echo "--- Build Configuration ---"
echo "Compiler:          $COMPILER ($C_COMPILER/$CXX_COMPILER)"
echo "Build Type:        $BUILD_TYPE ($BUILD_TYPE_CMAKE)"
echo "Host Project Dir:  $PROJECT_ROOT_HOST"
echo "Build Dir:         $BUILD_DIR"
echo "Docker Image:      $DOCKER_IMAGE"
echo "---------------------------"

# --- Create Build Directory on Host ---
echo "=> Creating build directory: $BUILD_DIR"
mkdir -p "$BUILD_DIR"

# --- Construct Build Commands to be executed inside Docker ---
# Set compilers via env vars, then run cmake and make.
BUILD_CMDS="CC=$C_COMPILER CXX=$CXX_COMPILER cmake -DCMAKE_BUILD_TYPE=$BUILD_TYPE_CMAKE .. && make -j\$(nproc)"

# --- Execute Build ---
echo "=> Starting build inside Docker container..."
echo "Executing build command..."
# We execute docker run directly here instead of using a variable to avoid issues with shell quoting.
# This ensures that paths with spaces are handled correctly by the shell.
docker run --rm \
    -v "$PROJECT_ROOT_HOST:/app" \
    -w "/app/$BUILD_DIR" \
    "$DOCKER_IMAGE" \
    bash -c "$BUILD_CMDS"

echo ""
echo "--- Build Complete! ---"
echo "Binaries are located in: $BUILD_DIR/bin/"
echo ""
echo "To run an example:"
echo "  cd $BUILD_DIR/bin/"
echo "  ./emotion_ferplus_onnxruntime"
echo "" 