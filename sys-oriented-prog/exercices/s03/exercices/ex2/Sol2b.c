/*--------------------------------------------------------------------------
Replace a switch with gotos (Series 3, exercise 2b)

Usage: Sol2b  ## test with i = 1,2,3

Beat Hirsbrunner, 15 Sept. 2011, rev 10 Jan. 2015 --- template
NN, <date> --- implementation of a switch with gotos
--------------------------------------------------------------------------*/

#include <stdio.h>

int main()
{
    int i;

    printf("> i = ");
    scanf("%i", &i);

/*-----------  switch   -----------*/
    switch (i)
    {
        case 1:
            printf("case 1 \n");
            break;
        case 2:
            printf("case 2\n"); // beware: no break !!
        default:
            printf("default case \n");
            break;  // break unnecessary, but good programming habit
    }
/*-----------  /switch   -----------*/

    printf("\n");

/*-----------  switch with a goto   -----------*/

    if (i == 1) goto case1;
    if (i == 2) goto case2;
    goto caseDefault;

    case1 :
    printf("case 1 \n");
    goto end; // break

    case2 :
    printf("case 2 \n");

    caseDefault:
    printf("default case \n");
    goto end; // unnecessary, but we follow the code example

    end:;
/*-----------  /switch with a goto  -----------*/
}
