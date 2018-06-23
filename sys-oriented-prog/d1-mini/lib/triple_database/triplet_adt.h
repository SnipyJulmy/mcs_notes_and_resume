//
// Created by snipy on 01.05.18.
//

#ifndef P01_TRIPLET_ADT_H
#define P01_TRIPLET_ADT_H

#include "stdbool.h"

typedef struct Triplet Triplet;
struct Triplet
{
    char* s;
    char* p;
    char* o;
    bool is_used;

    /* Methods */
    void (* destroy)(Triplet* self); // to free the memory used by the triplet
};

char* s(Triplet* triplet);
char* p(Triplet* triplet);
char* o(Triplet* triplet);


#endif //P01_TRIPLET_ADT_H
