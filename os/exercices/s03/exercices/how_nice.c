#include <stdio.h>
#include <unistd.h>
#include <sys/resource.h>

void main(void)
{
    int pid;

    pid = fork();
    // from here there are two process

    printf("PID : %d PRIO : %d\n", pid, getpriority(PRIO_PROCESS, 0));
}