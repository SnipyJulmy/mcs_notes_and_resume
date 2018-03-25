cmake_minimum_required(VERSION 3.9)
project(exercises C)

find_package(Threads)

set(CMAKE_C_STANDARD 11)

add_executable(ex4_a ex4_a.c)
add_executable(ex4_b ex4_b.c)

target_link_libraries(ex4_a ${CMAKE_THREAD_LIBS_INIT})
target_link_libraries(ex4_b ${CMAKE_THREAD_LIBS_INIT})
