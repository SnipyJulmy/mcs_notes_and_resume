:-['family.pl'].

% Just to simplify launching...

go :-
    findall(ancestor(X,Y),ancestor(X,Y),Ancestors),
    findall(father(X,Y),father(X,Y),Fathers),
    findall(mother(X,Y),mother(X,Y),Mothers),
    take(5,Ancestors,A5),
    take(5,Fathers,F5),
    take(5,Mothers,M5),
    printPred(A5),
    printPred(F5),
    printPred(M5).

printPred([]) :- !.
printPred([P]) :-
    writef('%q',[P]).
printPred([P|Ps]) :-
    writef('%q,',[P]),
    printPred(Ps).


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
