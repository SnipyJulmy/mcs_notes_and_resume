cmake_minimum_required(VERSION 3.9)
project(exercises C)

set(CMAKE_C_STANDARD 11)

add_executable(exercises main.c priority_queue/priority_queue.c priority_queue/priority_queue.h)