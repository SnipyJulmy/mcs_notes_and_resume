//
// Created by snipy on 17.04.18.
//

#ifndef P01_TRIPLE_DATABASE_INTERFACE_H
#define P01_TRIPLE_DATABASE_INTERFACE_H

#include "../data_structure/dequeue/dequeue.h"
#include "triple_database.h"

void database_init();
void database_free();
int insert(char* s, char* p, char* o);
int match(char* s, char* p, char* o, long result);
int _delete(char* s, char* p, char* o, long result);
Dequeue* ls(void);
bool make_index(void);
bool use_index(IndexType type);

#endif //P01_TRIPLE_DATABASE_INTERFACE_H
