/**
 * Exercice 3 - b
 * Description : Series S01 of the Verification of Cyber-physical System course at MCS BeNeFri
 * Author : Sylvain Julmy
 * Email : sylvain.julmy@unifr.ch
**/

byte x = 2;
byte checkProgress[4];

active proctype A(){
       do ::
           checkProgress[0]==0;
           x = 3 - x;
           checkProgress[0]++;
       od
}

active proctype B(){
       do ::
           checkProgress[1]==0;
           x = 3 - x;
           checkProgress[1]++;
       od
}

active proctype monitor(){
       repeat :
       checkProgress[0] + checkProgress[1] == 2;
       progress :
       checkProgress[0] = 0;
       checkProgress[1] = 0;
       goto repeat;
}