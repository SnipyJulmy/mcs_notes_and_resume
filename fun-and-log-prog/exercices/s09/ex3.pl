/*
 * File     :     ex3.pl
 * Exercice :     3
 * Description :  Series 09 of the Functionnal and Logic Programming course at UniFR
 * Author :       Sylvain Julmy
 * Email :        sylvain.julmy(at)unifr.ch
 */

% Ex3.a
% sum_list(+L:list[number],?S), succeed if S is the sum of all element is L
sum_list([],0).
sum_list(L,S) :- sum_list(L,S,0).

% using accumulator, sum_list/2 is just the initiation predicat
sum_list([],Acc,Acc).
sum_list([X|Xs],S,Acc) :-
    NewAcc is Acc + X,
    sum_list(Xs,S,NewAcc).

% Ex3.b
% reverseRec(+L1:list,?L2), succeed if L1 is the reverse of L2 and if each nested list of L1 are also reversed
reverseRec(L1,L2) :- reverseRec(L1,L2,[]).

% using accumulator, reverseRec/2 is just the initiation predicat
reverseRec([],Acc,Acc).
reverseRec([X|Xs],Ys,Acc) :-
    is_list(X),
    reverseRec(X,Xr),
    reverseRec(Xs,Ys,[Xr|Acc]).
reverseRec([X|Xs],Ys,Acc) :-
    atomic(X), % for assertion, not necessary
    reverseRec(Xs,Ys,[X|Acc]).

% Ex3.c
% myMin(+L:list,?X), succeed if X is the smallest element of L
myMin([E|L],X) :- myMin(L,E,X).

% recursion with accumulator used just to pass back the minimal value
% myMin/2 is the initiation predicate
myMin([],Acc,Acc).
myMin([X|Xs],E,Acc) :-
    X < E,
    myMin(Xs,X,Acc).
myMin([_|Xs],E,Acc) :- myMin(Xs,E,Acc).

% Ex3.d
% succeed if F is the Nth fibonacci number
fibonacci(N,F) :- fibonacci(N,F,0,1).

% implementation of fibonacci/2, which is just the initiation predicat
fibonacci(0,Acc1,Acc1,_).
fibonacci(N,F,Acc1,Acc2) :-
    NextAcc is Acc1 + Acc2,
    N1 is N - 1,
    fibonacci(N1,F,Acc2,NextAcc).

%%% Utils

% map(?Xs:list,+P:predicat,?Ys:list), succeed if Ys is the map of Xs using the predicat P of arity 2
% P is a predicat of arity 2 like P(+X,?Y).
map([],_,[]).
map([X|Xs],P,[Y|Ys]) :-
    call(P,X,Y),
    map(Xs,P,Ys).
