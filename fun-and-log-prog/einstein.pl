% resolution of the einstein problem

:- initialization go.

go :-
    solve(Res),
    writef("%q\n",[Res]),
    hasFish(Res,Nat),
    writef("The %q person holds the fish\n",[Nat]),
    !.

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

info1([(english,red,_,_,_)|_]).
info1([_|XS]) :- info1(XS).

info2([(swedish,_,_,_,dog)|_]).
info2([_|XS]) :- info2(XS).

info3([(danish,_,tea,_,_)|_]).
info3([_|XS]) :- info3(XS).

info4([(_,green,_,_,_),(_,white,_,_,_)|_]).
info4([_|XS]) :- info4(XS).

info5([(_,green,coffee,_,_)|_]).
info5([_|XS]) :- info5(XS).

info6([(_,_,_,pallmall,bird)|_]).
info6([_|XS]) :- info6(XS).

info7([(_,yellow,_,dunhill,_)|_]).
info7([_|XS]) :- info7(XS).

info8(Persons) :-
    getPerson(3,Persons,(_,_,milk,_,_)).

info9(Persons) :-
    getPerson(1,Persons,(norwegian,_,_,_,_)).

info10([(_,_,_,blend,_),(_,_,_,_,cat)|_]).
info10([(_,_,_,_,cat),(_,_,_,blend,_)|_]).
info10([_|XS]) :- info10(XS).

info11([(_,_,_,_,horse),(_,_,_,dunhill,_)|_]).
info11([(_,_,_,dunhill,_),(_,_,_,_,horse)|_]).
info11([_|XS]) :- info11(XS).

info12([(_,_,beer,bluemaster,_)|_]).
info12([_|XS]) :- info12(XS).

info13([(german,_,_,prince,_)|_]).
info13([_|XS]) :- info13(XS).

info14([(norwegian,_,_,_,_),(_,blue,_,_,_)|_]).
info14([(_,blue,_,_,_),(norwegian,_,_,_,_)|_]).
info14([_|XS]) :- info14(XS).

info15([(_,_,_,blend,_),(_,_,water,_,_)|_]).
info15([(_,_,water,_,_),(_,_,_,blend,_)|_]).
info15([_|XS]) :- info15(XS).

solve(Persons) :-
    persons(5,Persons),
    info1(Persons),
    info2(Persons),
    info3(Persons),
    info4(Persons),
    info5(Persons),
    info6(Persons),
    info7(Persons),
    info8(Persons),
    info9(Persons),
    info10(Persons),
    info11(Persons),
    info12(Persons),
    info13(Persons),
    info14(Persons),
    info15(Persons),
    question(Persons).

hasFish([(Nat,_,_,_,fish)|_],Nat).
hasFish([_|Xs],Nat) :- hasFish(Xs,Nat).
