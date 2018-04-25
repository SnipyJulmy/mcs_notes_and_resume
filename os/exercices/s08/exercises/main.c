#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "priority_queue/priority_queue.h"


/**************************************
 * The parameters of memory and disk pages
 *
 * PageFrameList: The dynamically-allocated array representing memory pages
 * nb_frame : the number of page frames in memory
 * elementCout: Point to the next page to be replaced
 *
 * ReferenceString: The sequence of the demanding pages
 * ReferenceLength: The length of the randomized reference string
 * ReferenceSZ: the page number range in the reference string
 *
 */

#define ReferenceLength 20

typedef struct
{
    int* PageFrameList;
    int elementCount;
} PageFrame;

int ReferenceSZ, nb_frame;

PageFrame memory;

int* ReferenceString;

/* Test driver sub functions */

void generateReferenceString();

void initializePageFrame();

void printReferenceString();

void printPageFrame();


/* Algorithm Functions */

int FIFO();

int LRU();

int NFU();


/*******************************
 *
 * The main function is the test driver for FIFO & LRU algorithms
 *
 * 1. Initialize the system parameters
 * 2. Initialize the memory pages
 * 3. Generate the randomized reference string
 * 4. Apply the FIFO algorithm, calculate the number of page faults
 * 5. Apply the LRU algorithm, calculate the number of page faults
 */

int main(int argc, char* argv[])
{
    if (argc != 3)
    {
        printf("Command format: Test <reference string size> <number of page frames>");
        return EXIT_FAILURE;
    }

    ReferenceSZ = atoi(argv[1]);
    nb_frame = atoi(argv[2]);

    generateReferenceString();

    initializePageFrame();
    printf("page fault of FIFO: %d\n", FIFO());
    free(memory.PageFrameList);

    printf("\n");
    printf("\n");

    printReferenceString();

    initializePageFrame();
    printf("page fault of LRU: %d\n", LRU());

    printf("\n");
    printf("\n");

    printReferenceString();

    initializePageFrame();
    printf("page fault of NFU: %d\n", NFU());


    free(memory.PageFrameList);
    free(ReferenceString);
    return EXIT_SUCCESS;
}


/**********************************
 **********************************
 *
 * The test driver functions implmentation details
 *
 **********************************
 */

void generateReferenceString()
{
    int i;
    srand((unsigned int) time(0));
    ReferenceString = (int*) malloc(sizeof(int) * ReferenceLength);
    printf("The randomized Reference String: ");
    for (i = 0; i < ReferenceLength; i++)
    {
        ReferenceString[i] = rand() % ReferenceSZ;
        printf("%d ", ReferenceString[i]);
    }
    printf("\n");
}


void initializePageFrame()
{
    int i;
    memory.PageFrameList = (int*) malloc(nb_frame * sizeof(int));
    memory.elementCount = 0;
    for (i = 0; i < nb_frame; i++)
    {
        memory.PageFrameList[i] = -1;
    }

}

void printPageFrame()
{
    int i;
    for (i = 0; i < nb_frame; i++)
    {
        printf("%2d ", memory.PageFrameList[i]);
    }
    printf("\n");
}

void printReferenceString()
{
    int i;
    printf("The Same Reference String: ");
    for (i = 0; i < ReferenceLength; i++)
    {
        printf("%d ", ReferenceString[i]);
    }
    printf("\n");

}

int FIFO()
{
    int page_fault_count = 0;
    int crt_page_idx = 0;

    for (int i = 0; i < ReferenceLength; i++)
    {
        int requested_page = ReferenceString[i];
        // search if the requested page is present or not
        for (int j = 0; j < nb_frame; j++)
        {
            if (memory.PageFrameList[j] == requested_page) // page is present
            {
                // don't do anything, the page is already present
                goto requested_page_loop; // continue upper loop, not current one
            }
        }
        // page is not present --> page fault
        page_fault_count++;
        memory.PageFrameList[crt_page_idx] = requested_page;
        crt_page_idx = (crt_page_idx + 1) % nb_frame;

        requested_page_loop :;
    }

    return page_fault_count;
}

int int_cmp(const void* a, const void* b)
{
    int vA = *(int*) a;
    int vB = *(int*) b;
    return vA - vB;
}

int LRU()
{
    int page_fault_count = 0;

    // we use a priority queue for this implementation
    PtyQueue* queue = priority_queue_create(nb_frame,
                                            sizeof(TimestampNode),
                                            priority_queue_timestamp_compare);

    for (int i = 0; i < ReferenceLength; i++)
    {
        int requested_page = ReferenceString[i];
        // lookup for the page
        for (int j = 0; j < queue->capacity; j++)
        {
            TimestampNode* node = queue->data[j];
            if (node == NULL) continue;
            if (node->value == requested_page)
            {
                // don't do anything, the page is already present
                goto requested_page_loop; // continue upper loop, not current one
            }
        }

        page_fault_count++;

        if (queue->size >= nb_frame) // queue is full
        {
            free(queue->dequeue(queue));
        }
        queue->enqueue(queue, priority_queue_timestamp_node_create(requested_page, i));

        requested_page_loop :;
    }
    queue->free(queue);
    return page_fault_count;
}

typedef struct PageMemory PageMemory;
struct PageMemory
{
    int nb_access;
    int page_number;
};

int NFU()
{
    int page_fault_count = 0;

    PageMemory* NFU_memory = malloc(nb_frame * sizeof(PageMemory));
    for (int i = 0; i < nb_frame; i++)
    {
        NFU_memory[i].nb_access = 0;
        NFU_memory[i].page_number = -1;
    }

    for (int i = 0; i < ReferenceLength; i++)
    {
        int requested_page = ReferenceString[i];
        // lookup for the page
        for (int j = 0; j < nb_frame; j++)
        {
            PageMemory page = NFU_memory[j];
            if (page.page_number == requested_page)
            {
                page.nb_access++;
                goto requested_page_loop;
            }
        }

        // page fault
        page_fault_count++;
        
        printf("add page %d\n",requested_page);

        // search for an empty place
        for (int j = 0; j < nb_frame; j++)
        {
            if (NFU_memory[j].page_number == -1)
            {
                NFU_memory[j].page_number = requested_page;
                NFU_memory[j].nb_access = 1;
                goto requested_page_loop; // found one, treat next value !
            }
        }

        // find the least used page
        int least_used_page = 0;
        for (int j = 1; j < nb_frame; j++)
        {
            PageMemory page = NFU_memory[j];
            if (NFU_memory[least_used_page].nb_access > page.nb_access)
            {
                least_used_page = j;
            }
        }
        printf("evict page %d\n", NFU_memory[least_used_page].page_number);
        NFU_memory[least_used_page].nb_access = 1;
        NFU_memory[least_used_page].page_number = requested_page;

        requested_page_loop :;
    }

    free(NFU_memory);
    return page_fault_count;
}
