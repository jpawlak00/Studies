#ifndef STEPPER_H
#define STEPPER_H

#include "ledinv.h"

class Stepper
{
	public:
		//Stepper(unsigned char = 0);
		void SetLed(Led *pLed);
		void StepLeft(void);
		void StepRight(void);
	private:
		Led *pMyLed;
		unsigned char ucLedCtr;
		void Step(enum Step);
};

#endif
