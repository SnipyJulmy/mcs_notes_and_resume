/*----------------------------------------------------------------------------
getop "module" : test program

Usage: prog_name [input_file] ]output_file]

Beat Hirsbrunner, University of Fribourg, 20 October 2011
----------------------------------------------------------------------------*/

#include <stdio.h>  // EOF, printf
#include "getop.h"  // GETOP_ERR, MAXOP, NUMBER, getop

main() { // Test progam
	int type;
	char s[MAXOP+1]; // MAXOP = maximum size of operand or operator

    printf("\n>type some operands or operators; blanks are skiped; terminate by typing Q\n\n");
    
    while ((type = getop(s)) != EOF) {
        switch (type) {
            case NUMBER:
                printf("operand : %s\n", s);
                break;

            case GETOP_ERR:
                printf("ERROR --- getop() failed to read a number (MAXOP=%i): %s\n", MAXOP, s); 
                break;           

            case '+': case '-': case '*': case '/':  // recognized characters
                printf("operator: %c\n", type);
                break;

            case ' ': case '\t': case '\n': break;  // skip blanks


            case 'Q': return 0;

            default:                                // not recognized characters
                printf("error --- not recognized character %s\n", s);
                break;
        }
    }
}
