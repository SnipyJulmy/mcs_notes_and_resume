/*
 * File     :     ex4.pl
 * Exercice :     4
 * Description :  Series 11 of the Functionnal and Logic Programming course at UniFR
 * Author :       Sylvain Julmy
 * Email :        sylvain.julmy(at)unifr.ch
 */

% Ex4.1
% DCG for the grammar a*bca*
ex4_1 --> aStar, [b], [c], aStar.

aStar --> [a], aStar.
aStar --> [].

% Ex4.2
% DCG for the grammar (a.|bc)*uu*
ex4_2 --> first, uPlus.

first --> [a], [Any], {char_type(Any,ascii)} , first.
first --> [b], [c], first.
first --> [].

uPlus --> [u], uStar.

uStar --> [u], uStar.
uStar --> [].
