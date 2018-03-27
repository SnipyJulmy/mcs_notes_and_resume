/*------------------------------------------------------------------------
Reverse Polish Calculator - kr76-79

usage: progr_name [input_file] ]output_file]

Adapted by Beat Hirsbrunner, October 2011
------------------------------------------------------------------------*/

#include <stdio.h>
#include <stdlib.h>	// atof

#include "./stack/stack.h"  // push, pop
#include "./stack/stack.h"  // push, pop
#include "./getop/getop.h"  // GETOP_ERR, MAXOP, NUMBER, getop

int stack_error;

// reverse Polish calculator --- kr76
main()
{
    int type;
    double op2;
    char s[MAXOP+1];  // MAXOP = maximum size of operand or operator


    while ((type = getop(s)) != EOF) {
        switch (type) {
        case NUMBER:
            push(atof(s));
            break;
        case '+':
            push(pop() + pop());
            break;
        case '*':
            push(pop() * pop());
            break;
        case '-':
            op2 = pop();
            push(pop() - op2);
            break;
        case '/':
            op2 = pop();
            if (op2 != 0.0)
                push(pop() / op2);
            else
                printf("error: zero divisor\n");
            break;
        case '\n':
            printf("\t%.8g\n", pop());
            break;
        case GETOP_ERR:
            printf("ERROR -- getop() failed to read a number : %s\n", s); 
            break;           
        default:
            printf("error: unknown command %s\n", s);
            break;
        }
    }
    return 0;
}
