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
    double* vector;
    int rowIdx;
    int rowLength;
    double* returnValue;
} SumRowArgs;

static void initRand()
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

static void rndVector(double* vector, int nbCol)
{
    for (int i = 0; i < nbCol; i++)
    {
        vector[i] = nextDouble();
    }
}

static void* multiplyRow(void* argsV)
{
    SumRowArgs* args = argsV;
    for (int i = 0; i < args->rowLength; i++)
    {
        args->returnValue[i] = args->matrix[args->rowIdx][i] * args->vector[args->rowIdx];
    }
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

    double* vector = malloc(NB_ROWS * sizeof(double));
    if (vector == NULL) return EXIT_FAILURE;

    rndMatrix(matrix, NB_ROWS, NB_COLS);
    rndVector(vector, NB_ROWS);

    printf("Matrix : \n");
    for (int i = 0; i < NB_ROWS; i++)
    {
        for (int j = 0; j < NB_COLS; j++)
        {
            printf("%4.2f ", matrix[i][j]);
        }
        printf("\n");
    }

    printf("Vector \n");
    for (int i = 0; i < NB_ROWS; i++)
    {
        printf("%4.2f ", vector[i]);
    }
    printf("\n");

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
        args[i]->returnValue = malloc(NB_COLS * sizeof(double));
    }

    for (int i = 0; i < NB_THREADS; i++)
    {
        args[i]->matrix = matrix;
        args[i]->rowLength = NB_COLS;
        args[i]->rowIdx = i;
        args[i]->vector = vector;


        printf("Create thread %d\n", i);
        if (pthread_create(&(threads[i]), NULL, multiplyRow, args[i]) == -1)
        {
            printf("Error creating thread %d\n", i);
        }
    }

    // wait forall threads to terminate
    for (int j = 0; j < NB_THREADS; j++)
    {
        pthread_join(threads[j], (void**) NULL);
        printf("thread %d has finish : [%4.2f,%4.2f]\n", j,
               args[j]->returnValue[0],
               args[j]->returnValue[1]);
    }

    double sum[2] = {0.0, 0.0};
    for (int i = 0; i < NB_THREADS; i++)
    {
        sum[0] += args[i]->returnValue[0];
        sum[1] += args[i]->returnValue[1];
    }

    printf("Total sum : [ %4.2f %4.2f ]\n", sum[0], sum[1]);

    printf("Should be : [");
    for (int i = 0; i < NB_COLS; i++)
    {
        double res = 0.0;
        for (int j = 0; j < NB_ROWS; j++)
        {
            res += matrix[j][i] * vector[j];
        }
        printf(" %4.2f", res);
    }
    printf(" ]\n");

    // free everything
    for (int i = 0; i < NB_THREADS; i++)
    {
        free(args[i]->returnValue);
        free(args[i]);
    }
    free(args);
    free(threads);

    for (int i = 0; i < NB_ROWS; i++)
        free(matrix[i]);
    free(matrix);
    free(sums);

    return EXIT_SUCCESS;
}