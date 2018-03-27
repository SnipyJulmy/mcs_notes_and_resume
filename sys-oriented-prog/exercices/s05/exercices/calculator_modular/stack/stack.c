/*----------------------------------------------------------------------------
Stack "module" : implementation                                      ---- kr77

Adapted by Beat Hirsbrunner, 20 October 2011
----------------------------------------------------------------------------*/

#include "stack.h"  // STACK_OVERFLOW, STACK_IS_EMPTY, stack_error, push, pop

static int    sp = 0;		     // next free stack position, private variable
static double stack[STACK_SIZE];	 // private stack array

void push(double f)
{
    if (sp < STACK_SIZE)
        stack[sp++] = f;
    else
        stack_error = STACK_OVERFLOW;
}

double pop(void)
{
    if (sp > 0)
        return stack[--sp];
    else {
        stack_error = STACK_IS_EMPTY;
        return -1;  // it is unwise not to return a value !!!
    }
}

