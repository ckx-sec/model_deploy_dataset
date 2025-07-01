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
    int max_index = std::max_element(outptr, outptr + 8) - outptr;
    float max_prob = outptr[max_index];
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