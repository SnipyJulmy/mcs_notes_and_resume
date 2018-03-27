/*----------------------------------------------------------------------------
Stack "module" : test progam

Usage: progr_name [input_file] ]output_file]

Beat Hirsbrunner, 20 October 2011
----------------------------------------------------------------------------*/

#include <stdio.h>
#include "stack.h"  // STACK_OVERFLOW, STACK_IS_EMPTY, stack_error, push, pop


void print_usage()
{
  printf("\n");
  printf("push/pop usage:  p)push(f)      o)pop\n");
  printf("constants     :  S)STACK_SIZE   E)STACK_IS_EMPTY   e)stack_error\n");  
  printf("Test program usage: H)Help      Q)Quit\n\n");
}


main(){
  char c; 
  double v;

  char *prompt = ">";

  print_usage();
  printf("%s", prompt);
  
  stack_error = 0;  // no error until now

  while (c = getchar()) { // main loop
    switch(c) {

      case 'p': // push
        scanf("%lf", &v);
        push(v);
        if (stack_error == 0) printf("push: %lf\n", v);
        else {printf("error --- stack_is_full : %i\n", stack_error); stack_error = 0;}
        break;

      case 'o': // pop
        v = pop();
        if (stack_error == 0) printf("pop : %lf\n", v);
        else {printf("error --- stack_is_empty: %i\n", stack_error); stack_error = 0;}
       break;

      case 'S': // STACK_SIZE
        printf("STACK_SIZE: %i\n", STACK_SIZE);
       break;

      case 'E': // STACK_IS_EMPTY
        printf("STACK_IS_EMPTY: %i\n", STACK_IS_EMPTY);
       break;

      case 'e': // stack_eror
        printf("stack_error: %i\n", stack_error);
       break;

      case 'H': // Help
        print_usage();
        break;

      case 'Q': // Quit
        return 0;

      default:
        print_usage();
        break;
    } // end switch

    while (getchar() != '\n') {} /* skip end of line */
    printf("%s", prompt);

  } // end main loop

}