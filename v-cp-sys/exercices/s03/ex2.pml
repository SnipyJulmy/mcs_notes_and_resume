/** 
 * Exercice 2
 * Description : Series S03 of the Verification of Cyber-physical System course at MCS BeNeFri
 * Author : Sylvain Julmy
 * Email : sylvain.julmy@unifr.ch
**/

/* LTL formula and variable */

#define p true
#define q true

/* Main program */

#define other ((idx+1) % 2)

byte p1,p2;

bool mut[2];
bool turn;

proctype process(int idx){
    start :
    mut[idx] = true;
    turn = idx;
    (mut[other] == false || turn == other);

    /* critical section */
    critical : skip;

    mut[idx] = false;
    goto start;
}

init {
    mut[0] = false;
    mut[1] = false;
    atomic {
    p1 = run process(0);
    p2 = run process(1)
    }
}

never  {    /* !( []!(p && q) ) */
T0_init:
	do
	:: atomic { ((p && q)) -> assert(!((p && q))) }
	:: (1) -> goto T0_init
	od;
accept_all:
	skip
}
