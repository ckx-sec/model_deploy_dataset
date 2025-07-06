# Multi-Engine Inference

A C++ project for building and running AI models using multiple inference engines, with a focus on ARM Linux. This project is inspired by [lite.ai.toolkit](https://github.com/xlite-dev/lite.ai.toolkit).

## Goal

The main goal is to provide a collection of reference examples for different inference engines and a simple way to build them for ARM Linux.

## Supported Engines

- [x] ONNXRuntime
- [x] MNN
- [x] NCNN
- [x] TNN

## Features

- Rich demo examples for classification, detection, landmarks, headpose, emotion, age, etc.
- Each engine demo is organized in `examples/<engine>/` with consistent naming and usage.
- Out-of-the-box Docker build environment for cross-compiling on ARM Linux.
- All demo binaries are output to `build/bin/`, named as `<task>_<engine>`.
- Assets (models/images) are auto-copied to `build/bin/assets/` for easy testing.
- Configurable build options for enabling backends and choosing linkage type.

## Directory Structure

- `examples/onnxruntime/`  ONNXRuntime demos (e.g. `emotion_ferplus_onnxruntime`)
- `examples/mnn/`         MNN demos (e.g. `emotion_ferplus_mnn`)
- `examples/ncnn/`        NCNN demos (e.g. `emotion_ferplus_ncnn`)
- `examples/tnn/`         TNN demos (e.g. `emotion_ferplus_tnn`)
- `assets/`               Test models and images.
- `third_party/`          Prebuilt or compiled engine libraries.
- `cmake/`                CMake helper scripts for finding dependencies.
- `src/`                  Source code for the core library (work in progress).

## Getting Started

### Prerequisites
- Docker installed on your system.
- An ARM Linux Docker image with the required build tools (e.g., `mei-builder`).

### Build Steps

1.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    cd multi-engine-inference
    ```

2.  **Run the build command inside a Docker container:**
    The following command mounts the project directory into the container, creates a build directory, runs CMake to configure the project, and then compiles it.
    ```bash
    docker run --rm -v $(pwd):/app -w /app mei-builder \
           bash -c "mkdir -p build && cd build && cmake .. && make -j$(nproc)"
    ```

3.  **Run the examples:**
    All compiled binaries are located in the `build/bin` directory.
    ```bash
    cd build/bin
    ./emotion_ferplus_onnxruntime ../assets/test_lite_emotion_ferplus.jpg
    ```

## Build Options

You can customize the build using CMake options.

### Linking Preference (Static vs. Dynamic)

By default, all inference engines are linked dynamically. You can switch to static linking by setting the `MEI_LINK_STATIC` option to `ON`.

**Important:** To use static linking, you must provide the static libraries (`.a` files) for each engine in the `third_party/<engine>/lib` directory.

- **Dynamic Linking (Default):**
  ```bash
  # Inside the Docker container
  cmake ..
  ```

- **Static Linking:**
  ```bash
  # Inside the Docker container
  cmake .. -DMEI_LINK_STATIC=ON
  ```

### Enabling/Disabling Backends

You can also choose to build only the backends you need by toggling the following options. All are `ON` by default.

- `MEI_ENABLE_ONNXRUNTIME`
- `MEI_ENABLE_MNN`
- `MEI_ENABLE_NCNN`
- `MEI_ENABLE_TNN`

**Example:** To build only the ONNXRuntime and NCNN examples:
```bash
# Inside the Docker container
cmake .. -DMEI_ENABLE_MNN=OFF -DMEI_ENABLE_TNN=OFF
``` 