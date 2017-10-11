/** 
 * Exercice 1
 * Description : Series S02 of the Verification of Cyber-physical System course at MCS BeNeFri
 * Author : Sylvain Julmy
 * Email : sylvain.julmy@unifr.ch
**/

chan global = [0] of {bool};
int counter0 = 0;
int counter1 = 0;

active proctype writer() {
    do
        :: global!0;
        :: global!1;
    od
}

active proctype reader() {
    do
        :: global?0; counter0++;
        :: global?1; counter1++;
    od
}