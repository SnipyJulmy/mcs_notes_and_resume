#include <assert.h>
#include <stdio.h>

unsigned long setbit(unsigned long x, int n);

#define t_setbit(x,n,r) assert(setbit((unsigned long)(x),n) == (unsigned long)(r));

void main(void)
{
    t_setbit(8,0,9)
    t_setbit(100,0,101)
    t_setbit(97,0,97)
    t_setbit(7,3,15)
}

unsigned long setbit(unsigned long x, int n)
{
    return x | (((unsigned long) 1) << n);
}
