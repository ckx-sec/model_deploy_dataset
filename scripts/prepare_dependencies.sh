#!/bin/bash

# This script will download and build the necessary dependencies for the project.
# It detects the OS and downloads the correct pre-built binary for ONNXRuntime.

set -e
set -x

# Place the third_party directory inside the project directory.
THIRD_PARTY_DIR="./third_party"
mkdir -p "${THIRD_PARTY_DIR}"
cd "${THIRD_PARTY_DIR}"
export BUILD_DIR=$(pwd)

# --- 1. ONNXRuntime ---
ORT_VERSION="1.15.1"
if [[ "$(uname)" == "Linux" ]]; then
    ORT_DISTRO="onnxruntime-linux-aarch64-${ORT_VERSION}"
elif [[ "$(uname)" == "Darwin" ]]; then
    ORT_DISTRO="onnxruntime-osx-arm64-${ORT_VERSION}"
else
    echo "Unsupported OS for this script."
    exit 1
fi

ORT_URL="https://github.com/microsoft/onnxruntime/releases/download/v${ORT_VERSION}/${ORT_DISTRO}.tgz"

if [ ! -d "onnxruntime" ]; then
    echo "Downloading ONNXRuntime for $(uname)..."
    curl -L -o "${ORT_DISTRO}.tgz" "${ORT_URL}"
    tar -xzf "${ORT_DISTRO}.tgz"
    mv "${ORT_DISTRO}" onnxruntime
    rm "${ORT_DISTRO}.tgz"
fi
echo "ONNXRuntime is ready."

# --- 2. OpenCV ---
# For ARM Linux, OpenCV can usually be installed from the package manager.
# On Debian/Ubuntu, you can run:
# sudo apt-get update && sudo apt-get install -y libopencv-dev
echo "Please ensure OpenCV is installed. On Debian/Ubuntu, use: sudo apt-get install -y libopencv-dev"

# --- 3. MNN ---
# We will build MNN from source.
# https://github.com/alibaba/MNN
# TODO: Add steps to clone and build MNN for ARM Linux.

# --- 4. NCNN ---
# We will build NCNN from source.
# https://github.com/Tencent/ncnn
# TODO: Add steps to clone and build NCNN for ARM Linux.

# --- 5. TNN ---
# We will build TNN from source.
# https://github.com/Tencent/TNN
# TODO: Add steps to clone and build TNN for ARM Linux.

echo "Dependency preparation finished." 