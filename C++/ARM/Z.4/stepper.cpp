#include "led.h"
#include "stepper.h"

enum Step{LEFT,RIGHT};
extern Led MyLed;

void Stepper :: Step(enum Step eStep){
	if(eStep == LEFT){
		ucLedCtr--;
		ucLedCtr = ucLedCtr % 4;
		MyLed.On(ucLedCtr);
	}
	else if(eStep == RIGHT){
		ucLedCtr++;
		ucLedCtr = ucLedCtr % 4;
		MyLed.On(ucLedCtr);
	}else{
	}
}

void Stepper :: StepLeft(void){
	Step(LEFT);
}

void Stepper :: StepRight(void){
	Step(RIGHT);
}
