/*
 * File     :     ex1.pl
 * Exercice :     1
 * Description :  Series 10 of the Functionnal and Logic Programming course at UniFR
 * Author :       Sylvain Julmy
 * Email :        sylvain.julmy(at)unifr.ch
 */

% Ex1.1
% DCG that recognize the language [0]*[1][0]*[1]
s --> b, b.
b --> [0], b.
b --> [1].

% Ex1.2, s2 is s from the exercice sheet
% DCG that recognize the language (ab)*
s2 --> [a], [b], s2.
s2 --> [].

% Ex1.3
% DCG that recognize the langauge of expression
% term, factor and parenthesis expression
e --> t.
e --> t, ['+'], e.
t --> f.
t --> f, ['*'], t.
f --> [Int], {integer(Int)}.
f --> ['('], e, [')'].
