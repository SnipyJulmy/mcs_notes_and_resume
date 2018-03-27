/* ----------------------------------------------------------------------------
getop "module" : implementation                                        --- kr78
   
Adapted by Beat Hirsbrunner, October 2011
---------------------------------------------------------------------------- */

#include <stdio.h>    // EOF
#include <ctype.h>    // isdigit
#include "getop.h"    // GETOP_ERR, MAXOP, NUMBER, getop
#include "../ungetch/ungetch.h" // getch, ungetch


// getop: get next operator or numeric operand --- kr78
// with a very primitive error diagnostic (note hat s[] overflow is not cheked !!!)
int getop(char s[])
{
    int i, c;

    while ((s[0] = c = getch()) == ' ' || c == '\t')
        ;
    s[1] = '\0';
    if (!isdigit(c) && c != '.')
        return c;		// not a number
    i = 0;
    if (isdigit(c))		// collect integer part
        while (isdigit(s[++i] = c = getch()))
            ;
    if (c == '.')		// collect fraction part
        while (isdigit(s[++i] = c = getch()))
            ;
    s[i] = '\0';
    if (c != EOF)
        ungetch(c);
    if (i <= MAXOP) return NUMBER;
    else {s[MAXOP]='\0'; return GETOP_ERR;}
}