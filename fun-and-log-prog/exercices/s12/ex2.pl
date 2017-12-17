/*
 * File     :     ex2.pl
 * Exercice :     1
 * Description :  Series 12 of the Functionnal and Logic Programming course at UniFR
 * Author :       Sylvain Julmy
 * Email :        sylvain.julmy(at)unifr.ch
 */

:- dynamic house/6.

% Zebra problem
% We use the following structure to represent the problem :

% initProblem(-P), create the problem structure
% we use the following structure for the tupple :
%  - (Nationality,Color,Drink,SmokeMark,Pet)

initProblem(P) :-
    initProblem(5,P).

initProblem(1,[(1,_Color,_Nationality,_Animal,_Drink,_Cigarette)]) :- !.
initProblem(N,[(N,_Color,_Nationality,_Animal,_Drink,_Cigarette)|P]) :-
    N1 is N - 1,
    initProblem(N1,P).

drink(N,D,[(_,_,N,_,D,_)|_]).
drink(N,D,[_|Xs]) :- drink(N,D,Xs).

hasAnimal(N,A,[(_,_,N,A,_,_)|_]).
hasAnimal(N,A,[_|Xs]) :- hasAnimal(N,A,Xs).

smoke(N,C,[(_,_,N,_,_,C)|_]).
smoke(N,C,[_|Xs]) :- smoke(N,C,Xs).

color(I,C,[(I,C,_,_,_,_)|_]).
color(I,C,[_|Xs]) :- color(I,C,Xs).

getNthHouse(I,[(I,C,N,A,D,S)|_],(I,C,N,A,D,S)).
getNthHouse(I,[_|Xs],H) :- getNthHouse(I,Xs,H).

nationality(I,N,([(I,_,N,_,_,_)|_])).
nationality(I,N,[_|Xs]) :- nationality(I,N,Xs).

hint1(P) :- getNthHouse(1,P,(1,_,norwegian,_,_,_)).

hint2(P) :-
    getNthHouse(N1,P,(_,_,norwegian,_,_,_)),
    getNthHouse(N2,P,(_,blue,_,_,_,_)),
    (N1 is N2 + 1 ; N1 is N2 - 1).

hint3(P) :- getNthHouse(3,P,(_,_,_,_,milk,_)).

hint4(P) :- color(I,red,P), nationality(I,english,P).

hint5(P) :- color(I,green,P), nationality(I,N,P), drink(N,coffee,P).

hint6(P) :- color(I,yellow,P), nationality(I,N,P), smoke(N,kool,P).

hint7(P) :- color(Iw,white,P), color(Ig,green,P), (Iw is Ig - 1 ; Iw is Ig + 1).

hint8(P) :- hasAnimal(spain,dog,P).

hint9(P) :- drink(ukrainian,tea,P).

hint10(P) :- smoke(japanese,craven,P).

hint11(P) :- smoke(N,oldGold,P), hasAnimal(N,snail,P).

hint12(P) :- smoke(N,gitane,P), drink(N,wine,P).

hint13(P) :-
    smoke(N1,chesterfield,P),
    hasAnimal(N2,fox,P),
    nationality(I1,N1,P),
    nationality(I2,N2,P),
    (I2 is I1 - 1 ; I2 is I1 + 1).

hint14(P) :-
    smoke(N1,kool,P),
    hasAnimal(N2,horse,P),
    nationality(I1,N1,P),
    nationality(I2,N2,P),
    (I2 is I1 - 1 ; I2 is I1 + 1).

question1(P,N) :- drink(N,water,P).

question2(P,N) :- hasAnimal(N,zebra,P).

solve :-
    initProblem(P),
    hint1(P),
    hint2(P),
    hint3(P),
    hint4(P),
    hint5(P),
    hint6(P),
    hint7(P),
    hint8(P),
    hint9(P),
    hint10(P),
    hint11(P),
    hint12(P),
    hint13(P),
    hint14(P),
    question1(P,Nwater),
    question2(P,Nzebra),
    writef("%q drink water\n",[Nwater]),
    writef("%q has a zebra\n",[Nzebra]),
    !.
