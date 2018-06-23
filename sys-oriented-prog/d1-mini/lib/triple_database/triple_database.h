//
// Created by snipy on 17.04.18.
//

#ifndef P01_TRIPLE_DATABASE_H
#define P01_TRIPLE_DATABASE_H

#include <stdbool.h>

#include "../data_structure/dequeue/dequeue.h"
#include "index/triple_database_static_dup_index.h"
#include "index/triple_database_dynamic_index.h"
#include "triplet_adt.h"

#define TRIPLET_FIELD_CAPACITY 1024

enum IndexType
{
    STATIC, DYNAMIC
};
typedef enum IndexType IndexType;

typedef struct Database Database;
struct Database
{
    // fields
    int size;
    int capacity;
    int first_available_index;

    // data
    Triplet** data;

    // indexes
    IndexType index_type;

    // static index
    StaticIndex* s_index;
    StaticIndex* p_index;
    StaticIndex* o_index;

    // dynamic index
    DynamicIndex* dynamic_index;

    /* Methods */
    void (* destroy)(Database* self); // to free the database
    int (* insert)(Database* self, char* s, char* p, char* o);
    int (* match)(Database* self, char* s, char* p, char* o, long result);
    int (* _delete)(Database* self, char* s, char* p, char* o, long result);
    int (* match_with_index)(Database* self, char* s, char* p, char* o, long result);
    Dequeue* (* ls)(Database* self);

    // for indexes
    bool (* use_index)(Database* self, IndexType index_type);
    bool (* make_index)(Database* self);

    /* Internal */
    void (* double_capacity)(Database* self); // double the capacity of the database
    int (* search_first_available_index)(Database* self);
};

Database* database_create(int capacity);
Triplet* triplet_create(char* s, char* p, char* o);

#endif //P01_TRIPLE_DATABASE_H
