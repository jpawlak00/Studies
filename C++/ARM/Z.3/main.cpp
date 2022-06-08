#include "led.h"
#include "stepper.h"

void Delay(int iTimeInMs){
	int iCycle;
	int iNumberOfCycles = 12000 * iTimeInMs;
	
	for (iCycle = 0; iCycle < iNumberOfCycles; iCycle++) {}
}
Led MyLed;

int main()
{
	Stepper MyStepper;
	MyLed.Init();

	while(1){
		Delay(100);
		MyStepper.StepLeft();
	}
}
