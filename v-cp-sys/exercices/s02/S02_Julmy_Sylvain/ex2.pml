/** 
 * Exercice 2
 * Description : Series S02 of the Verification of Cyber-physical System course at MCS BeNeFri
 * 
 * Modelisation of the Wolf, Sheep and Cabbage problem in Promela
 *
 * Author : Sylvain Julmy
 * Email : sylvain.julmy@unifr.ch
**/

#define IS_FINISHED (!(present[sheep] && present[cabbage] && present[wolf]))
#define IS_BAD_SITUATION ((present[sheep] && present[cabbage] && !present[wolf]) ||\
                         (present[wolf] && present[sheep] && !present[cabbage]))

/*
  The problem's contraints :
    - the sheep and the wolf can't be left alone
    - the sheep and the cabbage can't be left alone
*/
#define SHEEP_AND_CABBAGE (!(present[sheep] && present[cabbage]))
#define WOLF_AND_SHEEP (!(present[wolf] && present[sheep]))

// To simulate the travel of the boat
#define LEFT 6
#define RIGHT 7

byte turn;

mtype = {wolf, sheep, cabbage};

// to send the item from left to right or right to left
// we could have only 1 channel to simulate this but it is more
// visualable with 2
chan leftToRight = [1] of {mtype};
chan rightToLeft = [1] of {mtype};

proctype leftShore() {
    // initialisation of the leftShore
    bool present[4];
    present[wolf] = true;
    present[sheep] = true;
    present[cabbage] = true;

    // Simulate the travelling of the members
    simulation:
    turn == LEFT;

    // receive the wolf, sheep or cabbage non-derministicly if the item could be acquire with a chanel
    if
        :: rightToLeft?wolf -> present[wolf] = true;
        :: rightToLeft?sheep -> present[sheep] = true;
        :: rightToLeft?cabbage -> present[cabbage] = true;
        :: empty(rightToLeft) -> skip;
    fi

    // send the wolf, sheep or cabbage non-derministicly if the item is present and with
    // respect to the problem's constraints
    
    

    if
        :: present[wolf] && SHEEP_AND_CABBAGE -> leftToRight!wolf; present[wolf] = false;

        :: present[sheep] -> leftToRight!sheep; present[sheep] = false;

        :: present[cabbage] && WOLF_AND_SHEEP -> leftToRight!cabbage; present[cabbage] = false;
    fi

    turn = RIGHT;
    goto simulation;
}

proctype rightShore() {
    // initialisation of the rightShore
    bool present[4];
    present[wolf] = false;
    present[sheep] = false;
    present[cabbage] = false;

    // Simulate the travelling of the members
    simulation:
    turn == RIGHT;

    // receive the item from the boat
    if
        :: leftToRight?wolf -> present[wolf] = true;
        :: leftToRight?sheep -> present[sheep] = true;
        :: leftToRight?cabbage -> present[cabbage] = true;
    fi

    // check is the problem is solved
    if
        :: !(IS_BAD_SITUATION) -> assert(IS_FINISHED);
        :: else -> skip;
    fi

    // eventually send an item back with respect to the problem's constraints
    if
        :: present[wolf] && SHEEP_AND_CABBAGE
        -> rightToLeft!wolf; present[wolf] = false;

        :: present[sheep]
        -> rightToLeft!sheep; present[sheep] = false;

        :: present[cabbage] && WOLF_AND_SHEEP
        -> rightToLeft!cabbage; present[cabbage] = false;

        :: (WOLF_AND_SHEEP) && (SHEEP_AND_CABBAGE)
        -> skip;
    fi

    // pass to the other shore simulation
    turn = LEFT;
    goto simulation;
}

init {
    turn = LEFT; atomic{run leftShore(); run rightShore()};
}