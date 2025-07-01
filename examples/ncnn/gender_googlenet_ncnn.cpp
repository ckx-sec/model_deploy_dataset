#include <iostream>
#include <vector>
#include <string>
#include <opencv2/opencv.hpp>
#include <net.h>

int main() {
    std::string model_param = "assets/gender_googlenet.param";
    std::string model_bin = "assets/gender_googlenet.bin";
    std::string image_path = "assets/test_lite_gender_googlenet.jpg";
    cv::Mat img = cv::imread(image_path);
    if (img.empty()) {
        std::cerr << "Failed to load image: " << image_path << std::endl;
        return -1;
    }
    // 预处理、推理、后处理流程（需根据 NCNN GenderGoogLeNet 模型结构补充）
    std::cout << "[NCNN] Gender GoogLeNet demo placeholder. Please implement postprocess and inference." << std::endl;
    return 0;
} 