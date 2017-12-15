/*
 * File     :     ex1.pl
 * Exercice :     1
 * Description :  Series 12 of the Functionnal and Logic Programming course at UniFR
 * Author :       Sylvain Julmy
 * Email :        sylvain.julmy(at)unifr.ch
 */

% Ex3

go :-
    % should fail in a correct implementation
    \+(myMax(6,5,5)).

myMax(X,Y,X) :- X>=Y,!.
myMax(_X,Y,Y).

myMaxCorr(X,Y,X) :- X >= Y, !.
myMaxCorr(X,Y,Y) :- X < Y.
