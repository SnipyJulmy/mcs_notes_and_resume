#include <stdio.h>
#include <stdlib.h>

#define square(x) ((x) * (x))

// PRE : x and y are variable identifier of type Type
#define swap(x, y, Type) do{Type t = x; x=y;y=t;}while(0);

int main()
{
    int x = 2;
    int y = 3;

    printf("x : %d\ny : %d\n\n", x, y);
    swap(x, y, int);
    printf("x : %d\ny : %d\n\n", x, y);

    return EXIT_SUCCESS;
}