//
// Created by snipy on 23.04.18.
//

#ifndef EXERCISES_PRIORITY_QUEUE_H
#define EXERCISES_PRIORITY_QUEUE_H

#include <glob.h>
#include <libzvbi.h>

typedef struct PtyQueue PtyQueue;
typedef struct TimestampNode TimestampNode;

struct PtyQueue
{
    /* Attributes */
    int size;
    int capacity;
    void** data;
    size_t elt_ptr_size;

    /* Methods */
    int (* comparotor_fn)(const void* elt1, const void* elt2);
    void (* free)(PtyQueue*);
    void (* enqueue)(PtyQueue*, const void*);
    void* (* dequeue)(PtyQueue*);
};

PtyQueue* priority_queue_create(int capacity, size_t elt_ptr_size, int (* cmp)(const void*, const void*));

struct TimestampNode
{
    int value;
    int timestamp;
};

TimestampNode* priority_queue_timestamp_node_create(int value, int timestamp);

int priority_queue_timestamp_compare(const void* a, const void* b);

#endif //EXERCISES_PRIORITY_QUEUE_H
