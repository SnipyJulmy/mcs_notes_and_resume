//
// Created by snipy on 17.04.18.
//

#ifndef P01_DATABASE_SHELL_H
#define P01_DATABASE_SHELL_H

typedef struct Command Command;
struct Command
{
    // attributes
    char** args;
    int argc;

    // methods
    void (* destroy)(Command* self);
};

void database_shell_loop();

#endif //P01_DATABASE_SHELL_H
