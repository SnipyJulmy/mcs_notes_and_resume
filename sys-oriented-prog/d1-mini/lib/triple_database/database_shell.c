//
// Created by snipy on 17.04.18.
//

#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

#include "database_shell.h"
#include "../utils/debug.h"
#include "triple_database_interface.h"

#define SHELL_BUFFER_SIZE 1024
#define SHELL_TOKEN_DELIMITER " \t\n\r\a"
#define PROMPT "$> "

#define STATUS_FAILURE 2
#define STATUS_OK 1
#define STATUS_EXIT 0

// Macro
#ifndef DATABASE_SHELL_MACROS
#define DATABASE_SHELL_MACROS

#define CHECK_ARGC(N) \
    do {if (command->argc != (N))\
    {\
        printf("invalid number of argument");\
        return STATUS_FAILURE;\
    }} while(0);


#endif


/* TODO
 * - read from text file the triplet
 * - more index !
 */

static char* database_shell_read_line();
static Command* database_shell_tokenize_line(char* line);
static int database_shell_execute(Command* command);

static Command* database_shell_command_create(char** args, int argc);
static void database_shell_command_destroy(Command* self);

void database_shell_loop()
{
    log_info("database_init");
    database_init();
    char* line;
    Command* command;
    int status;
    do
    {
        log_info("do while start");
        printf(PROMPT);
        line = database_shell_read_line();
        command = database_shell_tokenize_line(line);
        status = database_shell_execute(command);
        free(line);
        command->destroy(command);
    } while (status != STATUS_EXIT);
    database_free();
}

static Command* database_shell_command_create(char** args, int argc)
{
    Command* command = malloc(1 * sizeof(Command));
    command->args = args;
    command->argc = argc;
    command->destroy = database_shell_command_destroy;
    check_mem_and_exit(command);
    return command;
}

static int database_shell_execute(Command* command)
{
    if (command->argc == 0)
        return STATUS_OK;

    if (strcmp(command->args[0], "insert") == 0)
    {
        CHECK_ARGC(4);

        int status = insert(command->args[1], command->args[2], command->args[3]);
        if (status == 0)
            return STATUS_OK;
        else
        {
            printf("error on insert\n");
            return STATUS_FAILURE;
        }
    }
    else if (strcmp(command->args[0], "match") == 0)
    {
        CHECK_ARGC(5);

        char* s = calloc(TRIPLET_FIELD_CAPACITY, sizeof(char));
        char* o = calloc(TRIPLET_FIELD_CAPACITY, sizeof(char));
        char* p = calloc(TRIPLET_FIELD_CAPACITY, sizeof(char));

        // not used field s, check and replace with the empty string
        if (strcmp(command->args[1], "_") == 0)
            s[0] = '\0';
        else
            strcpy(s, command->args[1]);

        // not used field o, check and replace with the empty string
        if (strcmp(command->args[2], "_") == 0)
            p[0] = '\0';
        else
            strcpy(p, command->args[2]);

        // not used field p, check and replace with the empty string
        if (strcmp(command->args[3], "_") == 0)
            o[0] = '\0';
        else
            strcpy(o, command->args[3]);

        int status = match(s, p, o, strtol(command->args[4], NULL, 10));

        if (status == 0)
        {
            printf("\ts : %s\n\tp : %s\n\to : %s\n", s, p, o);
        }
        else
        {
            printf("No matching found\n");
        }
        free(s);
        free(p);
        free(o);
        return STATUS_OK;
    }
    else if (strcmp(command->args[0], "delete") == 0)
    {
        CHECK_ARGC(5);

        if (strcmp(command->args[1], "_") == 0)
            command->args[1][0] = '\0';
        if (strcmp(command->args[2], "_") == 0)
            command->args[2][0] = '\0';
        if (strcmp(command->args[3], "_") == 0)
            command->args[3][0] = '\0';
        int status = _delete(command->args[1],
                             command->args[2],
                             command->args[3],
                             strtol(command->args[4], NULL, 10));
        if (status == 0)
            return STATUS_OK;
        else
        {
            printf("error on delete\n");
            return STATUS_FAILURE;
        }
    }
    else if (strcmp(command->args[0], "ls") == 0)
    {
        CHECK_ARGC(1);
        Dequeue* dequeue = ls();
        while (dequeue != NULL && !dequeue->is_empty(dequeue))
        {
            char* str_triplet = dequeue->remove_first(dequeue);
            printf("%s\n", str_triplet);
            free(str_triplet);
        }
        if (dequeue != NULL)
            dequeue->destroy(dequeue);
    }
    else if (strcmp(command->args[0], "use_index") == 0)
    {
        CHECK_ARGC(2);
        if (strcmp(command->args[1], "static") == 0)
        {
            if (use_index(STATIC))
                return STATUS_OK;
            log_err("can't change index to %s", command->args[1]);
            return STATUS_FAILURE;
        }
        else if (strcmp(command->args[1], "dynamic") == 0)
        {
            if (use_index(DYNAMIC))
                return STATUS_OK;
            log_err("can't change index to %s", command->args[1]);
            return STATUS_FAILURE;
        }
        else
        {
            log_err("unknown index type : %s", command->args[1]);
            return STATUS_FAILURE;
        }
    }
    else if (strcmp(command->args[0], "make_index") == 0)
    {
        CHECK_ARGC(1);
        if (make_index())
            return STATUS_OK;
        log_err("can't make the index");
        return STATUS_FAILURE;
    }
    else if (strcmp(command->args[0], "help") == 0)
    {
        CHECK_ARGC(1);
        // TODO
        return STATUS_OK;
    }
    else if (strcmp(command->args[0], "exit") == 0)
    {
        CHECK_ARGC(1);
        debug("exit the database shell");
        return STATUS_EXIT;
    }
    else
    {
        log_info("Unknow command : %s\n", command->args[0]);
    }
    return STATUS_OK;
}

static char* database_shell_read_line()
{
    log_info("shell_read_line : start");
    int buffer_size = SHELL_BUFFER_SIZE;
    int position = 0;
    int c;

    char* buffer = malloc(buffer_size * sizeof(char));
    check_mem_and_exit(buffer);

    while (true)
    {
        log_info("shell_read_line : getchar");
        c = getchar();
        log_info("shell_read_line : getchar = %d",c);
        if (c == EOF || c == '\n')
        {
            buffer[position] = '\0';
            return buffer;
        }
        else
        {
            buffer[position] = (char) c;
        }
        position++;

        // double buffer size if we exceed
        if (position >= buffer_size)
        {
            buffer_size = buffer_size + SHELL_BUFFER_SIZE;
            buffer = realloc(buffer, buffer_size * sizeof(char));
            check_mem_and_exit(buffer);
        }
    }
}

static Command* database_shell_tokenize_line(char* line)
{
    int buffer_size = SHELL_BUFFER_SIZE;
    int position = 0;
    char** tokens = malloc(buffer_size * sizeof(char*));
    char* token;

    check_mem_and_exit(tokens);
    token = strtok(line, SHELL_TOKEN_DELIMITER);
    while (token != NULL)
    {
        tokens[position] = token;
        position++;

        if (position >= buffer_size)
        {
            tokens = realloc(tokens, buffer_size * sizeof(char*));
            check_mem_and_exit(tokens);
        }

        token = strtok(NULL, SHELL_TOKEN_DELIMITER);
    }
    tokens[position] = NULL;
    return database_shell_command_create(tokens, position);
}


static void database_shell_command_destroy(Command* self)
{
    free(self->args);
    free(self);
}