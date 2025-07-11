#include <iostream>
#include <vector>
#include <string>
#include <numeric>
#include <algorithm>
#include <cmath>

#include <opencv2/opencv.hpp>
#include <onnxruntime_cxx_api.h>

// --- Helper Functions ---

// A simple softmax implementation
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

// --- Main Inference Logic ---
int main() {
    // --- Configuration ---
    const std::string onnx_path = "assets/emotion-ferplus-8.onnx";
    const std::string image_path = "assets/test_lite_emotion_ferplus.jpg";
    const int input_width = 64;
    const int input_height = 64;

    // --- ONNXRuntime setup ---
    Ort::Env env(ORT_LOGGING_LEVEL_WARNING, "test-emotion");
    Ort::SessionOptions session_options;
    session_options.SetIntraOpNumThreads(1);
    session_options.SetGraphOptimizationLevel(GraphOptimizationLevel::ORT_ENABLE_ALL);

    Ort::Session session(env, onnx_path.c_str(), session_options);

    Ort::AllocatorWithDefaultOptions allocator;

    // --- Get model input/output details ---
    std::vector<const char*> input_node_names = {"Input3"};
    std::vector<const char*> output_node_names = {"Plus692_Output_0"};

    std::cout << "--- Model Inputs ---" << std::endl;
    std::cout << "Input 0 : name=" << input_node_names[0] << std::endl;
    std::cout << "--- Model Outputs ---" << std::endl;
    std::cout << "Output 0 : name=" << output_node_names[0] << std::endl;
    std::cout << "--------------------" << std::endl;

    // --- Preprocessing ---
    cv::Mat image = cv::imread(image_path);
    if (image.empty()) {
        std::cerr << "Failed to load image: " << image_path << std::endl;
        return -1;
    }

    cv::Mat resized_image;
    cv::resize(image, resized_image, cv::Size(input_width, input_height));
    cv::cvtColor(resized_image, resized_image, cv::COLOR_BGR2GRAY);

    std::vector<float> input_tensor_values(1 * 1 * input_height * input_width);
    resized_image.convertTo(resized_image, CV_32F);
    
    // Flatten the image data
    memcpy(input_tensor_values.data(), resized_image.data, input_tensor_values.size() * sizeof(float));

    // --- Create Tensor ---
    std::vector<int64_t> input_node_dims = {1, 1, input_height, input_width};
    size_t input_tensor_size = 1 * 1 * input_height * input_width;

    Ort::MemoryInfo memory_info = Ort::MemoryInfo::CreateCpu(OrtArenaAllocator, OrtMemTypeDefault);
    Ort::Value input_tensor = Ort::Value::CreateTensor<float>(
        memory_info, input_tensor_values.data(), input_tensor_size, input_node_dims.data(), input_node_dims.size()
    );

    // --- Inference ---
    std::cout << "Running inference..." << std::endl;
    auto output_tensors = session.Run(
        Ort::RunOptions{nullptr}, input_node_names.data(), &input_tensor, 1, output_node_names.data(), 1
    );
    std::cout << "Inference finished." << std::endl;

    // --- Post-processing ---
    const float* raw_output = output_tensors[0].GetTensorData<float>();
    auto output_shape = output_tensors[0].GetTensorTypeAndShapeInfo().GetShape();
    size_t output_size = output_shape[1]; // Should be 8
    
    auto probs = softmax(raw_output, output_size);
    
    // Find the class with the highest probability
    auto max_it = std::max_element(probs.begin(), probs.end());
    int max_index = std::distance(probs.begin(), max_it);

    const float prob_threshold = 0.5f;
    const char *emotion_texts[8] = {
        "neutral", "happiness", "surprise", "sadness", "anger",
        "disgust", "fear", "contempt"
    };
    
    std::cout << "\n--- Results ---" << std::endl;
    if (*max_it > prob_threshold) {
        std::cout << "Predicted Emotion: " << emotion_texts[max_index] << std::endl;
        std::cout << "Confidence: " << *max_it << std::endl;
    } else {
        std::cout << "Predicted Emotion: Uncertain (low confidence)" << std::endl;
        std::cout << "Confidence: " << *max_it << std::endl;
    }
    
    return 0;
} 