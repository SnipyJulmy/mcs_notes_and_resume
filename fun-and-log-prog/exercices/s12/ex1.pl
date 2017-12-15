/*
 * File     :     ex1.pl
 * Exercice :     1
 * Description :  Series 12 of the Functionnal and Logic Programming course at UniFR
 * Author :       Sylvain Julmy
 * Email :        sylvain.julmy(at)unifr.ch
 */

% Ex1.1
% myMap(+Pred, +LS:list, ?LR), succeed if LR is the LS list mapped with the predicate Pred
% Pred is at least of arity 2, because we have to deduce Y from X with Pred
% for example, myMap(power(2),[1,2,3,4],LS) will succeed with LS = [1,4,9,16].
myMap(_,[],[]) :- !.
myMap(Pred,[X|Xs],[Y|Ys]) :-
    call(Pred,X,Y),
    myMap(Pred,Xs,Ys).

% Ex1.2
% myPartition(+Pred, +L:list, ?Included, ?Excluded), succeed if
% - Included is the list of all element from L that are true with Pred
% - Excluded is the list of all element from L that are false with Pred
myPartition(_,[],[],[]) :- !.
myPartition(Pred,[X|Xs],[X|Included],Excluded) :-
    call(Pred,X),
    myPartition(Pred,Xs,Included,Excluded).
myPartition(Pred,[X|Xs],Included,[X|Excluded]) :-
    \+(call(Pred,X)),
    myPartition(Pred,Xs,Included,Excluded).

% Ex1.3
% filter(+Pred, +L:list, ?Filtered)
% succeed if Filtered is the sublist of L where forall x E Filtered, Pred(x)
filter(_,[],[]) :- !.
filter(Pred,[X|Xs],[X|Ys]) :-
    call(Pred,X),
    filter(Pred,Xs,Ys).
filter(Pred,[X|Xs],Ys) :-
    \+(call(Pred,X)),
    filter(Pred,Xs,Ys).

% Ex1.4
% filterWithFindall(+Pred, +L:list, ?Filtered)
% succeed if Filtered is the sublist of L where forall x E Filtered, Pred(x)
filterWithFindall(Pred,L,Filtered) :-
    findall(X,(member(X,L),call(Pred,X)),Filtered).

% Ex1.5
% myIntersection(+E1,+E2,?E3), succeed if E3 is the set resulting from the intersection of E1 and E2
myIntersection(E1,E2,E3) :-
    findall(X,(member(X,E1),member(X,E2)),E3).

%%% Utils

% add(+N:number,+X:number,?Y), succeed if Y is N + X
add(N,X,Y) :- Y is N + X.

% odd(N), succeed if N is odd
% PRE : N >= 0
odd(0) :- !, fail.
odd(1) :- !.
odd(N) :- N2 is N - 2, odd(N2).

% even(N), succeed if N is even
% PRE : N >= 0
even(0) :- !.
even(1) :- !, fail.
even(N) :- N2 is N - 2, even(N2).
