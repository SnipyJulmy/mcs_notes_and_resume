% resolution of the einstein problem

:- initialization go.

go :-
    solve(Res),
    writef("%q\n",[Res]),
    hasFish(Res,Nat),
    writef("The %q person holds the fish\n",[Nat]).

% predicate that is building the uninstancied solutions for us
% we use the following structure for the tupple :
%  - (Nationality,Color,Drink,SmokeMark,Pet)
persons(0,[]) :- !.
persons(N,[(_Nationality,_Color,_Drink,_SmokeMark,_Pet)|T]) :-
    N1 is N - 1,
    persons(N1,T).

% get the nth person
getPerson(1,[P|_],P) :- !.
getPerson(N,[_|XS],P) :-
    N1 is N - 1,
    getPerson(N1,XS,P).

question([(_,_,_,_,fish)|_]).
question([_|XS]) :- question(XS).

hint1([(english,red,_,_,_)|_]).
hint1([_|XS]) :- hint1(XS).

hint2([(swedish,_,_,_,dog)|_]).
hint2([_|XS]) :- hint2(XS).

hint3([(danish,_,tea,_,_)|_]).
hint3([_|XS]) :- hint3(XS).

hint4([(_,green,_,_,_),(_,white,_,_,_)|_]).
hint4([_|XS]) :- hint4(XS).

hint5([(_,green,coffee,_,_)|_]).
hint5([_|XS]) :- hint5(XS).

hint6([(_,_,_,pallmall,bird)|_]).
hint6([_|XS]) :- hint6(XS).

hint7([(_,yellow,_,dunhill,_)|_]).
hint7([_|XS]) :- hint7(XS).

hint8(Persons) :-
    getPerson(3,Persons,(_,_,milk,_,_)).

hint9(Persons) :-
    getPerson(1,Persons,(norwegian,_,_,_,_)).

hint10([(_,_,_,blend,_),(_,_,_,_,cat)|_]).
hint10([(_,_,_,_,cat),(_,_,_,blend,_)|_]).
hint10([_|XS]) :- hint10(XS).

hint11([(_,_,_,_,horse),(_,_,_,dunhill,_)|_]).
hint11([(_,_,_,dunhill,_),(_,_,_,_,horse)|_]).
hint11([_|XS]) :- hint11(XS).

hint12([(_,_,beer,bluemaster,_)|_]).
hint12([_|XS]) :- hint12(XS).

hint13([(german,_,_,prince,_)|_]).
hint13([_|XS]) :- hint13(XS).

hint14([(norwegian,_,_,_,_),(_,blue,_,_,_)|_]).
hint14([(_,blue,_,_,_),(norwegian,_,_,_,_)|_]).
hint14([_|XS]) :- hint14(XS).

hint15([(_,_,_,blend,_),(_,_,water,_,_)|_]).
hint15([(_,_,water,_,_),(_,_,_,blend,_)|_]).
hint15([_|XS]) :- hint15(XS).

solve(Persons) :-
    persons(5,Persons),
    hint1(Persons),
    hint2(Persons),
    hint3(Persons),
    hint4(Persons),
    hint5(Persons),
    hint6(Persons),
    hint7(Persons),
    hint8(Persons),
    hint9(Persons),
    hint10(Persons),
    hint11(Persons),
    hint12(Persons),
    hint13(Persons),
    hint14(Persons),
    hint15(Persons),
    question(Persons).

hasFish([(Nat,_,_,_,fish)|_],Nat).
hasFish([_|Xs],Nat) :- hasFish(Xs,Nat).
