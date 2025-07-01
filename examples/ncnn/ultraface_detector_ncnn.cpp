#include <iostream>
#include <vector>
#include <string>
#include <opencv2/opencv.hpp>
#include <net.h>

struct FaceBox {
    float x1, y1, x2, y2, score;
};

int main() {
    std::string model_param = "assets/ultraface.param"; // 需准备 ncnn 格式模型
    std::string model_bin = "assets/ultraface.bin";
    std::string image_path = "assets/test_lite_ultraface.jpg";
    cv::Mat img = cv::imread(image_path);
    if (img.empty()) {
        std::cerr << "Failed to load image: " << image_path << std::endl;
        return -1;
    }

    // NCNN 加载模型
    ncnn::Net net;
    if (net.load_param(model_param.c_str()) != 0 || net.load_model(model_bin.c_str()) != 0) {
        std::cerr << "Failed to load ncnn model." << std::endl;
        return -1;
    }

    // UltraFace 输入尺寸
    const int target_w = 320;
    const int target_h = 240;
    cv::Mat resized;
    cv::resize(img, resized, cv::Size(target_w, target_h));

    // 转 ncnn::Mat
    ncnn::Mat in = ncnn::Mat::from_pixels(resized.data, ncnn::Mat::PIXEL_BGR2RGB, target_w, target_h);
    // 归一化
    const float mean_vals[3] = {127.0f, 127.0f, 127.0f};
    const float norm_vals[3] = {1.0f/128, 1.0f/128, 1.0f/128};
    in.substract_mean_normalize(mean_vals, norm_vals);

    // 推理
    ncnn::Extractor ex = net.create_extractor();
    ex.input("input", in);
    ncnn::Mat out;
    ex.extract("output", out);

    // 后处理（假设输出格式为 N x 6: x1, y1, x2, y2, score, label）
    std::vector<FaceBox> faces;
    float score_threshold = 0.7f;
    for (int i = 0; i < out.h; ++i) {
        const float* values = out.row(i);
        float conf = values[4];
        if (conf < score_threshold) continue;
        FaceBox box;
        box.x1 = values[0] * img.cols / target_w;
        box.y1 = values[1] * img.rows / target_h;
        box.x2 = values[2] * img.cols / target_w;
        box.y2 = values[3] * img.rows / target_h;
        box.score = values[4];
        faces.push_back(box);
    }

    // 可视化
    for (const auto& face : faces) {
        cv::rectangle(img, cv::Point(face.x1, face.y1), cv::Point(face.x2, face.y2), cv::Scalar(0,255,0), 2);
        char text[32];
        sprintf(text, "%.2f", face.score);
        cv::putText(img, text, cv::Point(face.x1, face.y1-5), cv::FONT_HERSHEY_SIMPLEX, 0.5, cv::Scalar(0,255,0), 1);
    }
    std::cout << "Detected faces: " << faces.size() << std::endl;
    cv::imwrite("ultraface_ncnn_result.jpg", img);
    std::cout << "Result saved to ultraface_ncnn_result.jpg" << std::endl;
    return 0;
} 