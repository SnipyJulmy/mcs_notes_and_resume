/*--------------------------------------------------------------------------
Replace a for loop with a goto (Series 3, exercise 2a)

Usage: Sol2a  ## test with n = 5, 0

Beat Hirsbrunner, 15 Sept. 2011, rev 10 Jan. 2015 --- template
NN, <date> --- implementation of a for loop with a goto
--------------------------------------------------------------------------*/


#include <stdio.h>

int main() {
   int i, n;

   printf("> n = ");
   scanf( "%i", &n);

/*-----------  for loop   -----------*/
   for (i = 0; i < n; i++) {
      printf("%i\n", i);
   }
/*-----------  /for loop   -----------*/ 

   printf("i_final = %i\n", i);
   printf("\n");

/*-----------  for loop with a goto   -----------*/ 
   printf("Not yet implemented\n");                           //¥¥¥-------------
/*-----------  /for loop with a goto   -----------*/ 

   printf("i_final = %i\n", i);
}
