#include "led.h"
#include "stepper.h"

void Delay(int iTimeInMs){
	int iCycle;
	int iNumberOfCycles = 12000 * iTimeInMs;
	
	for (iCycle = 0; iCycle < iNumberOfCycles; iCycle++) {}
}

Stepper MyStepper;


int main()
{
	while(1){
		Delay(100);
		MyStepper.StepLeft();
	}
}
