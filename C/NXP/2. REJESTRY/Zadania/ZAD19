#include <LPC21xx.H>
#define LED0_bm 0x10000
#define LED1_bm 0x20000
#define LED2_bm 0x40000
#define LED3_bm 0x80000
#define LED_OUT1234ON_bm 0xf0000
#define BUTTON_OUT1234ON_bm 0xffffff0f
#define BUT0_bm 0x10
#define BUT1_bm 0x40
#define BUT2_bm 0x20
#define BUT3_bm 0x80

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
	IO0DIR = (BUTTON_OUT1234ON_bm & IO0DIR);
}


/*enum ButtonState {RELEASED, PRESSED};
enum ButtonState ReadButton1(){
	if ((IO0PIN & BUT0_bm) == 0){
		return PRESSED;
	}
	else {
		return RELEASED;
	}
}
*/
void LedInit(void)	
{
	IO1DIR = (LED_OUT1234ON_bm | IO1DIR);
	//IO1SET = LED0_bm;
}

void LedOn(unsigned char ucLedIndeks)
{
	if (ucLedIndeks == 0)
	{
		IO1SET = LED0_bm;
	}
	else if (ucLedIndeks == 1)
	{
		IO1SET = LED1_bm;
	}
	else if (ucLedIndeks == 2)
	{
		IO1SET = LED2_bm;
	}
	else if (ucLedIndeks == 3)
	{
		IO1SET = LED3_bm;
	}
}

void Delay(int msDelay)
{
	int czas;
	for (czas = 0; czas < (2212 * msDelay); czas++)
	{
	}
}

int main()
{
	LedInit();
	KeyboardInit();
	while(1)
	switch(eKeyboardRead()){
		case BUTTON_0:
			LedOn(0);
		break;
		case BUTTON_1:
			LedOn(1);
		break;
		case BUTTON_2:
			LedOn(2);
		break;
		case BUTTON_3:
			LedOn(3);
		break;
		case RELEASED:
			LedOn(4);
		break;
	}
}
