#include "led.h"
#include "stepper.h"
#include "keyboard.h"

void Delay(int iTimeInMs){
	int iCycle;
	int iNumberOfCycles = 12000 * iTimeInMs;
	
	for (iCycle = 0; iCycle < iNumberOfCycles; iCycle++) {}
}

Stepper MyStepper;
Keyboard MyKeyboard;

int main()
{
	while(1){
		//Delay(500);
		//if(MyKeyboard.eRead == BUTTON_1)
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
