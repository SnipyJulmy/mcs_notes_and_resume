#include "array_stack.h"

Stack* stackCreate(size_t memberSize, int maxElements)
{
    Stack* s = malloc(sizeof(Stack));
    if (s == NULL)
    {
        // failed to allocate memory
        fprintf(stderr, "Couldn't allocate memory\n");
        exit(1);
    }
    s->top = 0;
    s->back = 0;
    s->memberSize = memberSize;
    s->maxElements = maxElements;
    s->data = malloc(maxElements * memberSize);
    if (s->data == NULL)
    {
        // failed to allocate memory
        fprintf(stderr, "Couldn't allocate memory\n");
        exit(1);
    }
    return s;
}

void stackDestroy(Stack* s)
{
    free(s->data);
    free(s);
}

void stackPush(Stack* s, void* data)
{
    // check if data is valid; if false, writes to stderr
    assert(data);
    //check is the stack is full
    if (s->top == s->back - 1)
    {
        fprintf(stderr, "Stack is full\n");
        exit(2);
    }
    s->top = (s->top + 1) % s->maxElements;
    //calculate starting location for the new element
    void* target = (char*) s->data + (s->top * s->memberSize);
    memcpy(target, data, s->memberSize);
}

void stackTop(Stack* s, void* target)
{
    assert(target);
    if (s->top == s->back)
    {
        printf("Stack is empty\n");
        target = NULL;
        return;
    }
    void* source = (char*) s->data + (s->back * s->memberSize);
    memcpy(target, source, s->memberSize);
}

void stackPop(Stack* s, void* target)
{
    assert(target);
    // check if stack is empty
    if (s->top == s->back)
    {
        fprintf(stderr, "Couldn't pop an empty stack\n");
        exit(3);
    }
    s->back = (s->back + 1) % s->maxElements;
    void* source = (char*) s->data + (s->back * s->memberSize);
    memcpy(target, source, s->memberSize);
}