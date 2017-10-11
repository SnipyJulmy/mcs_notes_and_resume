/**
 * Exercice 1
 * Description : Series S01 of the Verification of Cyber-physical System course at MCS BeNeFri
 * Author : Sylvain Julmy
 * Email : sylvain.julmy@unifr.ch
**/

byte global = 0;

/*
 * Indefinitely increase the "global" variable if it is lower than 255
 */
active proctype incProcess() {
    repeat :
    // If the assertion fail, it indicates that the "global" variable have reaches 255
    assert (global != 255);
    global < 255;
    global++;
    goto repeat;
}

/*
 * Indefinitely decrease the "global" variable if it is greater than 0
 */
active proctype decProcess() {
    repeat :
    // If the assertion fail, it indicates that the "global" variable have reaches 255
    assert (global != 255);
    global > 0;
    global--;
    goto repeat;
}
