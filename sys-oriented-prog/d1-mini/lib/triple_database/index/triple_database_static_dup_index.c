//
// Created by snipy on 25.04.18.
//

#include "triple_database_static_dup_index.h"

#include <string.h>

#include "../../utils/debug.h"

// methods
void index_destroy(StaticIndex* self);
void index_display(StaticIndex* self);
Triplet* index_search(StaticIndex* self, char* target, long result);

// other
static void quick_sort(StaticIndex* self, Triplet** data, int m, int n);

StaticIndex* triple_database_make_index(Triplet** triplets, const int nb_triplets,
                                        char* (* used_field)(Triplet*))
{
    StaticIndex* index = malloc(1 * sizeof(StaticIndex));
    check_mem_and_return(index, NULL);

    index->triplets = malloc(nb_triplets * sizeof(Triplet*));
    memcpy(index->triplets, triplets, nb_triplets * sizeof(Triplet*));

    index->destroy = index_destroy;
    index->used_field = used_field;
    index->display = index_display;
    index->nb_triplets = nb_triplets;
    index->search = index_search;

    // build the index...
    // the triplet are ordered in alphabetical order... using strcmp
    quick_sort(index, index->triplets, 0, nb_triplets - 1);

    return index;
}

void swap(Triplet** x, Triplet** y)
{
    Triplet* temp;
    temp = *x;
    *x = *y;
    *y = temp;
}

int pivot(int i, int j)
{
    return ((i + j) / 2);
}

static void quick_sort(StaticIndex* self, Triplet** data, int m, int n)
{
    if (m < n)
    {
        int k = pivot(m, n);
        Triplet* key = data[k];
        swap(&data[m], &data[k]);

        int i, j;

        i = m + 1;
        j = n;
        while (i <= j)
        {
            while ((i <= n) && (strcmp(self->used_field(data[i]), self->used_field(key)) <= 0))
                i++;
            while ((j >= m) && (strcmp(self->used_field(data[j]), self->used_field(key)) > 0))
                j--;
            if (i < j)
                swap(&data[i], &data[j]);
        }

        swap(&data[m], &data[j]);
        quick_sort(self, data, m, j - 1);
        quick_sort(self, data, j + 1, n);
    }
}

void index_destroy(StaticIndex* self)
{
    free(self->triplets);
    free(self);
}

void index_display(StaticIndex* self)
{
    for (int i = 0; i < self->nb_triplets; i++)
    {
        printf("<%s,%s,%s>\n",
               self->triplets[i]->s,
               self->triplets[i]->p,
               self->triplets[i]->o
        );
    }
}

Triplet* index_search_rec(StaticIndex* self, char* target, long result, int start, int end)
{
    if (start >= end) return NULL;
    if (end - start == 1) // two element to check...
    {
        Triplet* triplet = self->triplets[start];
        int cmpStart = strcmp(target, self->used_field(triplet));
        int cmpEnd = strcmp(target, self->used_field(self->triplets[end]));

        if (cmpStart == 0)
            if (result == 0)
                return triplet;
            else if (result == 1)
                return cmpEnd == 0 ? self->triplets[end] : NULL;
            else
                return NULL;
        else if (cmpEnd == 0)
            if (result == 0)
                return self->triplets[end];
            else return NULL;
        else return NULL;
    }

    int middle = (end + start) / 2;
    Triplet* triplet = self->triplets[middle];

    int cmp = strcmp(target, self->used_field(triplet));
    if (cmp == 0) // found the match !
    {
        int index = middle + 1;
        // search on the right
        while (true)
        {
            if (result == 0)
                return triplet;
            triplet = self->triplets[++index];
            if (!strcmp(target, self->used_field(triplet)) == 0)
                break;
            else
                result--;
        }

        index = middle - 1;
        // search on the left
        while (true)
        {
            if (result == 0)
                return triplet;
            triplet = self->triplets[--index];
            if (!strcmp(target, self->used_field(triplet)) == 0)
                break;
            else
                result--;
        }

        // no match found
        return NULL;
    }
    else if (cmp > 0)
    {
        return index_search_rec(self, target, result, middle, end);
    }
    else// cmp < 0
    {
        return index_search_rec(self, target, result, start, middle);
    }

}

Triplet* index_search(StaticIndex* self, char* target, long result)
{
    return index_search_rec(self, target, result, 0, self->nb_triplets);
}
