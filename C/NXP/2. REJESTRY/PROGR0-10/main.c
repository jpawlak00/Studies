#include <LPC21xx.H>
#define LED0_bm 0x10000
#define LED3_bm 0x80000

int portStan;
int czas;
//portStan = IO1PIN;

void Delay(int msDelay)
{
	for (czas = 0; czas < (2212 * msDelay); czas++)
	{
	}
}
//450000
//2399955
int main()
{
	IO1DIR =0x80000;
	while(1)
	{
		IO1SET =LED3_bm;
		Delay(50);
		IO1CLR =LED3_bm;
		Delay(50);
	}
}
