/*----------------------------------------------------------------------------
Stack "module" : implementation                                      ---- kr77

Adapted by Beat Hirsbrunner, 20 October 2011
----------------------------------------------------------------------------*/

#define STACK_SIZE       10

#define STACK_OVERFLOW   -1
#define STACK_IS_EMPTY   -2

int stack_error;

void push(double);  // if push is unsuccessful, stack_error is set to STACK_OVERFLOW
double pop(void);   // if pop is unsuccessful, stack_error is set to STACK_IS_EMPTY
