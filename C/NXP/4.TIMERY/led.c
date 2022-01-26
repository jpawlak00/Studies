#include <LPC21xx.H>
#include "led.h"

#define LED0_bm (1<<16)
#define LED1_bm (1<<17)
#define LED2_bm (1<<18)
#define LED3_bm (1<<19)


void LedInit(void)	
{
	IO1DIR = (LED0_bm | LED1_bm | LED2_bm | LED3_bm | IO1DIR);
	IO1SET = LED0_bm;
}

void LedOn(unsigned char ucLedIndeks){
	IO1CLR = (LED0_bm | LED1_bm | LED2_bm | LED3_bm);
	if (ucLedIndeks == 0)
		IO1SET = LED0_bm;
	else if (ucLedIndeks == 1)
		IO1SET = LED1_bm;
	else if (ucLedIndeks == 2)
		IO1SET = LED2_bm;
	else if (ucLedIndeks == 3)
		IO1SET = LED3_bm;
}

enum Direction {LEFT, RIGHT};	
void LedStep(enum Direction eDirection){
	static unsigned int uiCounter;
	if (eDirection == LEFT)
		uiCounter++;
	else if (eDirection == RIGHT){
		uiCounter--;
	}
	uiCounter = uiCounter %4;
	LedOn(uiCounter);
}

void LedStepLeft(void){
	LedStep(LEFT);
}

void LedStepRight(void){
	LedStep(RIGHT);
}
