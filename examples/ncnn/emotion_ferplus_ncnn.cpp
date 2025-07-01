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
    float* ptr = (float*)out.data;
    int max_index = std::max_element(ptr, ptr + 8) - ptr;
    float max_prob = ptr[max_index];
    const float prob_threshold = 0.5f;
    const char* emotion_texts[8] = {"neutral", "happiness", "surprise", "sadness", "anger", "disgust", "fear", "contempt"};
    printf("\n--- Results ---\n");
    if (max_prob > prob_threshold) {
        printf("Predicted Emotion: %s\n", emotion_texts[max_index]);
        printf("Confidence: %.4f\n", max_prob);
    } else {
        printf("Predicted Emotion: Uncertain (low confidence)\n");
        printf("Confidence: %.4f\n", max_prob);
    }
    return 0;
} 