#include <iostream>
#include <vector>
#include <string>
#include <opencv2/opencv.hpp>
#include <net.h>

int main() {
    std::string model_param = "assets/fsanet-1x1.param";
    std::string model_bin = "assets/fsanet-1x1.bin";
    std::string image_path = "assets/test_lite_fsanet.jpg";
    cv::Mat img = cv::imread(image_path);
    if (img.empty()) {
        std::cerr << "Failed to load image: " << image_path << std::endl;
        return -1;
    }
    // 预处理、推理、后处理流程（需根据 NCNN FSANet 模型结构补充）
    std::cout << "[NCNN] FSANet headpose demo placeholder. Please implement postprocess and inference." << std::endl;
    return 0;
} 