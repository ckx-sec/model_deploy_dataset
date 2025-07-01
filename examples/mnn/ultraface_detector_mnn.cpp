#include <iostream>
#include <vector>
#include <string>
#include <opencv2/opencv.hpp>
#include <MNN/Interpreter.hpp>
#include <MNN/Tensor.hpp>

struct FaceBox {
    float x1, y1, x2, y2, score;
};

int main() {
    std::string model_path = "assets/ultraface-rfb-320.mnn";
    std::string image_path = "assets/test_lite_ultraface.jpg";
    cv::Mat img = cv::imread(image_path);
    if (img.empty()) {
        std::cerr << "Failed to load image: " << image_path << std::endl;
        return -1;
    }
    auto net = std::shared_ptr<MNN::Interpreter>(MNN::Interpreter::createFromFile(model_path.c_str()));
    MNN::ScheduleConfig config;
    config.type = MNN_FORWARD_CPU;
    auto session = net->createSession(config);
    const int input_w = 320, input_h = 240;
    cv::Mat resized;
    cv::resize(img, resized, cv::Size(input_w, input_h));
    auto input_tensor = net->getSessionInput(session, nullptr);
    std::vector<int> dims = {1, input_h, input_w, 3};
    net->resizeTensor(input_tensor, dims);
    net->resizeSession(session);
    uint8_t* input_data = resized.data;
    float* tensor_data = input_tensor->host<float>();
    for (int y = 0; y < input_h; ++y) {
        for (int x = 0; x < input_w; ++x) {
            for (int c = 0; c < 3; ++c) {
                tensor_data[y*input_w*3 + x*3 + c] = input_data[y*input_w*3 + x*3 + (2-c)] / 255.0f;
            }
        }
    }
    net->runSession(session);
    auto output_tensor = net->getSessionOutput(session, nullptr);
    MNN::Tensor output_host(output_tensor, output_tensor->getDimensionType());
    output_tensor->copyToHostTensor(&output_host);
    std::vector<FaceBox> faces;
    int num = output_host.shape()[1];
    const float* outptr = output_host.host<float>();
    for (int i = 0; i < num; ++i) {
        if (outptr[i*6+4] > 0.7f) {
            FaceBox box;
            box.x1 = outptr[i*6+0] * img.cols / input_w;
            box.y1 = outptr[i*6+1] * img.rows / input_h;
            box.x2 = outptr[i*6+2] * img.cols / input_w;
            box.y2 = outptr[i*6+3] * img.rows / input_h;
            box.score = outptr[i*6+4];
            faces.push_back(box);
        }
    }
    for (const auto& face : faces) {
        cv::rectangle(img, cv::Point(face.x1, face.y1), cv::Point(face.x2, face.y2), cv::Scalar(0,255,0), 2);
        char text[32];
        sprintf(text, "%.2f", face.score);
        cv::putText(img, text, cv::Point(face.x1, face.y1-5), cv::FONT_HERSHEY_SIMPLEX, 0.5, cv::Scalar(0,255,0), 1);
    }
    std::cout << "Detected faces: " << faces.size() << std::endl;
    cv::imwrite("ultraface_mnn_result.jpg", img);
    std::cout << "Result saved to ultraface_mnn_result.jpg" << std::endl;
    return 0;
} 