//
// Created by snipy on 17.04.18.
//

#include <stdlib.h>
#include <stdbool.h>

#include "triple_database.h"
#include "../utils/debug.h"

#define DEFAULT_INDEX STATIC;

void triplet_destroy(Triplet* self);
bool triplet_equals(Triplet* a, Triplet* b);
bool triplet_match(Triplet* triplet, char* s, char* p, char* o);

void database_destroy(Database* self);
int database_insert(Database* self, char* s, char* p, char* o);
int database_match(Database* self, char* s, char* p, char* o, long result);
int database_delete(Database* self, char* s, char* p, char* o, long result);
int database_match_with_index(Database* self, char* s, char* p, char* o, long result);
Dequeue* database_ls(Database* self);

bool database_use_index(Database* self, IndexType indexType);
bool database_make_index(Database* self); // only when self->index_type == STATIC

void database_double_capacity(Database* self);
int database_search_first_available_index(Database* self);

char buffer[TRIPLET_FIELD_CAPACITY * 3 + 40];

Database* database_create(int capacity)
{
    Database* database = malloc(1 * sizeof(Database));
    check_mem_and_return(database, NULL);
    database->size = 0;
    database->first_available_index = 0;
    database->capacity = capacity;
    database->data = malloc(capacity * sizeof(Triplet*));
    check_mem(database->data, {
        free(database);
        return NULL;
    });

    database->destroy = database_destroy;
    database->insert = database_insert;
    database->_delete = database_delete;
    database->match = database_match;
    database->match_with_index = database_match_with_index;
    database->ls = database_ls;

    // index setup
    database->index_type = DEFAULT_INDEX;
    database->use_index = database_use_index;
    database->make_index = database_make_index;

    database->s_index = NULL;
    database->p_index = NULL;
    database->o_index = NULL;
    database->dynamic_index = NULL;

    database->search_first_available_index = database_search_first_available_index;
    database->double_capacity = database_double_capacity;
    return database;
}

int database_insert(Database* self, char* s, char* p, char* o)
{
    if (self->size == self->capacity)
        self->double_capacity(self);
    Triplet* triplet = triplet_create(s, p, o);
    check_mem_and_return(triplet, 1);
    self->data[self->first_available_index] = triplet;
    self->size++;
    self->first_available_index = self->search_first_available_index(self);
    return 0;
}

int database_match(Database* self, char* s, char* p, char* o, long result)
{
    Triplet* crt;
    for (int i = 0; i < self->capacity; i++)
    {
        crt = self->data[i];
        if (crt == NULL)continue;
        if (crt->is_used)
        {
            if (triplet_match(crt, s, p, o))
            {
                if (result == 0)
                {
                    if (strcmp(s, "") == 0) strcpy(s, crt->s);
                    if (strcmp(p, "") == 0) strcpy(p, crt->p);
                    if (strcmp(o, "") == 0) strcpy(o, crt->o);
                    return 0;
                }
                else
                {
                    result--;
                }
            }
        }
    }
    return 1;
}

int database_delete(Database* self, char* s, char* p, char* o, long result)
{
    Triplet* crt;
    for (int i = 0; i < self->capacity; i++)
    {
        crt = self->data[i];
        if (crt == NULL)continue;
        if (crt->is_used)
        {
            if (triplet_match(crt, s, p, o))
            {
                if (result == 0)
                {
                    crt->is_used = false;
                    self->first_available_index = self->search_first_available_index(self);
                    return 0;
                }
                else
                {
                    result--;
                }
            }
        }
    }
    return 1;
}

Triplet* triplet_create(char* s, char* p, char* o)
{
    debug("create a triplet with\n\ts : %s\n\tp : %s\n\to : %s", s, p, o);
    Triplet* triplet = malloc(1 * sizeof(Triplet));
    check_mem_and_return(triplet, NULL);

    // S
    if (strlen(s) <= TRIPLET_FIELD_CAPACITY)
    {
        triplet->s = malloc((strlen(o) + 1) * sizeof(char));
        check_mem(triplet->s, {
            free(triplet);
            return NULL;
        });
        strcpy(triplet->s, s);
    }
    else
    {
        free(triplet);
        return NULL;
    }

    // P
    if (strlen(p) <= TRIPLET_FIELD_CAPACITY)
    {
        triplet->p = malloc((strlen(o) + 1) * sizeof(char));
        check_mem(triplet->p, {
            free(triplet->s);
            free(triplet);
            return NULL;
        });
        strcpy(triplet->p, p);
    }
    else
    {
        free(triplet->s);
        free(triplet);
        return NULL;
    }

    // O
    if (strlen(o) <= TRIPLET_FIELD_CAPACITY)
    {
        triplet->o = malloc((strlen(o) + 1) * sizeof(char));
        check_mem(triplet->o, {
            free(triplet->s);
            free(triplet->p);
            free(triplet);
            return NULL;
        });
        strcpy(triplet->o, o);
    }
    else
    {
        free(triplet->s);
        free(triplet->p);
        free(triplet);
        return NULL;
    }
    triplet->is_used = true;
    triplet->destroy = triplet_destroy;
    debug("create triplet <%s,%s,%s>", triplet->s, triplet->p, triplet->o);
    return triplet;
}

void triplet_destroy(Triplet* self)
{
    if (self == NULL)
        return;
    free(self->s);
    free(self->p);
    free(self->o);
    free(self);
}

void database_destroy(Database* self)
{
    for (int i = 0; i < self->capacity; i++)
    {
        if (self->data[i] != NULL)
            self->data[i]->destroy(self->data[i]);
    }
    free(self->data);
    free(self);
}

void database_double_capacity(Database* self)
{
    self->capacity = self->capacity * 2;
    self->data = realloc(self->data, self->capacity * sizeof(Triplet*));
    check_mem_and_exit(self->data);
}

inline bool triplet_equals(Triplet* a, Triplet* b)
{
    if (strcmp(a->s, b->s) != 0) return false;
    if (strcmp(a->p, b->p) != 0) return false;
    if (strcmp(a->o, b->o) != 0) return false;
    return true;
}

inline bool triplet_match(Triplet* triplet, char* s, char* p, char* o)
{
    if (strcmp(s, "") != 0) if (strcmp(triplet->s, s) != 0) return false;
    if (strcmp(p, "") != 0) if (strcmp(triplet->p, p) != 0) return false;
    if (strcmp(o, "") != 0) if (strcmp(triplet->o, o) != 0) return false;
    return true;
}

int database_search_first_available_index(Database* self)
{
    int idx = 0;
    for (idx = 0; idx < self->capacity; idx++)
    {
        if (self->data[idx] == NULL)
            return idx;
        if (!self->data[idx]->is_used)
            return idx;
    }
    return idx;
}

Dequeue* database_ls(Database* self)
{
    Dequeue* dequeue = data_structure_dequeue_create(
            sizeof(char*),
            (int (*)(void*, void*)) strcmp, // seriously ???
            free
    );

    check_mem_and_return(dequeue, NULL);

    Triplet* current_item;
    int count = 0;
    for (int i = 0; i < self->capacity; i++)
    {
        current_item = self->data[i];
        if (current_item != NULL && current_item->is_used)
        {
            sprintf(buffer, "<%s,%s,%s>", current_item->s, current_item->p, current_item->o);
            char* res = malloc((strlen(buffer) + 1) * sizeof(char));
            strcpy(res, buffer);
            dequeue->add(dequeue, res);
            debug("add %s to the dequeue", res);
            if (++count == self->size) goto end;
        }
    }
    end:
    return dequeue;
}

bool database_use_index(Database* self, IndexType indexType)
{
    self->index_type = indexType;
    return true;
}

bool database_make_index(Database* self)
{
    if (self->index_type != STATIC)
        return false;
    // free the old indexes
    if (self->s_index != NULL) self->s_index->destroy(self->s_index);
    if (self->p_index != NULL) self->p_index->destroy(self->p_index);
    if (self->o_index != NULL) self->o_index->destroy(self->o_index);

    // make the new one
    self->s_index = triple_database_make_index(self->data, self->size, s);
    check_mem(self->s_index, {
        return false;
    });
    self->p_index = triple_database_make_index(self->data, self->size, p);
    check_mem(self->p_index, {
        self->s_index->destroy(self->s_index);
        return false;
    });
    self->o_index = triple_database_make_index(self->data, self->size, o);
    check_mem(self->o_index, {
        self->s_index->destroy(self->s_index);
        self->p_index->destroy(self->p_index);
        return false;
    });

    return true;
}

int database_match_with_index(Database* self, char* s, char* p, char* o, long result)
{
    // Determine the index to use
    // currently only use index for the following requests :
    // s _ _
    // _ p _
    // _ _ o

    Triplet* triplet = NULL;

    if (strcmp(p, "") == 0 && strcmp(o, "") == 0) // s _ _
        triplet = self->s_index->search(self->s_index, s, result);
    else if (strcmp(s, "") == 0 && strcmp(o, "") == 0) // _ p _
        triplet = self->p_index->search(self->p_index, p, result);
    else if (strcmp(s, "") == 0 && strcmp(p, "") == 0) // _ _ o
        triplet = self->o_index->search(self->o_index, o, result);
    else
        return 1;

    if (triplet == NULL)
        return 1;

    if (strcmp(s, "") == 0) strcpy(s, triplet->s);
    if (strcmp(p, "") == 0) strcpy(p, triplet->p);
    if (strcmp(o, "") == 0) strcpy(o, triplet->o);
    return 0;
}
