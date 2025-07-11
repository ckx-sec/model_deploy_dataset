#include <iostream>
#include <vector>
#include <string>
#include <opencv2/opencv.hpp>
#include <MNN/Interpreter.hpp>
#include <MNN/Tensor.hpp>

int main() {
    std::string model_path = "assets/pfld-106-lite.mnn";
    std::string image_path = "assets/test_lite_face_landmarks_0.png";
    cv::Mat img = cv::imread(image_path);
    if (img.empty()) {
        std::cerr << "Failed to load image: " << image_path << std::endl;
        return -1;
    }
    auto net = std::shared_ptr<MNN::Interpreter>(MNN::Interpreter::createFromFile(model_path.c_str()));
    MNN::ScheduleConfig config;
    config.type = MNN_FORWARD_CPU;
    auto session = net->createSession(config);
    const int input_size = 112;
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
    std::vector<cv::Point2f> landmarks;
    int num = 106;
    const float* outptr = output_host.host<float>();
    bool valid = true;
    for (int i = 0; i < num; ++i) {
        float x = outptr[2*i] * img.cols;
        float y = outptr[2*i+1] * img.rows;
        if (x < 0 || x >= img.cols || y < 0 || y >= img.rows) valid = false;
        landmarks.emplace_back(x, y);
    }
    for (const auto& pt : landmarks) {
        cv::circle(img, pt, 2, cv::Scalar(0,255,0), -1);
    }
    printf("\n--- Results ---\n");
    if (valid) {
        printf("Detected 106 landmarks.\n");
        cv::imwrite("pfld_mnn_result.jpg", img);
        printf("Result image saved to: pfld_mnn_result.jpg\n");
    } else {
        printf("Landmarks: Invalid (out of image bounds)\n");
    }
    return 0;
} 