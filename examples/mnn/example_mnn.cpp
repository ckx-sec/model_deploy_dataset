#include <iostream>
#include <vector>
#include <string>
#include <numeric>
#include <algorithm>
#include <cmath>

#include <opencv2/opencv.hpp>
#include <MNN/Interpreter.hpp>
#include <MNN/Tensor.hpp>

// --- Helper Functions ---
template <typename T>
std::vector<T> softmax(const T* data, size_t size) {
    std::vector<T> result(size);
    const T max_val = *std::max_element(data, data + size);
    T sum = 0;
    for (size_t i = 0; i < size; ++i) {
        result[i] = std::exp(data[i] - max_val);
        sum += result[i];
    }
    for (size_t i = 0; i < size; ++i) {
        result[i] /= sum;
    }
    return result;
}

int main() {
    // --- Configuration ---
    const std::string mnn_path = "assets/age_googlenet.mnn"; // 需准备 MNN 格式模型
    const std::string image_path = "assets/test_lite_age_googlenet.jpg";
    const int input_width = 224;
    const int input_height = 224;

    // --- MNN setup ---
    std::shared_ptr<MNN::Interpreter> net(MNN::Interpreter::createFromFile(mnn_path.c_str()));
    MNN::ScheduleConfig config;
    config.type = MNN_FORWARD_CPU;
    config.numThread = 1;
    auto session = net->createSession(config);

    // --- Preprocessing ---
    cv::Mat image = cv::imread(image_path);
    if (image.empty()) {
        std::cerr << "Failed to load image: " << image_path << std::endl;
        return -1;
    }
    cv::Mat resized_image;
    cv::resize(image, resized_image, cv::Size(input_width, input_height));
    cv::cvtColor(resized_image, resized_image, cv::COLOR_BGR2RGB);
    resized_image.convertTo(resized_image, CV_32F, 1.0 / 255.0);
    float mean[] = {0.485f, 0.456f, 0.406f};
    float scale[] = {1/0.229f, 1/0.224f, 1/0.225f};
    std::vector<float> input_tensor_values(1 * 3 * input_height * input_width);
    for (int c = 0; c < 3; ++c) {
        for (int h = 0; h < input_height; ++h) {
            for (int w = 0; w < input_width; ++w) {
                input_tensor_values[c * input_height * input_width + h * input_width + w] =
                    (resized_image.at<cv::Vec3f>(h, w)[c] - mean[c]) * scale[c];
            }
        }
    }

    // --- Set input tensor ---
    auto input = net->getSessionInput(session, nullptr);
    std::vector<int> input_shape = {1, 3, input_height, input_width};
    net->resizeTensor(input, input_shape);
    net->resizeSession(session);
    input->copyFromHostTensor(MNN::Tensor::create<float>(input_shape, input_tensor_values.data(), MNN::Tensor::CAFFE));

    // --- Inference ---
    net->runSession(session);

    // --- Get output ---
    auto output = net->getSessionOutput(session, nullptr);
    std::shared_ptr<MNN::Tensor> output_host(new MNN::Tensor(output, output->getDimensionType()));
    output->copyToHostTensor(output_host.get());
    const float* raw_output = output_host->host<float>();
    size_t output_size = output_host->elementSize();
    auto probs = softmax(raw_output, output_size);
    auto max_it = std::max_element(probs.begin(), probs.end());
    int max_index = std::distance(probs.begin(), max_it);
    const int age_intervals[8][2] = {
        {0, 2}, {4, 6}, {8, 12}, {15, 20}, {25, 32}, {38, 43}, {48, 53}, {60, 100}
    };
    float predicted_age = (float)(age_intervals[max_index][0] + age_intervals[max_index][1]) / 2.0f;
    std::cout << "\n--- Results ---" << std::endl;
    std::cout << "Predicted Age: " << predicted_age << std::endl;
    std::cout << "Age Interval: " << age_intervals[max_index][0] << "-" << age_intervals[max_index][1] << " years" << std::endl;
    std::cout << "Confidence: " << *max_it << std::endl;
    return 0;
} 