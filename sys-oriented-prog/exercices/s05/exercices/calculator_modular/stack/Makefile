all : stack_test

clean_all:
	rm stack_test  *.o


# stack module
#-------------
stack_test :           stack_test.o  stack.o
	gcc -o stack_test  stack_test.o  stack.o

stack_test.o : stack_test.c  stack.h
	gcc  -c stack_test.c

stack.o :  stack.c  stack.h
	gcc -c stack.c
