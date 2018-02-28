#include <stdio.h>

// @expr should contains variable with identifier p and q
#define thrut_table_2(expr)\
    for(int i = 1; i >= 0; i--)\
    for(int j = 1; j >= 0; j--)\
    {\
        p = i;\
        q = j;\
        printf("%i\n",expr);\
    }

void main(void)
{
    int p;
    int q;

    thrut_table_2(p || !q);
    printf("+---------------------------------+\n");
    thrut_table_2(p && (p == q));
    printf("+---------------------------------+\n");
    thrut_table_2(p && (p = q) || (p = !q));
}
