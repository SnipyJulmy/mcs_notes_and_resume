#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>

#define RND_MIN_VALUE 0
#define RND_MAX_VALUE 100

#define NB_ROWS 5
#define NB_COLS 2

#define NB_THREADS NB_ROWS

static time_t t;

typedef struct
{
    double** matrix;
    int rowIdx;
    int rowLength;
    double returnValue;
} SumRowArgs;

void initRand()
{
    // initialize rand
    srand((unsigned) time(&t));
}

static double nextDouble()
{
    //double in range -1 to 1
    double unit = (double) rand() / RAND_MAX * 2.0 - 1.0; // NOLINT
    // generate random int between RND_MIN_VALUE and RND_MAX_VALUE
    int value = (rand() % (RND_MAX_VALUE - RND_MIN_VALUE)) - RND_MIN_VALUE; // NOLINT
    return ((double) value) + unit;
}

static void rndMatrix(double** matrix, int nbRow, int nbCol)
{
    for (int i = 0; i < nbRow; i++)
    {
        for (int j = 0; j < nbCol; j++)
        {
            matrix[i][j] = nextDouble();
        }
    }
}

static void* sumRow(void* argsV)
{
    SumRowArgs* args = argsV;
    double res = 0.0;
    for (int i = 0; i < args->rowLength; i++)
    {
        res += args->matrix[args->rowIdx][i];
    }
    args->returnValue = res;
    pthread_exit(NULL);
}

int main(void)
{
    initRand();
    double** matrix = malloc(NB_ROWS * sizeof(double*));
    if (matrix == NULL) return EXIT_FAILURE;
    for (int i = 0; i < NB_ROWS; i++)
    {
        matrix[i] = malloc(NB_COLS * sizeof(double*));
        if (matrix[i] == NULL)
        {
            printf("Can't allocate memory for matrix\n");
            return EXIT_FAILURE;
        }
    }

    rndMatrix(matrix, NB_ROWS, NB_COLS);

    for (int k = 0; k < NB_ROWS; k++)
    {
        for (int i = 0; i < NB_COLS; i++)
        {
            printf("%4.2f ", matrix[k][i]);
        }
        printf("\n");
    }

    // Create the threads
    double* sums = malloc(NB_THREADS * sizeof(double));
    pthread_t* threads = malloc(NB_THREADS * sizeof(pthread_t));
    SumRowArgs** args = malloc(NB_THREADS * sizeof(SumRowArgs*));

    for (int i = 0; i < NB_THREADS; i++)
    {
        args[i] = malloc(sizeof(SumRowArgs));
        if (args[i] == NULL)
        {
            printf("Can't allocate memory for arguments\n");
            return EXIT_FAILURE;
        }
    }

    for (int i = 0; i < NB_THREADS; i++)
    {
        args[i]->matrix = matrix;
        args[i]->rowLength = NB_COLS;
        args[i]->rowIdx = i;

        printf("Create thread %d\n", i);
        if (pthread_create(&(threads[i]), NULL, sumRow, args[i]) == -1)
        {
            printf("Error creating thread %d\n", i);
        }
    }

    // wait forall threads to terminate
    for (int j = 0; j < NB_THREADS; j++)
    {
        pthread_join(threads[j], (void**) NULL);
        printf("thread %d has finish\n", j);
    }

    double sum = 0.0;
    for (int i = 0; i < NB_THREADS; i++)
    {
        sum += args[i]->returnValue;
    }

    printf("Total sum : %.2f\n", sum);

    // free everything
    for (int i = 0; i < NB_THREADS; i++)
        free(args[i]);
    free(args);
    free(threads);

    for (int i = 0; i < NB_ROWS; i++)
        free(matrix[i]);
    free(matrix);
    free(sums);

    return EXIT_SUCCESS;
}