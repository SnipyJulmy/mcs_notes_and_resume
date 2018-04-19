#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>

#define PAGE_SIZE 4096

int main(int argc, char* argv[])
{
    if (argc != 2) return EXIT_FAILURE;
    uint32_t virtual_adress = (uint32_t) strtoul(argv[1], NULL, 10);

    uint32_t page_number = virtual_adress / PAGE_SIZE;
    uint32_t offset = virtual_adress - page_number * PAGE_SIZE;

    printf("The address %u contains:\npage number = %d\noffset = %d\n",
           virtual_adress,
           page_number,
           offset
    );
    return EXIT_SUCCESS;
}