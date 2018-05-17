cmake_minimum_required(VERSION 3.10)
project(exercices C)

set(CMAKE_C_STANDARD 11)

include_directories(.)

add_executable(queue
        array_stack.c
        array_stack.h
        array_stack_main.c
        )

add_executable(graph
        minimal_tree.c
        )