#include "led.h"
#include "stepper.h"


enum LedState {STEP_LEFT, STEP_RIGHT, LED_STOP};
enum Step{LEFT,RIGHT};

void Stepper :: Step(enum Step eStep){
	if(eStep == LEFT){
		ucLedCtr--;
		ucLedCtr = ucLedCtr % 4;
		Led :: On(ucLedCtr);
	}
	else if(eStep == RIGHT){
		ucLedCtr++;
		ucLedCtr = ucLedCtr % 4;
		Led :: On(ucLedCtr);
	}else{
	}
}

void Stepper :: StepLeft(void){
	Step(LEFT);
}

void Stepper :: StepRight(void){
	Step(RIGHT);
}
