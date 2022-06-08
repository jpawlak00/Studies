#include "led.h"
#include "stepper.h"
#include "keyboard.h"

void Delay(int);

Stepper MyStepper(2);
Keyboard MyKeyboard;

int main()
{
	switch(MyKeyboard.eRead()){
		case BUTTON_4:
			MyStepper.SetMode(1);
			break;
		default: break;
	}
		
	while(1){
		switch(MyKeyboard.eRead()){
			case BUTTON_1:
				MyStepper.StepLeft();
				break;
			case BUTTON_2:
				MyStepper.StepRight();
			break;
			default: break;
		}
	}
}

void Delay(int iTimeInMs){
	int iCycle;
	int iNumberOfCycles = 12000 * iTimeInMs;
	
	for (iCycle = 0; iCycle < iNumberOfCycles; iCycle++) {}
}
