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
    const float mean_vals[3] = {127.5f, 127.5f, 127.5f};
    const float norm_vals[3] = {1.0f/128, 1.0f/128, 1.0f/128};
    in.substract_mean_normalize(mean_vals, norm_vals);
    ncnn::Extractor ex = net.create_extractor();
    ex.input("input", in);
    ncnn::Mat out;
    ex.extract("output", out);
    // 输出 headpose (yaw, pitch, roll)
    float yaw = out[0];
    float pitch = out[1];
    float roll = out[2];
    printf("\n--- Results ---\n");
    if (fabs(yaw) <= 99.0f && fabs(pitch) <= 99.0f && fabs(roll) <= 99.0f) {
        printf("Yaw: %.2f\n", yaw);
        printf("Pitch: %.2f\n", pitch);
        printf("Roll: %.2f\n", roll);
    } else {
        printf("Headpose: Invalid (out of range)\n");
    }
    return 0;
} 