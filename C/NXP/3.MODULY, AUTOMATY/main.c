#include "led.h"
#include "keyboard.h"

enum eLedState {LED_STEP_LEFT, STOP, LED_STEP_RIGHT, LED_STEP_LEFT5x};
enum eLedState LedState = STOP;
void Delay(int msDelay){
	int czas;
	for (czas = 0; czas < (2212 * msDelay); czas++){}
}

char cCounter = 0;

int main(){
		LedInit();
	while(1){
		switch (LedState){
			case LED_STEP_LEFT5x:
				if (cCounter == 5){
					LedState = LED_STEP_RIGHT;
					cCounter = 0;
				}
				else{
					LedState = LED_STEP_LEFT5x;
					LedStepLeft();
					cCounter++;
				}
				break;
			case LED_STEP_LEFT:
				LedStepLeft();
				if (eKeyboardRead() == BUTTON_1)
					LedState = STOP;
				else if (eKeyboardRead() == BUTTON_3)
					LedState = LED_STEP_LEFT5x;
				else
					LedState = LED_STEP_LEFT;
				break;
			case STOP:
				if (eKeyboardRead() == BUTTON_0)
					LedState = LED_STEP_LEFT;
				else if (eKeyboardRead() == BUTTON_2)
					LedState = LED_STEP_RIGHT;
				else
					LedState = STOP;
				break;
			case LED_STEP_RIGHT:
				if (eKeyboardRead() == BUTTON_1)
					LedState = STOP;
				else
					LedState = LED_STEP_RIGHT;
				LedStepRight();
				break;
		}
		Delay(500);
	}
}
		
		/*switch (LedState){
			case LED_STEP_LEFT:
				LedStepLeft();
			if(cCounter<3){ 
				LedState = LED_STEP_LEFT;}
			else{
				LedState = LED_STEP_RIGHT;}
			break;
			case LED_STEP_RIGHT:
				LedStepRight();
			if(cCounter<3){ 
				LedState = LED_STEP_RIGHT;}
			else{
				LedState = LED_STEP_LEFT;}
			break;}
			cCounter = cCounter %3;
			cCounter++;
		Delay(1000);
	}
}

switch (LedState){
			case LED_LEFT0:
				LedState = LED_LEFT1;
			LedStepRight();
			break;
			case LED_LEFT1:
				LedState = LED_LEFT2;
			LedStepRight();
			break;
			case LED_LEFT2:
				LedState = LED_RIGHT0;
			LedStepRight();
			break;
			case LED_RIGHT0:
				LedState = LED_RIGHT1;
			LedStepLeft();
			break;
			case LED_RIGHT1:
				LedState = LED_RIGHT2;
			LedStepLeft();
			break;
			case LED_RIGHT2:
				LedState = LED_LEFT0;
			LedStepLeft();
			break;
		}
		Delay(500);*/

