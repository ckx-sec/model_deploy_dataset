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
    cv::resize(image, resized, cv::Size(640, 640));
    cv::cvtColor(resized, resized, cv::COLOR_BGR2RGB);

    DimsVector input_shape = {1, 3, 640, 640};
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
    int num = output_mat->GetDims()[1];
    int stride = output_mat->GetDims()[2];
    std::cout << "Output shape: [";
    for (auto d : output_mat->GetDims()) std::cout << d << ", ";
    std::cout << "]" << std::endl;
    // Simple postprocess: print first 5 boxes (cx,cy,w,h,score)
    for (int i = 0; i < std::min(num, 5); ++i) {
        float cx = output_data[i * stride + 0];
        float cy = output_data[i * stride + 1];
        float w  = output_data[i * stride + 2];
        float h  = output_data[i * stride + 3];
        float score = output_data[i * stride + 4];
        std::cout << "Box " << i << ": cx=" << cx << ", cy=" << cy << ", w=" << w << ", h=" << h << ", score=" << score << std::endl;
    }
    return 0;
} 