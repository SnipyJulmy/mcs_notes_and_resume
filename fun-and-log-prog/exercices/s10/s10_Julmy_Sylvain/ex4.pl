/*
 * File     :     ex4.pl
 * Exercice :     4
 * Description :  Series 10 of the Functionnal and Logic Programming course at UniFR
 * Author :       Sylvain Julmy
 * Email :        sylvain.julmy(at)unifr.ch
 */

% Ex4.a
% myLast(+X,-L:list), succeed if X is the last element of L
myLast(X,L) :- myLast(X,L,[]).

myLast(X) --> [X].
myLast(X) --> [_], myLast(X).

% Ex4.b
% convertToDec(?X,+L:list[int]), succeed if X is the decimal value of the binary value L
% L is a list of 1 and 0, like L = [0,0,1,1,0,1,0]
% we use a big endian representation, for example :
% - [1,0,0] is the decimal value of 1
% - [0,0,1] is the decimal value of 4
convertToDec(X,L) :- convertToDec(X,0,L,[]).

convertToDec(0,_) --> [0].
convertToDec(X,Depth) --> [1], {X is 2**Depth}.
convertToDec(X,Depth) --> [0], {Depth1 is Depth+1}, convertToDec(X,Depth1).
convertToDec(X,Depth) --> [1],
                          {Depth1 is Depth+1},
                          convertToDec(Xsub,Depth1),
                          {X is Xsub + 2 ** Depth}.
