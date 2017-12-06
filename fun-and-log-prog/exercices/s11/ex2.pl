/*
 * File     :     ex2.pl
 * Exercice :     1
 * Description :  Series 11 of the Functionnal and Logic Programming course at UniFR
 * Author :       Sylvain Julmy
 * Email :        sylvain.julmy(at)unifr.ch
 */

go :-
    % separate
    % printTrace(separate(3,[1,2,3,4,5],_,_)),
    % printTrace(separateCut(3,[1,2,3,4,5],_,_)),

    % myUnion
    % printTrace(myUnion([1,2,3,4,5],[3,4,5,6,7],_)),
    % printTrace(myUnionCut([1,2,3,4,5],[3,4,5,6,7],_)),

    % myIntersection
    % printTrace(myIntersection([1,2,3,4,5],[3,4,5,6,7],_)),
    % printTrace(myIntersectionCut([1,2,3,4,5],[3,4,5,6,7],_)),

    % minMax
    printTrace(minMaxA([1,4],4,2)),
    printTrace(minMaxB([1,4],4,2)),
    printTrace(minMaxC([1,4],4,2)),
    !.

printTrace(Goal) :-
    functor(Goal,F,A),
    writef("+----------------------------+"),nl,
    writef("trace %t/%t",[F,A]), nl,
    trace,
    Goal ; \+(Goal),
    nodebug,
    writef("+----------------------------+"),nl.


% Ex2.1.a
% separate(+X,+L:list,?L1,?L2), succeed if
% - L1 is the list of all element from L less or equals than X
% - L2 is the list of all element from L greater than X
separate(_,[],[],[]).
separate(X,[Y|YS],[Y|L1],L2) :-
    Y =< X,
    separate(X,YS,L1,L2).
separate(X,[Y|YS],L1,[Y|L2]) :-
    Y > X,
    separate(X,YS,L1,L2).

% Ex2.1.b
% separateCut(+X,+L:list,?L1,?L2), succeed if
% - L1 is the list of all element from L less or equals than X
% - L2 is the list of all element from L greater than X
separateCut(_,[],[],[]) :- !.
separateCut(X,[Y|YS],[Y|L1],L2) :-
    Y =< X,
    !,
    separateCut(X,YS,L1,L2).
separateCut(X,[Y|YS],L1,[Y|L2]) :-
    separateCut(X,YS,L1,L2).

% Ex2.2.a
% myUnion(+E1:list,+E2:list,?E3), E1 and E2 are seen as set, their elements are disjoint 2 by 2
% myUnion/3 succeed if and only if E3 is the union of the set E1 and E2
myUnion([],Acc,Acc).
myUnion([X|XS],Acc,Res) :-
    \+ member(X,Acc),
    myUnion(XS,[X|Acc],Res).
myUnion([X|XS],Acc,Res) :-
    member(X,Acc),
    myUnion(XS,Acc,Res).

% Ex2.2.b
% myUnionCut(+E1:set,+E2:set,?E3), E1 and E2 are seen as set, their elements are disjoint 2 by 2
% myUnionCut/3 succeed if and only if E3 is the union of the set E1 and E2
myUnionCut([],Acc,Acc) :- !.
myUnionCut([X|XS],Acc,Res) :-
    member(X,Acc),
    !,
    myUnionCut(XS,Acc,Res).
myUnionCut([X|XS],Acc,Res) :-
    myUnionCut(XS,[X|Acc],Res).

% Ex2.3.a
% myIntersection(+E1:set,+E2:set,?E3), E1 and E2 are seen as set, their elements are disjoint 2 by 2
% myIntersection/3 succeed if and only if E3 is the union of the set E1 and E2
myIntersection([],_,[]).
myIntersection(_,[],[]).
myIntersection([X|XS],E2,[X|E3]) :-
    member(X,E2),
    myIntersection(XS,E2,E3).
myIntersection([X|XS],E2,E3) :-
    \+ member(X,E2),
    myIntersection(XS,E2,E3).

% Ex2.3.b
% myIntersectionCut(+E1:set,+E2:set,?E3), E1 and E2 are seen as set, their elements are disjoint 2 by 2
% myIntersectionCut/3 succeed if and only if E3 is the union of the set E1 and E2
myIntersectionCut([],_,[]) :- !.
myIntersectionCut(_,[],[]) :- !.
myIntersectionCut([X|XS],E2,[X|E3]) :-
    member(X,E2),
    !,
    myIntersectionCut(XS,E2,E3).
myIntersectionCut([_|XS],E2,E3) :-
    myIntersectionCut(XS,E2,E3).

% Ex2.4.a
% minMaxA(+L:list[numeric],?Max,?Min), succeed if Max is the maximum value of L and Min the minimal value of L
% L must have at least one element
minMaxA([X],X,X).
minMaxA([X|XS],Max,Min) :-
    minMaxA(XS,Max2,Min2),
    (X > Max2 -> Max = X ; Max = Max2),
    (X < Min2 -> Min = X ; Min = Min2).

% Ex2.4.b
% minMaxB(+L:list[numeric],?Max,?Min), succeed if Max is the maximum value of L and Min the minimal value of L
% L must have at least one element
minMaxB([X],X,X) :- !.
minMaxB([X|XS],Max,Min) :-
    minMaxB(XS,Max2,Min2),
    (X > Max2 -> Max = X ; Max = Max2),
    (X < Min2 -> Min = X ; Min = Min2).

% Ex2.4.c
% minMaxC(+L:list[numeric],?Max,?Min), succeed if Max is the maximum value of L and Min the minimal value of L
% L must have at least one element
minMaxC([X|XS],Max,Min) :- minMaxC(XS,X,X,Max,Min).

minMaxC([],AccMax,AccMin,AccMax,AccMin) :- !.
minMaxC([X|XS],AccMax,AccMin,Max,Min) :-
    X > AccMax,
    !,
    minMaxC(XS,X,AccMin,Max,Min).
minMaxC([X|XS],AccMax,AccMin,Max,Min) :-
    X < AccMin,
    !,
    minMaxC(XS,AccMax,X,Max,Min).
minMaxC([_|XS],AccMax,AccMin,Max,Min) :-
    minMaxC(XS,AccMax,AccMin,Max,Min).

%%% utils for minMax

% max(+A:numeric,+B:numeric,?C), succeed of C is the maximum value between A and B
max(A,B,A) :- A >= B, !.
max(_,B,B).

% min(+A:numeric,+B:numeric,?C), succeed of C is the minimum value between A and B
min(A,B,A) :- A =< B, !.
min(_,B,B).
