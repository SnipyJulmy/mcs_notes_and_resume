/*
 * File     :     ex1.pl
 * Exercice :     1
 * Description :  Series 12 of the Functionnal and Logic Programming course at UniFR
 * Author :       Sylvain Julmy
 * Email :        sylvain.julmy(at)unifr.ch
 */

% Ex3

grammar(Rules) --> rule(Rule), grammar(Rs), {append(Rule,Rs,Rules)}.
grammar(Rules) --> rule(Rules).

rule(Rules) --> ruleName(Identifier), ['->'], ruleBody(Is),
               {processBody(Identifier,Is,Rules)}.

ruleBody([Identifier|Is]) --> ruleBodyPartRec(Identifier),['|'] , ruleBody(Is).
ruleBody([Identifier]) --> ruleBodyPartRec(Identifier).

ruleBodyPartRec([Id|Ids]) --> ruleBodyPart(Id), ruleBodyPartRec(Ids).
ruleBodyPartRec([Id]) --> ruleBodyPart(Id).

ruleBodyPart(Identifier) --> ruleName(Identifier).
ruleBodyPart([Identifier]) --> atomName(Identifier).

ruleName(Identifier) --> [Identifier], {atom_chars(Identifier,L), L = [r,'_'|_]}.

atomName(Identifier) --> [Identifier], {atom_chars(Identifier,L) , \+(L = [r,'_'|_]), \+(L = [-,>])}.

processBody(_,[],[]).
processBody(Id,[RB|RBs],[Rule|Rs]) :-
    transformListInTermWithoutFunctor(RB,Body),
    Rule = -->(Id,Body),
    processBody(Id,RBs,Rs).

generateRules(L) :-
    grammar(Rs,L,[]),
    processRules(Rs),
    !.

processRules([]) :- !.
processRules([R|Rs]) :-
    expand_term(R,T),
    assertz(T),
    processRules(Rs).

transformListInTermWithoutFunctor(L,P) :-
    addCommaFunctor(L,R),
    transformListWithCommas(R,P).

addCommaFunctor([X],[X]):-!.
addCommaFunctor([X,Y],[',',X,Y]):-!.
addCommaFunctor([X|R],[',',X|[T]]) :- addCommaFunctor(R,T).

transformListWithCommas([',',X,[','|Y]],P) :-
    !,
    transformListWithCommas([','|Y],F),
    P =..[',',X,F].
transformListWithCommas([',',X,Y],P) :-
    !,
    P =..[',',X,Y].
transformListWithCommas([X],X).
