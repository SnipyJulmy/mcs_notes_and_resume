/*----------------------------------------------------------------------------
un_getch "module" : test program

Usage: progr_name [input_file] ]output_file]

Remark: in order also to test values of non printable characters, like '\n' 
(end of line), their ASCII value in decimal are first printed, e.g. 10 for '\n', 
and -1 for EOF.

Beat Hirsbrunner, University of Fribourg, 20 October 2011
----------------------------------------------------------------------------*/

#include <stdio.h>
#include "ungetch.h" // BUF_SIZE, BUF_OVERFLOW, getch, ungetch

void print_usage()
{
  printf("\n");
  printf("getch/ungetch usage:  g)getch()   u)ungetch(c)\n");
  printf("constants          :  s)BUF_SIZE  o)BUF_OVERFLOW\n");  
  printf("push back          :  e)'\\n'      E)EOF\n");
  printf("Test program usage :  H)Help      Q)Quit\n\n");
}

main () 
{
  char c;
  int c_get; 

  char *prompt = ">";

  print_usage();
  printf("%s", prompt);

  while (c = getchar()) { // main loop
    switch(c) {

      case 'g': // getch -- read the next character from standard input
        c_get = getch();
        printf("returned by getch: %i %c\n", c_get, c_get);
        break;

      case 'u': // ungetch -- push back the next readed character by getchar()
                // ungetch -- with error treatment
        c_get = getchar();
        if (ungetch(c_get) != BUF_OVERFLOW) {
           printf("pushed back: %i %c\n", c_get, c_get);
           ++c_get; // to test the behavior when suuccessive ungetch calls are made
        } else { // error --- buffer overflow
           printf("error -- buffer overflow -- character has not been pushed back: %i %c\n", c_get, c_get);
        }          
        break;

      case 's': // BUF_SIZE
        printf("BUF_SIZE: %i\n", BUF_SIZE);
        break;

      case 'o': // BUF_OVERFLOW
        printf("BUF_OVERFLOW: %i\n", BUF_OVERFLOW);
        break;

      case 'e': //
        ungetch('\n');
        printf("'\\n' has been pushed back: %i\n", '\n');
        break;

      case 'E': //
        ungetch(EOF);
        printf("EOF has been pushed back: %i\n", EOF);
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

    while (getchar() != '\n') {}  // skip end of line
    printf("%s", prompt);

  } // end main loop
}
