//
// Created by snipy on 23.04.18.
//

#include "priority_queue.h"

#include <stdlib.h>
#include <assert.h>

#define LEFT(x) (2 * (x) + 1)
#define RIGHT(x) (2 * (x) + 2)
#define PARENT(x) ((x) / 2)

// ----------------------------------------------------------------------------
// Private functions
// ----------------------------------------------------------------------------

static void __double_size(PtyQueue* queue)
{
    queue->capacity = queue->capacity * 2;
    void** data = queue->data;
    queue->data = malloc((size_t) (queue->capacity * queue->elt_ptr_size));
    for (int i = 0; i < queue->capacity / 2; ++i)
    {
        queue->data[i] = data[i];
    }
    free(data);
}

static void __heapify(PtyQueue* queue, int i)
{
    assert(queue != NULL);
    void* tmp = NULL;
    int l_idx, r_idx, lrg_idx;
    l_idx = LEFT(i);
    r_idx = RIGHT(i);

    if (l_idx < queue->size && queue->comparotor_fn(queue->data[l_idx], queue->data[i]) > 0)
    {
        lrg_idx = l_idx;
    }
    else
    {
        lrg_idx = i;
    }

    if (r_idx < queue->size && queue->comparotor_fn(queue->data[r_idx], queue->data[lrg_idx]) > 0)
    {
        lrg_idx = r_idx;
    }

    if (lrg_idx != i)
    {
        tmp = queue->data[lrg_idx];
        queue->data[lrg_idx] = queue->data[i];
        queue->data[i] = tmp;
        __heapify(queue, lrg_idx);
    }
}

void __priority_queue_free(PtyQueue* self)
{
    free(self->data);
    free(self);
}

void __priority_queue_enqueue(PtyQueue* self, const void* element)
{
    assert(self != NULL);

    int i;
    void* tmp = NULL;
    if (self->size >= self->capacity)
    {
        __double_size(self);
    }
    // Add element last
    self->data[self->size] = (void*) element;
    i = self->size;
    self->size++;
    /* Swap the new element until he is at the right place */
    while (i > 0 && self->comparotor_fn(self->data[i], self->data[PARENT(i)]) > 0)
    {
        tmp = self->data[i];
        self->data[i] = self->data[PARENT(i)];
        self->data[PARENT(i)] = tmp;
        i = PARENT(i);
    }
}

void* __priority_queue_dequeue(PtyQueue* self)
{
    assert(self != NULL);
    void* res = NULL;
    if (self->size == 0)
    {
        return res;
    }

    res = self->data[0];
    self->data[0] = self->data[self->size - 1];
    self->size--;
    __heapify(self, 0);
    return res;
}

// ----------------------------------------------------------------------------
// Public functions
// ----------------------------------------------------------------------------

PtyQueue* priority_queue_create(int capacity,
                                size_t elt_ptr_size,
                                int (* cmp)(const void*, const void*))
{
    PtyQueue* res = malloc(1 * sizeof(PtyQueue));
    res->capacity = capacity;
    res->size = 0;
    res->data = malloc((capacity * elt_ptr_size));

    res->elt_ptr_size = elt_ptr_size;
    res->comparotor_fn = cmp;
    res->dequeue = __priority_queue_dequeue;
    res->enqueue = __priority_queue_enqueue;
    res->free = __priority_queue_free;

    return res;
}


TimestampNode* priority_queue_timestamp_node_create(int value, int timestamp)
{
    TimestampNode* node = malloc(1 * sizeof(TimestampNode));
    node->value = value;
    node->timestamp = timestamp;
    return node;
}

int priority_queue_timestamp_compare(const void* a, const void* b)
{
    TimestampNode* pA = a;
    TimestampNode* pB = b;
    return pA->timestamp - pB->timestamp;
}
