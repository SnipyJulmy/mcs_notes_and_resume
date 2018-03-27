#include <stdlib.h>
#include <stdbool.h>
#include <pthread.h>
#include <stdio.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wmissing-noreturn"

typedef enum
{
    DOUGH, TOMATO, TOPPING
} ROLES;

typedef struct
{
    ROLES role;
} AssistantArgs;

typedef struct
{
    pthread_t* tpid;
} ChefArgs;

static ROLES table[2];

// barrier
pthread_barrier_t barrier;
pthread_barrier_t barrier2;

#define NB_ROLES 3
#define nextInt() (rand() % NB_ROLES)

static void* assistant(void* arguments)
{
    AssistantArgs* args = arguments;
    u_int32_t self = args->role;
    printf("Start thread %u\n", self);
    while (true)
    {
        pthread_barrier_wait(&barrier);
        if (table[0] != -1 && table[0] != args->role && table[1] != -1 && table[1] != args->role)
        {
            printf("thread %u is making the pizza\n", self);
            table[0] = -1;
            table[1] = -1;
        }
        pthread_barrier_wait(&barrier2);
    }
}

static void* chef(void* args)
{
    ChefArgs* chefArgs = args;
    int idx;
    while (true)
    {
        // put item on the table
        idx = nextInt();
        table[0] = (ROLES) ((idx + 1) % NB_ROLES);
        printf("put %d on the table\n", table[0]);
        table[1] = (ROLES) ((idx + 2) % NB_ROLES);
        printf("put %d on the table\n", table[1]);

        //there are better way obviusly...
        pthread_barrier_wait(&barrier);
        pthread_barrier_wait(&barrier2);
    }
}

int main(void)
{
    // barrier
    if ((pthread_barrier_init(&barrier, NULL, 4)) != 0)
    {
        printf("Can't init barrier 1\n");
        return EXIT_FAILURE;
    }

    if ((pthread_barrier_init(&barrier2, NULL, 4)) != 0)
    {
        printf("Can't init barrier 2\n");
        return EXIT_FAILURE;
    }

    // threads
    pthread_t* assistantThread = malloc(NB_ROLES * sizeof(pthread_t));
    pthread_t* chefThread = malloc(1 * sizeof(pthread_t));
    AssistantArgs* args = malloc(NB_ROLES * sizeof(AssistantArgs));
    // create assistants
    for (int i = 0; i < 3; i++)
    {
        // args
        args[i].role = (ROLES) i;

        if (pthread_create(&(assistantThread[i]), NULL, assistant, &(args[i])) == -1)
        {
            printf("Error creating thread %d\n", i);
        }
    }

    // create chef
    ChefArgs* chefArgs = malloc(1 * sizeof(ChefArgs));

    // args
    chefArgs->tpid = assistantThread;

    // create thread
    if (pthread_create(chefThread, NULL, chef, chefArgs) == -1)
    {
        printf("Error creating chef thread\n");
    }

    for (int i = 0; i < NB_ROLES; i++)
    {
        pthread_join(assistantThread[i], NULL);
    }
    return EXIT_SUCCESS;
}

#pragma clang diagnostic pop