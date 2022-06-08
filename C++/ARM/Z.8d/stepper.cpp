#include "stepper.h"

enum Step{LEFT,RIGHT};

Stepper :: Stepper(unsigned char ucPosition){
	MyLed.On(ucPosition);
}

void Stepper :: SetMode(unsigned char ucMode){
	ucInversion = ucMode;
}

void Stepper :: Step(enum Step eStep){
	if(eStep == LEFT){
		ucLedCtr--;
		ucLedCtr = ucLedCtr % 4;
		if(ucInversion == 0){
			MyLed.On(ucLedCtr);
		}
		else{
			MyLedInv.On(ucLedCtr);			
		}
			
	}
	else if(eStep == RIGHT){
		ucLedCtr++;
		ucLedCtr = ucLedCtr % 4;
		if(ucInversion == 0){
			MyLed.On(ucLedCtr);
		}
		else{
			MyLedInv.On(ucLedCtr);			
		}
	}else{
	}
}

void Stepper :: StepLeft(void){
	Step(LEFT);
}

void Stepper :: StepRight(void){
	Step(RIGHT);
}
