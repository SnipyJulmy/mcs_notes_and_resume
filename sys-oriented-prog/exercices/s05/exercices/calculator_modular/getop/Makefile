all : getop_test

clean_all:
	rm getop_test  *.o


# getop module
#-------------
getop_test :           getop_test.o  getop.o  ../ungetch/ungetch.o 
	gcc -o getop_test  getop_test.o  getop.o  ../ungetch/ungetch.o

getop_test.o : getop_test.c  getop.h
	gcc  -c getop_test.c

getop.o :  getop.c  getop.h  ../ungetch/ungetch.h
	gcc -c getop.c


# ungetch module
#---------------
../ungetch/ungetch.o : ../ungetch/ungetch.c  ../ungetch/ungetch.h
	gcc             -c ../ungetch/ungetch.c
