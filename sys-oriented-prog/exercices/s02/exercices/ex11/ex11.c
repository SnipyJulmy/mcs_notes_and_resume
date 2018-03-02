#include <stdio.h>

int f();
int g();
int n;

void main(void)
{
    f() + g();
    printf("%i\n", ++n, f(n));
}

int f()
{
    return 1;
}

int g()
{
    return 1;
}
