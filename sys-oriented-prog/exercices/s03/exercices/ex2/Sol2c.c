/*--------------------------------------------------------------------------
Replace a break with a goto (Series 3, exercise 2c)

Usage: Sol2c  ## test with n = 5

Beat Hirsbrunner, 15 Sept. 2011, rev 10 Jan. 2015 --- template
NN, <date> --- implementation of a break with a goto
--------------------------------------------------------------------------*/

#include <stdio.h>

int main()
{
    int i, n;

    printf("> n = ");
    scanf("%i", &n);

/*-----------  break   -----------*/
    for (i = 0; i < n; i++)
    {
        printf("action 1, i=%i\n", i);
        if (i > 0) break;
        printf("action 2, i=%i\n", i);
    }
/*-----------  /break   -----------*/

    printf("\n");

/*-----------  break with a goto  -----------*/
    for (i = 0; i < n; i++)
    {
        printf("action 1, i=%i\n", i);
        if (i > 0) goto end;
        printf("action 2, i=%i\n", i);
    }
    end:;
/*-----------  /break with a goto   -----------*/
}
