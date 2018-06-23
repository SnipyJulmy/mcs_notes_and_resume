//
// Created by snipy on 01.05.18.
//

#ifndef P01_TRIPLE_DATABASE_DYNAMIC_INDEX_H
#define P01_TRIPLE_DATABASE_DYNAMIC_INDEX_H

#include <stdint.h>
#include "../triplet_adt.h"

typedef enum COLOR
{
    BLACK = 0,
    RED = 1
} COLOR;

typedef struct DynamicIndex DynamicIndex;
typedef struct DynamicIndexNode DynamicIndexNode;

struct DynamicIndex
{
    // fields
    DynamicIndexNode* root;

    // methods
    void (* insert)(DynamicIndex* self, Triplet* data);
};

struct DynamicIndexNode
{
    // fields
    Triplet* data;
    DynamicIndexNode* parent;
    DynamicIndexNode* left;
    DynamicIndexNode* right;
    COLOR color;
    uint32_t key;

    // methods
    DynamicIndexNode* (* grand_parent)(DynamicIndexNode* self);
    DynamicIndexNode* (* sibling)(DynamicIndexNode* self);
    DynamicIndexNode* (* uncle)(DynamicIndexNode* self);
    DynamicIndexNode* (* insert)(DynamicIndexNode* root, DynamicIndexNode* self);
    bool (* is_leaf)(DynamicIndexNode* self);
    void (* rotate_left)(DynamicIndexNode** root, DynamicIndexNode* self);
    void (* rotate_right)(DynamicIndexNode** root, DynamicIndexNode* self);
};

DynamicIndex* triple_database_dynamic_index_create();
DynamicIndexNode* triple_database_dynamic_index_node_create(Triplet* data, uint32_t key);

#endif //P01_TRIPLE_DATABASE_DYNAMIC_INDEX_H
