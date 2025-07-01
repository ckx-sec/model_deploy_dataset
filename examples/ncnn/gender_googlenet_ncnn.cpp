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
    ncnn::Net net;
    net.opt.use_vulkan_compute = false;
    if (net.load_param(model_param.c_str()) != 0 || net.load_model(model_bin.c_str()) != 0) {
        std::cerr << "Failed to load ncnn model." << std::endl;
        return -1;
    }
    // 输入尺寸
    const int input_size = 224;
    cv::Mat resized;
    cv::resize(img, resized, cv::Size(input_size, input_size));
    ncnn::Mat in = ncnn::Mat::from_pixels(resized.data, ncnn::Mat::PIXEL_BGR2RGB, input_size, input_size);
    const float mean_vals[3] = {127.5f, 127.5f, 127.5f};
    const float norm_vals[3] = {1.0f/128, 1.0f/128, 1.0f/128};
    in.substract_mean_normalize(mean_vals, norm_vals);
    ncnn::Extractor ex = net.create_extractor();
    ex.input("input", in);
    ncnn::Mat out;
    ex.extract("output", out);
    // 输出 gender
    float prob[2];
    for (int i = 0; i < 2; i++) {
        prob[i] = out[i];
    }
    int max_index = std::max_element(prob, prob + 2) - prob;
    float max_prob = prob[max_index];
    const float prob_threshold = 0.5f;
    const char* gender_texts[2] = {"Female", "Male"};
    int gender_label = (max_index == 1) ? 0 : 1;
    printf("\n--- Results ---\n");
    if (max_prob > prob_threshold) {
        printf("Predicted Gender: %s\n", gender_texts[gender_label]);
        printf("Confidence: %.4f\n", max_prob);
    } else {
        printf("Predicted Gender: Uncertain (low confidence)\n");
        printf("Confidence: %.4f\n", max_prob);
    }
    return 0;
} 