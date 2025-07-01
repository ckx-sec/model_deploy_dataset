#include <iostream>
#include <vector>
#include <string>
#include <opencv2/opencv.hpp>
#include <net.h>
#include <algorithm>

struct Object {
    cv::Rect_<float> rect;
    int label;
    float prob;
};

// NMS implementation
static void nms_sorted_bboxes(const std::vector<Object>& objects, std::vector<int>& picked, float nms_threshold)
{
    picked.clear();
    const size_t n = objects.size();
    std::vector<float> areas(n);
    for (size_t i = 0; i < n; i++) {
        areas[i] = objects[i].rect.area();
    }
    for (size_t i = 0; i < n; i++) {
        const Object& a = objects[i];
        int keep = 1;
        for (int j : picked) {
            const Object& b = objects[j];
            float inter_area = (a.rect & b.rect).area();
            float union_area = areas[i] + areas[j] - inter_area;
            if (inter_area / union_area > nms_threshold)
                keep = 0;
        }
        if (keep) picked.push_back(i);
    }
}

int main() {
    std::string model_param = "assets/yolov5.param";
    std::string model_bin = "assets/yolov5.bin";
    std::string image_path = "assets/test_lite_yolov5_1.jpg";
    cv::Mat img = cv::imread(image_path);
    if (img.empty()) {
        std::cerr << "Failed to load image: " << image_path << std::endl;
        return -1;
    }

    // NCNN 加载模型
    ncnn::Net net;
    net.opt.use_vulkan_compute = false;
    if (net.load_param(model_param.c_str()) != 0 || net.load_model(model_bin.c_str()) != 0) {
        std::cerr << "Failed to load ncnn model." << std::endl;
        return -1;
    }

    // 输入尺寸（根据实际模型调整）
    const int target_size = 640;
    const float mean_vals[3] = {0.f, 0.f, 0.f};
    const float norm_vals[3] = {1.0f/255, 1.0f/255, 1.0f/255};

    // letterbox resize
    int w = img.cols;
    int h = img.rows;
    float scale = std::min(target_size / (w*1.f), target_size / (h*1.f));
    int new_w = w * scale;
    int new_h = h * scale;
    cv::Mat resized;
    cv::resize(img, resized, cv::Size(new_w, new_h));
    cv::Mat input = cv::Mat::zeros(target_size, target_size, CV_8UC3);
    resized.copyTo(input(cv::Rect(0, 0, new_w, new_h)));

    // 转 ncnn::Mat
    ncnn::Mat in = ncnn::Mat::from_pixels(input.data, ncnn::Mat::PIXEL_BGR2RGB, target_size, target_size);
    in.substract_mean_normalize(mean_vals, norm_vals);

    // 推理
    ncnn::Extractor ex = net.create_extractor();
    ex.input("images", in);
    ncnn::Mat out;
    ex.extract("output", out);

    // 后处理
    std::vector<Object> proposals;
    float conf_threshold = 0.25f;
    for (int i = 0; i < out.h; i++) {
        const float* values = out.row(i);
        Object obj;
        obj.label = static_cast<int>(values[0]);
        obj.prob = values[1];
        float x = values[2];
        float y = values[3];
        float w_box = values[4];
        float h_box = values[5];
        // 坐标还原
        float x0 = (x - w_box/2.f) * target_size;
        float y0 = (y - h_box/2.f) * target_size;
        float x1 = (x + w_box/2.f) * target_size;
        float y1 = (y + h_box/2.f) * target_size;
        // 反 letterbox
        x0 = std::max((x0 - 0) / scale, 0.f);
        y0 = std::max((y0 - 0) / scale, 0.f);
        x1 = std::min((x1 - 0) / scale, (float)w);
        y1 = std::min((y1 - 0) / scale, (float)h);
        obj.rect = cv::Rect_<float>(x0, y0, x1-x0, y1-y0);
        if (obj.prob > conf_threshold) proposals.push_back(obj);
    }
    // NMS
    std::sort(proposals.begin(), proposals.end(), [](const Object& a, const Object& b) { return a.prob > b.prob; });
    std::vector<int> picked;
    nms_sorted_bboxes(proposals, picked, 0.45f);
    // 可视化
    for (int idx : picked) {
        const Object& obj = proposals[idx];
        cv::rectangle(img, obj.rect, cv::Scalar(0,255,0), 2);
        char text[32];
        sprintf(text, "%.2f", obj.prob);
        cv::putText(img, text, cv::Point(obj.rect.x, obj.rect.y-5), cv::FONT_HERSHEY_SIMPLEX, 0.5, cv::Scalar(0,255,0), 1);
    }
    std::cout << "Detected objects: " << picked.size() << std::endl;
    cv::imwrite("yolov5_ncnn_result.jpg", img);
    std::cout << "Result saved to yolov5_ncnn_result.jpg" << std::endl;
    return 0;
} 