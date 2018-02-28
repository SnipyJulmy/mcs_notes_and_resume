//
// Created by snipy on 27.02.18.
//

#include "stdio.h"

void main(void) {
    char c='A';
    int i=65;
    float pi=3.14;

    printf("%c %i\n", c, c);
    printf("%c %i\n", i, i);
    printf("%f %i\n", pi, (int)pi);
    printf("%f %i\n", pi, pi);

    printf("%i \n", (char) i);
}

