#include <iostream>
#include <opencv2/opencv.hpp>
#include <tnn/core/tnn.h>
#include <tnn/core/instance.h>
#include <tnn/core/mat.h>
#include <tnn/utils/blob_converter.h>

using namespace TNN_NS;

int main(int argc, char** argv) {
    if (argc < 4) {
        std::cout << "Usage: " << argv[0] << " proto_path model_path image_path" << std::endl;
        return -1;
    }
    std::string proto_path = argv[1];
    std::string model_path = argv[2];
    std::string image_path = argv[3];

    ModelConfig config;
    config.model_type = MODEL_TYPE_TNN;
    config.params = {proto_path, model_path};
    TNN net;
    auto status = net.Init(config);
    if (status != TNN_OK) {
        std::cout << "TNN Init failed: " << status.description() << std::endl;
        return -1;
    }

    NetworkConfig net_config;
    net_config.device_type = DEVICE_ARM;
    auto instance = net.CreateInst(net_config, status);
    if (!instance || status != TNN_OK) {
        std::cout << "CreateInst failed: " << status.description() << std::endl;
        return -1;
    }

    cv::Mat image = cv::imread(image_path);
    if (image.empty()) {
        std::cout << "Failed to load image: " << image_path << std::endl;
        return -1;
    }
    cv::Mat resized;
    cv::resize(image, resized, cv::Size(112, 112));
    cv::cvtColor(resized, resized, cv::COLOR_BGR2RGB);

    DimsVector input_shape = {1, 3, 112, 112};
    std::shared_ptr<Mat> input_mat = std::make_shared<Mat>(DEVICE_ARM, NCHW_FLOAT, input_shape, resized.data);

    MatConvertParam input_param;
    input_param.scale = {1/255.f, 1/255.f, 1/255.f, 0.f};
    input_param.bias = {0.f, 0.f, 0.f, 0.f};

    status = instance->SetInputMat(input_mat, input_param);
    if (status != TNN_OK) {
        std::cout << "SetInputMat failed: " << status.description() << std::endl;
        return -1;
    }

    status = instance->Forward();
    if (status != TNN_OK) {
        std::cout << "Forward failed: " << status.description() << std::endl;
        return -1;
    }

    std::shared_ptr<Mat> output_mat;
    status = instance->GetOutputMat(output_mat);
    if (status != TNN_OK) {
        std::cout << "GetOutputMat failed: " << status.description() << std::endl;
        return -1;
    }
    float* output_data = static_cast<float*>(output_mat->GetData());
    int num_points = output_mat->GetDims()[1] / 2;
    std::cout << "First 5 landmarks:" << std::endl;
    for (int i = 0; i < std::min(num_points, 5); ++i) {
        float x = output_data[i * 2 + 0];
        float y = output_data[i * 2 + 1];
        std::cout << "Point " << i << ": x=" << x << ", y=" << y << std::endl;
    }

    bool valid = true;
    for (int i = 0; i < 106; i++) {
        float x = output_data[i * 2] * 112;
        float y = output_data[i * 2 + 1] * 112;
        if (x < 0 || x >= 112 || y < 0 || y >= 112) valid = false;
        cv::circle(image, cv::Point(x, y), 2, cv::Scalar(0, 255, 0), -1);
    }
    printf("\n--- Results ---\n");
    if (valid) {
        printf("Detected 106 landmarks.\n");
        cv::imwrite("face_landmarks_result.jpg", image);
        printf("Result image saved to: face_landmarks_result.jpg\n");
    } else {
        printf("Landmarks: Invalid (out of image bounds)\n");
    }
    return 0;
} 