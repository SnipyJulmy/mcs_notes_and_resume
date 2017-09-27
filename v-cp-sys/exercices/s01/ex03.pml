/**
 * Exercice 3
 * Description : Series S01 of the Verification of Cyber-physical System course at MCS BeNeFri
 * Author : Sylvain Julmy
 * Email : sylvain.julmy@unifr.ch
**/

byte x = 2;

active proctype A(){
       do
          :: x = 3 - x; progress : skip;
       od
}

active proctype B(){
       do
          :: x = 3 - x;
       od
}
