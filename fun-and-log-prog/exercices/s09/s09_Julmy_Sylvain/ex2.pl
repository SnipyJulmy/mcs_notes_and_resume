/*
 * File     :     ex2.pl
 * Exercice :     2
 * Description :  Series 09 of the Functionnal and Logic Programming course at UniFR
 * Author :       Sylvain Julmy
 * Email :        sylvain.julmy(at)unifr.ch
 */

% createLA(?Keys,?Values,?ListAssoc), succeed if ListAssoc is the zip of Keys and Values
createLA([],[],[]).
createLA([],_Values,[]).
createLA(_Keys,[],[]).
createLA([K|Keys],[V|Values],[(K,V)|L]) :- createLA(Keys,Values,L).

% valuesLA(+LA:list[(k,v)],?Key,?Value), succeed if (Key,Value) is in LA
valuesLA([(Key,Value)|_],Key,Value).
valuesLA([(_,_)|LA],Key,Value) :- valuesLA(LA,Key,Value).

% go/0 : serve as a simple test tool...
go :-
    Keys = [a,b,c,d,e,f,g],
    Values = [alpha,bravo,charlie,delta,echo,foxtrot,golf],
    createLA(Keys,Values,LA),
    values(LA,a,alpha),
    values(LA,d,delta),
    values(LA,e,echo),
    values(LA,g,G),
    G = golf,
    Keys2 = [a,b,c],
    Values2 = [_A,_B,_C],
    createLA(Keys2,Values2,LA2).
