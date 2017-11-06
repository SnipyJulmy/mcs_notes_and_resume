/*
 * File     :     ex2.pl
 * Exercice :     2
 * Description :  Series 07 of the Functionnal and Logic Programming course at UniFR
 * Author :       Sylvain Julmy
 * Email :        sylvain.julmy(at)unifr.ch
 */

% Ex1.a
% unification of X and Y
predA(X,Y) :- X = Y.

% Ex1.b
% succeed if X and Y can't be unified
predB(X,Y) :- X \= Y.

% Ex1.c
% succed if X and Y are the same atom or exactly the same variable
predC(X,Y) :- X == Y.

% Ex1.d
% succeed if X and Y are not the same atom or not exactly the same variable
predD(X,Y) :- X \== Y.

% Ex1.e
% succeed if the evaluation of X and Y are number and if X is not equal to Y
predE(X,Y) :- X =\= Y.

% Ex1.f
% succeed if the evaluation of X and Y are number and if X is equal to Y
predF(X,Y) :- X =:= Y.

% Ex1.g
% succeed if X is a variable and if the evaluation of Y is a number
predG(X,Y) :- X is 3 + Y.
