#include <LPC21xx.H>
#include "timer.h"

#define CounterEnable (1<<0)
#define CounterReset (1<<1)
#define InterruptOnMR0 (1<<0)
#define ResetOnMR0 (1<<1)


void InitTimer0(void){
	T0TCR = CounterEnable | T0TCR;
}

void WaitOnTimer0(unsigned int uiTime){
	T0TCR = CounterReset | T0TCR;
	T0TCR = ~CounterReset & T0TCR;
	while(T0TC < (15 * uiTime)){} 
}

void InitTimer0Match0(unsigned int iDelayTimer){
	T0MR0 = 15 * iDelayTimer;
	T0MCR = ResetOnMR0 | T0MCR;
	T0MCR = InterruptOnMR0 | T0MCR;
	T0TCR = CounterReset | T0TCR;
	T0TCR = ~CounterReset & T0TCR;
	InitTimer0();	
}
 
void WaitOnTimer0Match0(void){
	while((T0IR & InterruptOnMR0) != 1){}
	T0IR = InterruptOnMR0;
}
