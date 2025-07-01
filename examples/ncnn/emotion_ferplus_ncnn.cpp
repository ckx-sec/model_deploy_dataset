#include <iostream>
#include <vector>
#include <string>
#include <opencv2/opencv.hpp>
#include <net.h>

int main() {
    std::string model_param = "assets/emotion-ferplus-8.param";
    std::string model_bin = "assets/emotion-ferplus-8.bin";
    std::string image_path = "assets/test_lite_emotion_ferplus.jpg";
    cv::Mat img = cv::imread(image_path);
    if (img.empty()) {
        std::cerr << "Failed to load image: " << image_path << std::endl;
        return -1;
    }
    ncnn::Net net;
    net.opt.use_vulkan_compute = false;
    if (net.load_param(model_param.c_str()) != 0 || net.load_model(model_bin.c_str()) != 0) {
        std::cerr << "Failed to load ncnn model." << std::endl;
        return -1;
    }
    // 输入尺寸
    const int input_size = 64;
    cv::Mat resized;
    cv::resize(img, resized, cv::Size(input_size, input_size));
    ncnn::Mat in = ncnn::Mat::from_pixels(resized.data, ncnn::Mat::PIXEL_BGR2RGB, input_size, input_size);
    const float mean_vals[3] = {0.f, 0.f, 0.f};
    const float norm_vals[3] = {1.0f/255, 1.0f/255, 1.0f/255};
    in.substract_mean_normalize(mean_vals, norm_vals);
    ncnn::Extractor ex = net.create_extractor();
    ex.input("input", in);
    ncnn::Mat out;
    ex.extract("output", out);
    // 输出 emotion
    int max_idx = 0;
    float max_score = out[0];
    for (int i = 1; i < out.w; ++i) {
        if (out[i] > max_score) {
            max_score = out[i];
            max_idx = i;
        }
    }
    std::vector<std::string> emotions = {"neutral","happiness","surprise","sadness","anger","disgust","fear","contempt"};
    std::cout << "Emotion: " << emotions[max_idx] << std::endl;
    return 0;
} 