/*
 * File     :     ex4.pl
 * Exercice :     4
 * Description :  Series 07 of the Functionnal and Logic Programming course at UniFR
 * Author :       Sylvain Julmy
 * Email :        sylvain.julmy(at)unifr.ch
 */

% hanoi tower problem resolution
hanoi(0,_,_,_).
hanoi(Height,Start,Middle,End) :-
    NextHeight is Height - 1,
    hanoi(NextHeight,Start,Middle,End),
    writef('dep from %q to %q\n',[Start,End]),
    hanoi(NextHeight,Middle,End,Start).
