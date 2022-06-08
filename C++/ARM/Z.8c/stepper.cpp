#include "stepper.h"

enum Step{LEFT,RIGHT};

extern unsigned char ucInversion;

Stepper :: Stepper(unsigned char ucPosition){
	MyLed.On(ucPosition);
}

void Stepper :: Step(enum Step eStep){
	if(eStep == LEFT){
		ucLedCtr--;
		ucLedCtr = ucLedCtr % 4;
	}
	else if(eStep == RIGHT){
		ucLedCtr++;
		ucLedCtr = ucLedCtr % 4;
	}else{
	}
	if(ucInversion == 0){
		MyLed.On(ucLedCtr);
	}
	else{
		MyLedInv.On(ucLedCtr);			
	}
}

void Stepper :: StepLeft(void){
	Step(LEFT);
}

void Stepper :: StepRight(void){
	Step(RIGHT);
}
