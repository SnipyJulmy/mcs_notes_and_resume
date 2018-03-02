#include <stdio.h>

void main(void)
{
    char str[3]; int i, d;
    d = scanf("%s %i", str, &i);
    printf("%s %i %i\n",str,i,d);
    d = scanf("%s %i", str, &i);
    printf("%s %i %i\n",str,i,d);
    d = scanf("%s %i", str, &i);
    printf("%s %i %i\n",str,i,d);

}
