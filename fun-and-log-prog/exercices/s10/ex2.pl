/*
 * File     :     ex2.pl
 * Exercice :     2
 * Description :  Series 10 of the Functionnal and Logic Programming course at UniFR
 * Author :       Sylvain Julmy
 * Email :        sylvain.julmy(at)unifr.ch
 */

% V is the evaluation of the expression given to the DCG
e(V) --> t(V).
e(V) --> t(V1), ['+'], e(V2), {V is V1 + V2}.
t(V) --> f(V).
t(V) --> f(V1), ['*'], t(V2), {V is V1 * V2}.
f(V) --> [Int], {integer(Int), V is Int}.
f(V) --> ['('], e(V), [')'].
