cmake_minimum_required(VERSION 3.10)

project(lab-5)

set(OpenCV_DIR C:/opencv/build/x64/vc16)

find_package(OpenCV REQUIRED)

include_directories(${OpenCV_INCLUDE_DIRS})

add_executable(${PROJECT_NAME} main.cpp)

target_link_libraries(${PROJECT_NAME} ${OpenCV_LIBS})
