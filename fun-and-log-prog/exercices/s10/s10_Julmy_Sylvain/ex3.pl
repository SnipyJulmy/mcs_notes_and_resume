/*
 * File     :     ex3.pl
 * Exercice :     3
 * Description :  Series 10 of the Functionnal and Logic Programming course at UniFR
 * Author :       Sylvain Julmy
 * Email :        sylvain.julmy(at)unifr.ch
 */

% Gender is unify with either male or female if sentence/4 succeed
% Number is unify with either singular or plural if sentence/4 succeed
sentence(Gender,Number) --> nominal_group(Gender,Number), verbal_group(Number).

nominal_group(G,N) --> article(G,N), substantive(G,N).

nominal_group(G,N) --> article(G,N), substantive(G,N), adjective(G,N).

nominal_group(G,singular) --> firstname(G).

verbal_group(N) --> verb(N).

% terminal symbols
% using member is simplier because we have to check for Gender and Number
firstname(G) --> [N], {member(N,[ruth, david]), gender(N,G)}.

article(G,N) --> [A], {member(A,[le, la, les, un, une, des]), gender(A,G), number(A,N)}.

substantive(G,N) --> [S], {member(S,[chien, chat, amis, voiture, souris]), gender(S,G), number(S,N)}.

verb(N) --> [V], {member(V,[chante, roule, marche, racontent, avancent]), number(V,N)}.

adjective(G,N) --> [A], {member(A,[rouge, rouges, blanc, blancs, blanche, blanches]), gender(A,G), number(A,N)}.

%%% Gender

% gender(?E,?G), succeed if E as the gender G
% G is unify with the atoms male or female
gender(A,male) :- is_male(A).
gender(A,female) :- is_female(A).

is_male(A) :- member(A,[rouge,rouges,blanc,blancs,chien,chat,amis,le,les,un,des,david]).

is_female(A) :- member(A,[blanche,blanches,voiture,souris,la,une,ruth,les,des]).

%%% Number

% number(?E,?N), succeed if E as the numbering N
% N is unify with the atoms singular or plural
number(A,singular) :- is_singular(A).
number(A,plural) :- is_plural(A).

is_singular(A) :- member(A,[le,la,un,une,chien,chat,voiture,souris,rouge,blanc,blanche,chante,roule,marche]).

is_plural(A) :- member(A,[les,des,souris,amis,racontent,avancent,rouges,blancs,blanches]).
