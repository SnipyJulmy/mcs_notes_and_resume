//
// Created by snipy on 27.02.18.
//

#include "stdio.h"

#define AT '\100' // constant in octal

void main(void)
{
    char at = '\x40'; // variable in hexadecimal
    printf("%c %i %o %x\n", '@', '@', '@', '@');
    printf("%c %i %o %x\n", AT, AT, AT, AT);
    printf("%c %i %o %x\n", at, at, at, at);
}

