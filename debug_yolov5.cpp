#include <iostream>
#include <vector>
#include <string>
#include <onnxruntime_cxx_api.h>

int main() {
    const std::string onnx_path = "assets/yolov5s.onnx";
    
    // --- ONNXRuntime setup ---
    Ort::Env env(ORT_LOGGING_LEVEL_WARNING, "debug-yolov5");
    Ort::SessionOptions session_options;
    session_options.SetIntraOpNumThreads(1);
    
    try {
        Ort::Session session(env, onnx_path.c_str(), session_options);
        
        // Get input names
        Ort::AllocatorWithDefaultOptions allocator;
        size_t num_input_nodes = session.GetInputCount();
        std::cout << "Number of inputs: " << num_input_nodes << std::endl;
        
        for (size_t i = 0; i < num_input_nodes; i++) {
            auto input_name = session.GetInputNameAllocated(i, allocator);
            std::cout << "Input " << i << " name: " << input_name.get() << std::endl;
        }
        
        // Get output names
        size_t num_output_nodes = session.GetOutputCount();
        std::cout << "Number of outputs: " << num_output_nodes << std::endl;
        
        for (size_t i = 0; i < num_output_nodes; i++) {
            auto output_name = session.GetOutputNameAllocated(i, allocator);
            std::cout << "Output " << i << " name: " << output_name.get() << std::endl;
        }
        
    } catch (const Ort::Exception& e) {
        std::cerr << "ONNX Runtime error: " << e.what() << std::endl;
        return -1;
    }
    
    return 0;
} 