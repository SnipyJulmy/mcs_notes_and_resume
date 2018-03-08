/*--------------------------------------------------------------------------
Replace a continue with a goto (Series 3, exercise 2d)

Usage: Sol2d  ## test with n = 5

Beat Hirsbrunner, 15 Sept. 2011, rev 10 Jan. 2015 --- template
NN, <date> --- implementation of a continue with a goto
--------------------------------------------------------------------------*/

#include <stdio.h>

int main() {
   int i, n;

   printf("> n = ");   
   scanf("%i", &n);

/*-----------  continue   -----------*/ 
   for (i=0; i<n; i++) {
      printf("action 1, i=%i\n", i);
      if (i>0) continue;
      printf("action 2, i=%i\n", i);
   }  
/*-----------  /continue   -----------*/ 

   printf("\n");

/*-----------  continue with a goto  -----------*/ 
   for (i=0; i<n; i++) {
      printf("action 1, i=%i\n", i);
      printf("Not yet implemented\n");                        //¥¥¥-------------
      printf("action 2, i=%i\n", i);
   }  
/*-----------  /continue with a goto   -----------*/ 
}
