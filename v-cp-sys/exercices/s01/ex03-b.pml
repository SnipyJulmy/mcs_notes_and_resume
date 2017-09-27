/**
 * Exercice 3 - b
 * Description : Series S01 of the Verification of Cyber-physical System course at MCS BeNeFri
 * Author : Sylvain Julmy
 * Email : sylvain.julmy@unifr.ch
**/

byte x = 2;
byte checkProgress[4];

active proctype A(){
       do
          :: x = 3 - x; checkProgress[0]++;
       od
}

active proctype B(){
       do
          :: x = 3 - x; checkProgress[1]++;
       od
}

active proctype C(){
       do
          :: x = 3 - x; checkProgress[2]++;
       od
}

active proctype D(){
       do
          :: x = 3 - x; checkProgress[3]++;
       od
}

active proctype monitor(){
       repeat :
       checkProgress[0] + checkProgress[1] + checkProgress[2] + checkProgress[3];
       progress :
       skip;
       goto repeat;
}