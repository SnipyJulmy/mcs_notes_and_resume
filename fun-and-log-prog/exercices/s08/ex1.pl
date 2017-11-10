/*
 * File     :     ex1.pl
 * Exercice :     1
 * Description :  Series 08 of the Functionnal and Logic Programming course at UniFR
 * Author :       Sylvain Julmy
 * Email :        sylvain.julmy(at)unifr.ch
 */

% fibonacci(+N:int,?F), succeed if F is the Nth Fibonnaci number
fibonacci(0,0).
fibonacci(1,1).
fibonacci(N,F) :-
    N > 1,
    N1 is N - 1,
    N2 is N - 2,
    fibonacci(N1,F1),
    fibonacci(N2,F2),
    F is F1 + F2.

% fibonacciAcc(+N:int,?F), succeed if F is the Nth Fibonnaci number
% using tailcall optimization with an accumulator
fibonacciAcc(0,0).
fibonacciAcc(1,1).
fibonacciAcc(N,F) :-
    N > 1,
    fibonacciAcc(N,F,0,1).

fibonacciAcc(0,Acc1,Acc1,_).
fibonacciAcc(N,F,Acc1,Acc2) :-
    Next is Acc1 + Acc2,
    N1 is N - 1,
    fibonacciAcc(N1,F,Acc2,Next).


% fibonacciMem(+N:int,?F), succeed if F is the Nth Fibonnaci number
% using hand made memoization with assertz
fibonacciMem(N,F) :- fib(N,F), !.
fibonacciMem(N,F) :-
    N > 1,
    N1 is N - 1,
    fibonacciMem(N1,F1),
    N2 is N - 2,
    fibonacciMem(N2,F2),
    F is F2 + F1,
    assertz(fib(N,F)).

% fib/2 is used for memoization
fib(0,0).
fib(1,1).
