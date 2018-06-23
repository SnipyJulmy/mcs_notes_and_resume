//
// Created by snipy on 25.04.18.
//

#ifndef P01_TRIPLE_DATABASE_STATIC_DUP_INDEX_H
#define P01_TRIPLE_DATABASE_STATIC_DUP_INDEX_H

#include <stdbool.h>
#include <stdint.h>
#include "../triplet_adt.h"


typedef struct StaticIndex StaticIndex;

struct StaticIndex
{
    Triplet** triplets;
    int nb_triplets;

    // Methods
    Triplet* (* search)(StaticIndex* self, char* field, long result);

    // Utility methods
    char* (* used_field)(Triplet* triplet); // return the used fields of the index
    void (* destroy)(StaticIndex* self); // free the StaticIndex structure

    // Debug methods
    void (* display)(StaticIndex* self);
};

StaticIndex* triple_database_make_index(Triplet** triplets, int nb_triplets, char* (* used_field)(Triplet*));

#endif //P01_TRIPLE_DATABASE_STATIC_DUP_INDEX_H
