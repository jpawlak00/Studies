#include "stepper.h"

enum Step{LEFT,RIGHT};

void Stepper :: SetLed(Led *pLed){
	pMyLed = pLed;
}

void Stepper :: Step(enum Step eStep){
	if(eStep == LEFT){
		ucLedCtr--;
		ucLedCtr = ucLedCtr % 4;
		pMyLed->On(ucLedCtr);
	}
	else if(eStep == RIGHT){
		ucLedCtr++;
		ucLedCtr = ucLedCtr % 4;
		pMyLed->On(ucLedCtr);
	}else{
	}
}

void Stepper :: StepLeft(void){
	Step(LEFT);
}

void Stepper :: StepRight(void){
	Step(RIGHT);
}
