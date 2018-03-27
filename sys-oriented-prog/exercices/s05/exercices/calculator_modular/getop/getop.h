/*----------------------------------------------------------------------------
getop "module" : specification                                        --- kr79

Adapted by Beat Hirsbrunner, University of Fribourg, 20 October 2011
----------------------------------------------------------------------------*/

#define NUMBER 0     // signal that a number was found

#define MAXOP  5	 // max size of operand or operator
#define GETOP_ERR -3

#include "../stack/stack.h"  // push, pop

int getop(char []);
