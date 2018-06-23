//
// Created by snipy on 17.04.18.
//

#include "triple_database_interface.h"
#include "../utils/debug.h"

#define DATABASE_INIT_CAPACITY 1

Database* database;


void database_init()
{
    database = database_create(DATABASE_INIT_CAPACITY);
    check_mem_and_exit(database);
}

void database_free()
{
    database->destroy(database);
}

int insert(char* s, char* p, char* o)
{
    return database->insert(database, s, p, o);
}

int match(char* s, char* p, char* o, long result)
{
    return database->match(database, s, p, o, result);
}

int _delete(char* s, char* p, char* o, long result)
{
    return database->_delete(database, s, p, o, result);
}

bool use_index(IndexType type)
{
    log_info("change index type to : %d", type);
    return database->use_index(database, type);
}

bool make_index(void)
{
    return database->make_index(database);
}

Dequeue* ls(void)
{
    return database->ls(database);
}
