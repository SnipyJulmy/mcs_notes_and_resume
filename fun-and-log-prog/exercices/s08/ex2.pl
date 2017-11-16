/*
 * File     :     ex2.pl
 * Exercice :     2
 * Description :  Series 08 of the Functionnal and Logic Programming course at UniFR
 * Author :       Sylvain Julmy
 * Email :        sylvain.julmy(at)unifr.ch
 */

% Ex2.a
% myLength(?N:list,?L:int), succeed if L is the length of N
myLength(0,[]).
myLength(Res,[_|Xs]) :-
    myLength(N,Xs),
    Res is N + 1.

% Ex2.b
% myAppend(?L1:list,?L2:list,?L3:list), succeed if L3 is the concatenation of L1 and L2
myAppend([],L,L).
myAppend([X|Xs],Ys,[X|L3]) :-
    myAppend(Xs,Ys,L3).

% Ex2.c
% myLast(?E,?L:list), succeed if E is the last element of L
myLast(E,[E|[]]).
myLast(E,[_|Xs]) :- myLast(E,Xs).

% Ex2.d
% myReverse(?L1:list,?L2:list), succeed if L1 is the reverse of L2
myReverse([],[]). % not necessary, myReverse([],[],L3) would unify to myReverse([],[],[]).
myReverse(L1,L2) :- myReverse(L1,L2,[]).

% recursive execution, using accumulator to reverse L1 from myReverse/2
myReverse([],Acc,Acc).
myReverse([X|Xs],L2,Acc) :- myReverse(Xs,L2,[X|Acc]).

% Ex2.e
% mySelect(?E,?L1:list,?L2:list), succeed if L2 is (L1 \ E)
mySelect(E,[E|Xs],Xs).
mySelect(E,[X|Xs],[X|Ys]) :- mySelect(E,Xs,Ys).

% Ex2.f
% atoms(?L:list),succeedif L contains only atom
% if L is [], we consider that L contains only atom
atoms([]).
atoms([X|Xs]) :-
    atom(X),
    atoms(Xs).
