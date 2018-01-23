/*
 * File     :     ex2_bis.pl
 * Exercice :     2
 * Description :  Series 12 of the Functionnal and Logic Programming course at UniFR
 * Author :       Sylvain Julmy
 * Email :        sylvain.julmy(at)unifr.ch
 */

:- initialization(go).

go :-
    retractall(house(_,_,_,_,_,_)),
    houseComposition(C,A,B,F,N),
    assertHouse(C,A,B,F,N,1).

assertHouse([],[],[],[],[],_) :- !.
assertHouse([C|Cs],[A|As],[B|Bs],[F|Fs],[N|Ns],I) :-
    assertz(house(I,C,N,A,B,F)),
    I1 is I + 1,
    assertHouse(Cs,As,Bs,Fs,Ns,I1).

houseComposition(C,A,B,F,N) :-
    C = [_C1,C2,_C3,_C4,_C5],
    A = [_A1,_A2,_A3,_A4,_A5],
    B = [_B1,_B2,B3,_B4,_B5],
    F = [_F1,_F2,_F3,_F4,_F5],
    N = [N1,_N2,_N3,_N4,_N5],
    % hint1
    N1 = norwegian,
    % hint2
    C2 = blue,
    % hint3
    B3 = milk,
    % hint4
    sameIndex(red,english,C,N),
    % hint5
    sameIndex(green,coffee,C,B),
    % hint6
    sameIndex(yellow,kool,C,F),
    % hint7
    tail(C,Ct),
    sameIndex(green,white,C,Ct),
    % hint8
    sameIndex(spain,dog,N,A),
    % hint9
    sameIndex(ukrainian,tea,N,B),
    % hint10
    sameIndex(japanese,craven,N,F),
    % hint11
    sameIndex(oldGold,snail,F,A),
    % hint12
    sameIndex(gitane,wine,F,B),
    % hint13
    tail(F,Ft),
    tail(A,At),
    (sameIndex(chesterfield,fox,F,At); sameIndex(chesterfield,fox,Ft,A)),
    % hint14
    (sameIndex(kool,horse,F,At); sameIndex(kool,horse,Ft,A)),
    % question 1
    sameIndex(_Nwater,water,N,B),
    % question 2
    sameIndex(_Nzebra,zebra,N,A),
    !.

sameIndex(E1,E2,[E1|_],[E2|_]).
sameIndex(E1,E2,[_|L1],[_|L2]) :-
    sameIndex(E1,E2,L1,L2).

tail([_|Xs],Xs).

drink(N,D) :- house(_,_,N,_,D,_).

hasAnimal(N,A) :- house(_,_,N,A,_,_).

smoke(N,C) :- house(_,_,N,_,_,C).

color(I,C) :- house(I,C,_,_,_,_).
