/*
 * File     :     ex5.pl
 * Exercice :     5
 * Description :  Series 11 of the Functionnal and Logic Programming course at UniFR
 * Author :       Sylvain Julmy
 * Email :        sylvain.julmy(at)unifr.ch
 */

exp(exp(or(exp(Left),Right))) --> subExp(Left), ['|'], exp(Right), !.
exp(exp(AST)) --> subExp(AST).

subExp([Head|Tail]) --> term(Head), subExp(Tail).
subExp([AST]) --> term(AST).

term(iter(AST)) --> subTerm(AST), ['*'].
term(AST) --> subTerm(AST).

subTerm(point) --> ['.'].
subTerm(AST) --> ['('], exp(AST), [')'].
subTerm(char(C)) --> [C], {char_type(C,ascii), \+ member(C,['*',')','(','.'])}.

go :-
    L1 = ['a','b','(','c','c',')','*'],
    exp(Ast,L1,[]),
    writef("%q",[Ast]), nl,
    Ast = exp([char(a),char(b),iter(exp([char(c),char(c)]))]),
    L2 = ['a'],
    exp(Ast2,L2,[]),
    writef("%q",[Ast2]),nl,
    Ast2 = exp([char(a)]),
    L3 = ['a','b','c'],
    exp(Ast3,L3,[]),
    writef("%q",[Ast3]),nl,
    Ast3 = exp([char(a),char(b),char(c)]),
    L4 = ['a','b','*','.','a'],
    exp(Ast4,L4,[]),
    writef("%q",[Ast4]),nl,
    Ast4 = exp([char(a), iter(char(b)), point, char(a)]),
    L5 = ['(','a','b',')','*','c'],
    exp(Ast5,L5,[]),
    writef("%q",[Ast5]),nl,
    Ast5 = exp([iter(exp([char(a), char(b)])), char(c)]),
    L6 = ['a','b','|','c','d'],
    exp(Ast6,L6,[]),
    writef("%q",[Ast6]),nl,
    Ast6 = exp(or(exp([char(a), char(b)]), exp([char(c), char(d)]))),
    L7 = ['a','(','b','c','|','d','e',')','*','g'],
    exp(Ast7,L7,[]),
    writef("%q",[Ast7]),nl,
    Ast7 = exp([char(a), iter(exp(or(exp([char(b), char(c)]), exp([char(d), char(e)])))), char(g)]).

