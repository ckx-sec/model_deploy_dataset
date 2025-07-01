# Multi-Engine Inference

A project to build and run AI models using multiple inference engines on ARM Linux.
This project is inspired by [lite.ai.toolkit](https://github.com/xlite-dev/lite.ai.toolkit).

## Goal

The main goal is to provide a unified C++ API for different inference engines and provide a simple way to build them for ARM Linux.

## Supported Engines

- [x] ONNXRuntime
- [x] MNN
- [x] NCNN
- [ ] TNN

## Features

- Unified C++ API for ONNXRuntime, MNN, NCNN (TNN planned)
- Out-of-the-box Docker build for ARM Linux
- Rich demo examples for classification, detection, landmarks, headpose, emotion, age, etc.
- Each engine demo is organized in `examples/<engine>/` with consistent naming and usage

## Directory Structure

- `examples/onnxruntime/`  ONNXRuntime demo (e.g. yolov5_detector_onnxruntime)
- `examples/mnn/`         MNN demo (e.g. yolov5_detector_mnn)
- `examples/ncnn/`        NCNN demo (e.g. yolov5_detector_ncnn)
- `assets/`               Test models and images
- `third_party/`          Prebuilt or compiled engine libraries

## Quick Start

1. 准备好 ARM Linux Docker 环境（如 `mei-builder`）。
2. `docker run --rm -v $(pwd)/model_deploy_dataset:/app mei-builder bash -c 'cd /app && cmake -B build -S . && cmake --build build'`
3. 在 `build/bin/` 下运行各类 demo，可执行文件后缀区分推理后端（如 `_onnxruntime`, `_mnn`, `_ncnn`）。

## TODO

- [ ] 完善 TNN 支持
- [ ] 丰富更多模型和后处理
- [ ] Python/C API 封装 