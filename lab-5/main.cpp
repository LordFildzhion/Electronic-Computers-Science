#include <opencv2/opencv.hpp>
#include <iostream>

int main(){

    cv::Mat myImage;
    cv::namedWindow("lab5_evm");
    cv::VideoCapture cap(0);

    cv::TickMeter tm_full, tm;

    if (!cap.isOpened()){
        std::cout << "No video stream detected" << std::endl;
        return -1;
    }

    int full_frame_count = 0;
    double full_time_enter = 0, full_time_morph = 0, full_time_show = 0;

    tm_full.start();
    while (true){

        tm.start();
        cap >> myImage;
        if ( myImage.empty() ) { break; }
        tm.stop();
        full_time_enter += tm.getTimeSec();
        tm.reset();

        tm.start();
        cv::flip(myImage, myImage, 0);
        tm.stop();
        full_time_morph += tm.getTimeSec();
        tm.reset();

        tm.start();
        cv::imshow("lab5_evm", myImage);
        tm.stop();
        full_time_show += tm.getTimeSec();
        tm.reset();

        if (cv::waitKey(1) == 27) { break; }

        full_frame_count++;
    }
    tm_full.stop();

    double percent = (full_time_enter + full_time_morph + full_time_show) / 100;

    std::cout << "Time working: " << tm_full.getTimeSec()                    << " seconds" << std::endl 
              <<  "Average fps: " << full_frame_count / tm_full.getTimeSec() << " fraps"   << std::endl 
              << "Enter: "        << (full_time_enter / percent)             << "%"        << std::endl 
              << "Morph: "        << (full_time_morph / percent)             << "%"        << std::endl 
              << "Show: "         << (full_time_show / percent)              << "%"        << std::endl;

    cap.release();

    return 0;
}