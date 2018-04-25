//
// Created by snipy on 20.04.18.
//

#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <stdbool.h>

int main(void)
{
    while(true)
    {
        fprintf(stdout,"Hey !\n");
        sleep(1);
        fprintf(stderr,"Ho !\n");
        sleep(1);
    }
    return EXIT_SUCCESS;
}
