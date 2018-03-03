#include <stdio.h>
#include <assert.h>

void main(void)
{
    char c;
    int i;
    char string[10];
    float f;

    // parse the char, integer, string and the float in one line
    int res = scanf("%c %d %s %f", &c, &i, string, &f);
    assert(res == 4);

    printf("char value : %c\n"
           "integer value : %i\n"
           "string value : %s\n"
           "float value : %f\n",
           c, i, string, f);
}
