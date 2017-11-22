/*
 * File     :     ex4.pl
 * Exercice :     4
 * Description :  Series 09 of the Functionnal and Logic Programming course at UniFR
 * Author :       Sylvain Julmy
 * Email :        sylvain.julmy(at)unifr.ch
 */

% quicksort(+L1:list,?L2),succeed if L2 is L1 sorted
quicksort([],[]).
quicksort([X],[X]).
quicksort([Pivot|Xs],Ys) :-
    split(Pivot,Xs,Xs1,Xs2),
    quicksort(Xs1,Ys1),
    quicksort(Xs2,Ys2),
    mergeList(Ys1,[Pivot|Ys2],Ys).

% split(P,Xs,L1,L2), succeed if L1 and L2 and P are Xs (from a set point of view)
% --> L1 U L2 U {P} <-> {x | x <- Xs}
split(_,[],[],[]).
split(P,[X|Xs],[X|Smaller],GreaterOrEquals) :-
    X < P,
    split(P,Xs,Smaller,GreaterOrEquals).
split(P,[X|Xs],Smaller,[X|GreaterOrEquals]) :-
    X >= P,
    split(P,Xs,Smaller,GreaterOrEquals).

% mergeList(+Xs:list[int],+Ys:list[int],?L3:list), succeed if L3 is sorted and the merge of L1 and L2
mergeList([],[],[]).
mergeList(X,[],X).
mergeList([],Y,Y).
mergeList([X|Xs],[Y|Ys],[X|XYs]) :-
    X < Y,
    mergeList(Xs,[Y|Ys],XYs).
mergeList([X|Xs],[Y|Ys],[Y|XYs]) :-
    mergeList([X|Xs],Ys,XYs).
