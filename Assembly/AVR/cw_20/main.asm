/*
 * cw_20 .asm
 *
 *  Created: 10/6/2021 3:43:31 PM
 *   Author: student
 */ 

MainLoop:
rcall DelayNCycles
rjmp MainLoop

DelayNCycles:
nop
nop     
nop
ret

//czas: 1,50 uS, 12 cykli




