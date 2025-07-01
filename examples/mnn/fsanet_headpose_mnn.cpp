#include <iostream>
#include <vector>
#include <string>
#include <opencv2/opencv.hpp>
#include <MNN/Interpreter.hpp>
#include <MNN/Tensor.hpp>

int main() {
    std::string model_path = "assets/fsanet-1x1.mnn";
    std::string image_path = "assets/test_lite_fsanet.jpg";
    cv::Mat img = cv::imread(image_path);
    if (img.empty()) {
        std::cerr << "Failed to load image: " << image_path << std::endl;
        return -1;
    }
    auto net = std::shared_ptr<MNN::Interpreter>(MNN::Interpreter::createFromFile(model_path.c_str()));
    MNN::ScheduleConfig config;
    config.type = MNN_FORWARD_CPU;
    auto session = net->createSession(config);
    const int input_size = 64;
    cv::Mat resized;
    cv::resize(img, resized, cv::Size(input_size, input_size));
    auto input_tensor = net->getSessionInput(session, nullptr);
    std::vector<int> dims = {1, input_size, input_size, 3};
    net->resizeTensor(input_tensor, dims);
    net->resizeSession(session);
    uint8_t* input_data = resized.data;
    float* tensor_data = input_tensor->host<float>();
    for (int y = 0; y < input_size; ++y) {
        for (int x = 0; x < input_size; ++x) {
            for (int c = 0; c < 3; ++c) {
                tensor_data[y*input_size*3 + x*3 + c] = input_data[y*input_size*3 + x*3 + (2-c)] / 255.0f;
            }
        }
    }
    net->runSession(session);
    auto output_tensor = net->getSessionOutput(session, nullptr);
    MNN::Tensor output_host(output_tensor, output_tensor->getDimensionType());
    output_tensor->copyToHostTensor(&output_host);
    const float* outptr = output_host.host<float>();
    float yaw = outptr[0] * 90.f;
    float pitch = outptr[1] * 90.f;
    float roll = outptr[2] * 90.f;
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