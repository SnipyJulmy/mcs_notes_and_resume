/**
 * Exercice 2 - b
 * Description : Series S01 of the Verification of Cyber-physical System course at MCS BeNeFri
 * Author : Sylvain Julmy
 * Email : sylvain.julmy@unifr.ch
**/

mtype = {P,C};

mtype turn = P;

active proctype producer() {
       // do-notation : defines a loop
       do
       turn == P;
       printf("Produce\n");
       turn = C;
       od
}

active proctype consumer() {
       // do-notation : defines a loop
       do
       /* Guards : wait until (turn == C) because it is the only available statement */
       turn == C;
       printf("Consume\n");
       turn = P;
       od
}