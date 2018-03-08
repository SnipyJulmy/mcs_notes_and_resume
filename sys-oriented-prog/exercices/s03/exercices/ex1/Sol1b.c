/*--------------------------------------------------------------------------
Replace a while loop with a do-while loop (Series 3, exercise 1b)

Usage: Sol1b  ## test with n = 5, 0

Beat Hirsbrunner, 15 Sept. 2011, rev 10 Jan. 2015 --- template
NN, <date> --- implementation of a do-while loop
--------------------------------------------------------------------------*/

#include <stdio.h>

int main()
{
    int low, high, n;

    printf("> n = ");
    scanf("%i", &n);

    low = 0;
    high = n - 1;
/*----------   while loop     ----------*/
    while (low <= high)
    {
        printf("%i\n", low);
        ++low;
    }
/*----------   /while loop     ----------*/

    printf("low_final = %i\n", low);
    printf("\n");

    low = 0;
/*----------   do-while loop     ----------*/

    if (low > high) goto end;
    do
    {
        printf("%i\n", low);
        low++;
    } while (low <= high);

    end:

/*----------   /do-while loop     ----------*/

    printf("low_final = %i\n", low);
}
