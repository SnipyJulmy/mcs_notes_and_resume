all : calc

clean_all:
	rm calc  *.o


#calc
#----
calc :           calc.o  ./stack/stack.o  ./getop/getop.o  ./ungetch/ungetch.o
	gcc -o calc  calc.o  ./stack/stack.o  ./getop/getop.o  ./ungetch/ungetch.o
	
calc.o :   calc.c  ./stack/stack.h  ./getop/getop.h
	gcc -c calc.c	


# stack module
#-------------
./stack/stack.o :  ./stack/stack.c  ./stack/stack.h
	gcc         -c ./stack/stack.c  -o ./stack/stack.o


# getop module
#-------------
./getop/getop.o :  ./getop/getop.c  ./getop/getop.h  ./ungetch/ungetch.h
	gcc         -c ./getop/getop.c  -o ./getop/getop.o


# ungetch module
#----------------
./ungetch/ungetch.o : ./ungetch/ungetch.c  ./ungetch/ungetch.h
	gcc            -c ./ungetch/ungetch.c  -o ./ungetch/ungetch.o
