cmake_minimum_required(VERSION 3.9)
project(exercises C)

find_package(Threads)

set(CMAKE_C_STANDARD 11)

add_executable(pizza pizza/pizza.c)

target_link_libraries(pizza ${CMAKE_THREAD_LIBS_INIT})