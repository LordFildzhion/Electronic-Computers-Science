#include <opencv2/opencv.hpp>
#include <iostream>

int main(){

    cv::Mat myImage;
    cv::namedWindow("lab5_evm");
    cv::VideoCapture cap(0);


    if (!cap.isOpened()) {
        std::cout << "No video stream detected" << std::endl;
        return -1;
    }

    cv::TickMeter tm_full, tm_enter, tm_morph, tm_show, tm_wait;
    int full_frame_count = 0;

    tm_full.start();
    while(true) {

        tm_enter.start();
        cap >> myImage;
        if ( myImage.empty() ) { break; }
        tm_enter.stop();

        tm_morph.start();
        cv::flip(myImage, myImage, 0);
        tm_morph.stop();

        tm_show.start();
        cv::imshow("lab5_evm", myImage);
        tm_show.stop();

        tm_wait.start();
        if (cv::waitKey(1) == 27) { break; }
        tm_wait.stop();

        full_frame_count++;
    }

    tm_full.stop();
    std::cout << "Time working: " << tm_full.getTimeSec()                                                                                     << std::endl 
              <<  "Average fps: " << full_frame_count / tm_full.getTimeSec()                                             << " fraps"          << std::endl 
              << "Enter: "        << (tm_enter.getTimeSec() / (tm_full.getTimeSec() - tm_wait.getTimeSec()) * 100)       << "%"        << " " << std::endl 
              << "Morph: "        << (tm_morph.getTimeSec() / (tm_full.getTimeSec() - tm_wait.getTimeSec()) * 100)       << "%"        << " " << std::endl 
              << "Show: "         << (tm_show.getTimeSec() / (tm_full.getTimeSec() - tm_wait.getTimeSec()) * 100)        << "%"        << " " << std::endl;

    cap.release();

    return 0;
}