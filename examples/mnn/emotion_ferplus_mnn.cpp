#include <iostream>
#include <vector>
#include <string>
#include <opencv2/opencv.hpp>
#include <MNN/Interpreter.hpp>
#include <MNN/Tensor.hpp>

int main() {
    std::string model_path = "assets/emotion-ferplus-8.mnn";
    std::string image_path = "assets/test_lite_emotion_ferplus.jpg";
    cv::Mat img = cv::imread(image_path);
    if (img.empty()) {
        std::cerr << "Failed to load image: " << image_path << std::endl;
        return -1;
    }
    // 预处理、推理、后处理流程（略，需根据 MNN API 和模型结构补充）
    std::cout << "[MNN] Emotion FER+ demo placeholder. Please implement postprocess and inference." << std::endl;
    return 0;
} 