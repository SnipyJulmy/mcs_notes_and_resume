% example of using the metagol system

:- use_module('metagol').

male(hector).
male(paul).
male(david).
male(sebastien).

female(anne).
female(julie).
female(elisa).
female(carole).

parent(hector,paul).
parent(anne,paul).
parent(julie,elisa).
parent(david,elisa).
parent(elisa,sebastien).
parent(paul,sebastien).
parent(elisa,carole).
parent(paul,carole).


prim(male/1).
prim(female/1).
prim(parent/2).

% metarules
metarule([P,Q],([P,A,B]:-[[Q,A,B]])).
metarule([P,Q,R],([P,A,B]:-[[Q,A,B],[R,A,B]])).
metarule([P,Q,R],([P,A,B]:-[[Q,A,C],[R,C,B]])).

createGrandParent :-
    Pos = [
        grandParent(hector,sebastien),
        grandParent(julie,sebastien),
        grandParent(hector,elisa),
        grandParent(julie,elisa),
        grandParent(david,elisa)
    ],
    Neg = [
        grandParent(paul,elisa)
    ],
    learn(Pos,Neg).
