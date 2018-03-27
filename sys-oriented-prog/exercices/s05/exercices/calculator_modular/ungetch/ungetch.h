/*----------------------------------------------------------------------------
un_getch "module": specification                                      --- kr79

Adapted by Beat Hirsbrunner, 20 October 2011
----------------------------------------------------------------------------*/

#define BUF_SIZE      2  // maximal number of successive ungetch calls
#define BUF_OVERFLOW -5  // error if maximal number of successive ungetch calls 

int getch(void);    // get a (possibly pushed back) character

int ungetch(int c);	// push character back on input;
                    // return BUF_OVERFLOW if more than BUFSIZE successive
                    // ungetch calls have been made, else return 0