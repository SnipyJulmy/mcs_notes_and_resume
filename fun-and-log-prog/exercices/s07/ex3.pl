/*
 * File     :     ex3.pl
 * Exercice :     3
 * Description :  Series 07 of the Functionnal and Logic Programming course at UniFR
 * Author :       Sylvain Julmy
 * Email :        sylvain.julmy(at)unifr.ch
 */

:-['ex3_annexe.pl'].

% child(?X,?Y), succeed if X is the child of Y.
child(X,Y) :- parent(Y,X).

% father(?X,?Y), succeed if X is the father of Y
father(X,Y) :-
    parent(X,Y),
    male(X).

% mother(?X,?Y), succeed if X is the mother of Y
mother(X,Y) :-
    parent(X,Y),
    female(X).

% grandParent(?X,?Y), succeed if X is the grandParent of Y
grandParent(X,Y) :-
    parent(X,T),
    parent(T,Y).

% grandFather(?X,?Y), succeed if X is the grandFather of Y
grandFather(X,Y) :-
    father(X,T),
    parent(T,Y).

% uncle(?X,?Y), succeed if X is the uncle of Y
uncle(X,Y) :-
    parent(P,Y),
    parent(GP,P),
    parent(GP,X),
    \==(P,X),
    male(X).

% ancestor(?X,?Y), succeed if X is the ancestor of Y
ancestor(X,Y) :- parent(X,Y).
ancestor(X,Y) :-
    parent(X,SomeBody),
    ancestor(SomeBody,Y).

%%% Utils

% distinct(+XS,-Ys), always succeed, remove all duplicates from XS
distinct([],[]) :- !.
distinct([X|XS],YS) :-
    contains(X,XS),
    distinct(XS,YS).
distinct([X|XS],[X|YS]) :-
    distinct(XS,YS).

% contains(+Elt,+XS), succeed if XS contains Elt
contains(Elt,[]) :- fail.
contains(Elt,[X|XS]) :-
    Elt == X, !.
contains(Elt,[X|XS]) :- contains(Elt,XS).

% noParents(?X), succeed if X has no parents
noParents(X) :- parent(X,_) , \+(parent(_,X)).

% display the genealogy tree of each person
displayFamilyTree :-
    % find all the people who have no parents
    findall(X,noParents(X),Roots),
    distinct(Roots,UniqueRoots),
    writef('Familly : \n',[]),
    displayFamilyTree(UniqueRoots).

displayFamilyTree([]).
displayFamilyTree([P|PS]) :-
    writef('%q\n',[P]),
    displayChildren(P,1),
    displayFamilyTree(PS).

displayChildren(P,Depth) :-
    findall(X,parent(P,X),Childs),
    distinct(Childs,Children),
    displayWithTab(Children,Depth).

displayWithTab([],_) :- !.
displayWithTab([X|XS],Depth) :-
    printTab(Depth),
    writef('%q\n',[X]),
    displayWithTab(XS,Depth).

printTab(0) :- !.
printTab(Nb) :-
    writef('\t',[]),
    Next is Nb - 1,
    printTab(Next).
