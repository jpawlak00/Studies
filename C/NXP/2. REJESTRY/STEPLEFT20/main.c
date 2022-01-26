#include <LPC21xx.H>

#define LED0_bm 0x10000
#define LED1_bm 0x20000
#define LED2_bm 0x40000
#define LED3_bm 0x80000

#define BUT0_bm 0x10
#define BUT1_bm 0x40
#define BUT2_bm 0x20
#define BUT3_bm 0x80

void LedInit(void)	
{
	IO1DIR = (LED0_bm | LED1_bm | LED2_bm | LED3_bm) | IO1DIR;
	IO1SET = LED0_bm;
}

enum KeyboardState {RELEASED, BUTTON_0, BUTTON_1, BUTTON_2, BUTTON_3};
enum KeyboardState eKeyboardRead(void){
	if ((IO0PIN & BUT0_bm) == 0)
		return BUTTON_0;
	else if ((IO0PIN & BUT1_bm) == 0)
		return BUTTON_1;
	else if ((IO0PIN & BUT2_bm) == 0)
		return BUTTON_2;
	else if ((IO0PIN & BUT3_bm) == 0)
		return BUTTON_3;
	else 
		return RELEASED;		
}

void KeyboardInit(void){
	IO0DIR = ~(BUT0_bm | BUT1_bm | BUT2_bm | BUT3_bm) & IO0DIR;
}


void LedOn(unsigned char ucLedIndeks){
	switch (ucLedIndeks){
	case 0:
		IO1SET = LED0_bm;
		break; 
	case 1:
		IO1SET = LED1_bm;
		break;
	case 2:
		IO1SET = LED2_bm;
		break;
	case 3:
		IO1SET = LED3_bm;
		break;
}
}


void Delay(int msDelay){
	int czas;
	for (czas = 0; czas < (2212 * msDelay); czas++){}
}

enum eDirection {LEFT, RIGHT};	
void LedStep(eDirection){
	static unsigned int uiCounter;
	if (eDirection == LEFT)
		uiCounter--;
	else if (eDirection == RIGHT){
		uiCounter++;
	}
	uiCounter = uiCounter %4;
	IO1CLR = (LED0_bm | LED1_bm | LED2_bm | LED3_bm);
	LedOn(uiCounter);
}

void LedStepLeft(void){
	LedStep(LEFT);
}

void LedStepRight(void){
	LedStep(RIGHT);
}

int main(){
	LedInit();
	KeyboardInit();
	while(1){
	switch (eKeyboardRead()){
		case BUTTON_1:
			LedStepRight();
		break;
		case BUTTON_2:
			LedStepLeft();
		break;
		default: break;
	}
		
		Delay(100);
	}
}
