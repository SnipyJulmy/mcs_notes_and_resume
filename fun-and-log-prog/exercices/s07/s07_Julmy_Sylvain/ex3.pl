/*
 * File     :     ex3.pl
 * Exercice :     3
 * Description :  Series 07 of the Functionnal and Logic Programming course at UniFR
 * Author :       Sylvain Julmy
 * Email :        sylvain.julmy(at)unifr.ch
 */

:-['ex3_annexe.pl'].

% Just to simplify launching...
:- initialization go.
go :-
    findall(ancestor(X,Y),ancestor(X,Y),Bag),
    length(Bag,L),
    writef("%q, length : %q",[Bag,L]).

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
    parent(GP,X),
    parent(GP,P),
    \==(P,X),
    male(X).

% ancestor(?X,?Y), succeed if X is the ancestor of Y
ancestor(X,Y) :- parent(X,Y).
ancestor(X,Y) :-
    ancestor(SomeBody,Y),
    parent(X,SomeBody).
