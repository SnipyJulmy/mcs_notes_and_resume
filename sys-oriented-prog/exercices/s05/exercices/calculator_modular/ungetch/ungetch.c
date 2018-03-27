/*--------------------------------------------------------------------------
ungetch "module" : implementation                                  --- kr79

Adapted by Beat Hirsbrunner, 20 October 2011
--------------------------------------------------------------------------*/

#include <stdio.h>    // getchar
#include "ungetch.h"  // BUF_OVERFLOW, BUF_SIZE, getch, ungetch

static int buf[BUF_SIZE];	// buffer for ungetch; private variable
static int bufp = 0;		// next free position in buf; private variable

int getch(void)	// get a (possibly pushed back) character
{
    return (bufp > 0) ? buf[--bufp] : getchar();
}

int ungetch(int c)	// push character back on input
{
    if ( bufp >= BUF_SIZE)
        return BUF_OVERFLOW; // error: buffer overflow
    else
        {buf[bufp++] = c; return 0;}
}
