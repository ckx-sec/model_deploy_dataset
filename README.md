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

# TNN Demo 使用说明

本目录下 tnn demo（yolov5、ultraface、pfld、gender、emotion、ssrnet、fsanet）均为**原生 TNN C++ API 实现**，不依赖 lite.ai.toolkit。

## 运行方法

```bash
# 以 yolov5 为例
./yolov5_detector_tnn yolov5.tnnproto yolov5.tnnmodel test.jpg
```
- 其它 demo 用法类似，参数依次为 proto/model/image。

## 支持模型
- yolov5
- ultraface
- pfld
- gender_googlenet
- emotion_ferplus
- ssrnet
- fsanet

## 依赖
- OpenCV
- TNN 官方 C++ 头文件与 so

## 测试方法
- 推荐配合 assets 目录下测试图片与模型。
- 输出结果为控制台打印或图片保存（如有后处理）。

## 注意事项
- 需先将 onnx 模型转换为 tnnproto/tnnmodel 格式。
- demo 代码结构清晰，便于二次开发。 