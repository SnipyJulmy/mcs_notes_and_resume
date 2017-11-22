/*
 * File     :     ex1.pl
 * Exercice :     1
 * Description :  Series 09 of the Functionnal and Logic Programming course at UniFR
 * Author :       Sylvain Julmy
 * Email :        sylvain.julmy(at)unifr.ch
 */

% Ex1.a
% insert(+X,?L1,?L2), succeed if L1 and L2 are sorted and if L2 is L1 with X inserted
insert(X,[],[X]).
insert(X,[E1|L1],[X,E1|L1]) :- E1 > X.
insert(X,[E1|L1],[E1|L2]) :- E1 =< X, insert(X,L1,L2).

% Ex1.b
% mergeList(+Xs:list[int],+Ys:list[int],?L3:list), succeed if L3 is sorted and the merge of L1 and L2
mergeList([],[],[]).
mergeList(X,[],X).
mergeList([],Y,Y).
mergeList([X|Xs],[Y|Ys],[X|XYs]) :-
    X < Y,
    mergeList(Xs,[Y|Ys],XYs).
mergeList([X|Xs],[Y|Ys],[Y|XYs]) :-
    mergeList([X|Xs],Ys,XYs).

% Ex1.c
% reverseRec(+L1:list,?L2), succeed if L1 is the reverse of L2 and if each nested list of L1 are also reversed
reverseRec(L1,L2) :- reverseRec(L1,L2,[]).

% recursion with accumulator is simplier for reversing a list
reverseRec([],Acc,Acc).
reverseRec([X|Xs],Ys,Acc) :-
    is_list(X),
    reverseRec(X,Xr),
    reverseRec(Xs,Ys,[Xr|Acc]).
reverseRec([X|Xs],Ys,Acc) :-
    atomic(X),
    reverseRec(Xs,Ys,[X|Acc]).

% Ex1.d
% myMin(+L:list,?X), succeed if X is the smallest element of L
myMin([E|L],X) :- myMin(L,E,X).

% recursion with accumulator used just to pass back the minimal value
myMin([],Acc,Acc).
myMin([X|Xs],E,Acc) :-
    X < E,
    myMin(Xs,X,Acc).
myMin([_|Xs],E,Acc) :- myMin(Xs,E,Acc).
