#include "array_stack.h"

int main()
{
    // creates a stack of max. 20 int
    Stack* s = stackCreate(sizeof(int), 20);
    int a = 4, b = 5;
    int d;

    stackPush(s,&a);
    printf("Enqueue %d\n",a);
    stackPush(s,&b);
    printf("Enqueue %d\n",b);
    stackPop(s,&d);
    printf("Dequeue %d\n",d);
    stackPop(s,&d);
    printf("Dequeue %d\n",d);

    stackDestroy(s);
}