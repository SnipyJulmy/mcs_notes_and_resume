all : ungetch_test

clean_all:
	rm ungetch_test  *.o


# ungetch module
#---------------
ungetch_test :           ungetch_test.o  ungetch.o
	gcc -o ungetch_test  ungetch_test.o  ungetch.o

ungetch_test.o : ungetch_test.c  ungetch.h
	gcc     -c ungetch_test.c

ungetch.o : ungetch.c  ungetch.h
	gcc   -c ungetch.c
