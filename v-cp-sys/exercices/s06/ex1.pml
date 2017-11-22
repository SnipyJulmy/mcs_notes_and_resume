byte x=0;
byte y=0;

active proctype A_x(){
         do
         :: x = x+1;
	       od
       }

active proctype A_y(){
	do
	:: (x%2 == 0) -> y = y+1;
	od
	}

