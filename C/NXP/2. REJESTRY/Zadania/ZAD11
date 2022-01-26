#include <LPC21xx.H>
#define LED0_bm 0x10000
#define LED1_bm 0x20000
#define LED2_bm 0x40000
#define LED3_bm 0x80000
#define LED_OUT1234ON_bm 0xf0000

int portStan;
int czas;

void Delay(int msDelay)
{
	for (czas = 0; czas < (2212 * msDelay); czas++)
	{
	}
}

int main()
{
	IO1DIR =LED_OUT1234ON_bm;
	while(1)
	{
		IO1SET =LED0_bm;
		IO1SET =LED1_bm;
		IO1SET =LED2_bm;
		IO1SET =LED3_bm;
	}
}
