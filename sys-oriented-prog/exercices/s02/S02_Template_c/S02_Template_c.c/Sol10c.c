/*--------------------------------------------------------------------------
Set the nth bit of x to 1 (Solution of Series 2, exercise 6c)

Usage: Sol6c //--- and type a long unsigned (x), an integer (n), and <return>; quit with ctrl-z

Hint: a good choice of <x, n> is: 
          a)  x=0 and n=0,1,2,3,4,...
          b)  x=2 and n=0,1,2,...

Beat Hirsbrunner, 15 September 2011 --- template with the not yet implemented function 'setbit' ---
<Name of Developer>, <date> --- implementation of the function 'setbit' ---
--------------------------------------------------------------------------*/
#include <stdio.h>

unsigned long setbit(unsigned long x, int n) {
   printf("NOT YET IMPLEMENTED\n");  //----- TO BE IMPLEMENTED -----
   return x;
}

int main() {
   unsigned long x, y;
   int n;
   
   printf("type a long unsigned x and an integer n: sets the nth bit of x to 1\n");
   while(1) { // quit with ctr-z
      scanf("%lu %i", &x, &n);  // scanf without error treatment
      y = setbit(x,n);
      printf("%lu %i %lu\n", x, n, y);
   }   
   return 0;
} 
