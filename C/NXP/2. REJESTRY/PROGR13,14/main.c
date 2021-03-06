#include <LPC21xx.H>
#define LED0_bm 0x10000
#define LED1_bm 0x20000
#define LED2_bm 0x40000
#define LED3_bm 0x80000
#define LED_OUT1234ON_bm 0xf0000

int portStan;
int czas;

void LedInit(void)
{
	IO1DIR = LED_OUT1234ON_bm;
	IO1SET = LED0_bm;
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
	for (czas = 0; czas < (2212 * msDelay); czas++)
	{
	}
}

int main()
{
	LedOn(3);
	//LedInit();
	while(1)
	{
		IO1SET =LED0_bm;
		Delay(25);
		IO1CLR =LED0_bm;
		IO1SET =LED1_bm;
		Delay(25);
		IO1CLR =LED1_bm;
		IO1SET =LED2_bm;
		Delay(25);
		IO1CLR =LED2_bm;
		IO1SET =LED3_bm;
		Delay(25);
		IO1CLR =LED3_bm;
		
	}
}
