// Generic stack backed by an array
// Adapted from github.com/jiten-thakkar

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>

// Main structure containing all elements
typedef struct
{
    size_t memberSize;
    int maxElements;
    void* data;
    int top;
    int back;
} Stack;

Stack* stackCreate(size_t memberSize, int maxElements);
void stackDestroy(Stack* s);
void stackPush(Stack* s, void* data);
void stackPop(Stack* s, void* target);
void stackTop(Stack* s, void* target);
