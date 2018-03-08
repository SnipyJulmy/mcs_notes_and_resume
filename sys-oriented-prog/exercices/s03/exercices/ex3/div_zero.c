#include <stdio.h>
int N = 3;
int main() {
   int ctr, i;
   int res;

   i = N;
   res = N;

   printf("res  N  i\n");
   for (ctr = 0; ctr <= N; ++ctr, --i) { // 'ctr <= N' for exercice 5
      res = N/i;
      printf("%3i%3i%3i\n",res, N, i);
   }
  
   return 0;
}

/*--------------------------------------------------------------------------
A for loop to be observed with gdb (Series 3, exercises 4 and 5)

Usage: <prog_name>

© Beat Hirsbrunner, 15 Jan. 2014
--------------------------------------------------------------------------*/