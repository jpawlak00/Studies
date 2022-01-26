/*
 * cw_22 .asm
 *
 *  Created: 10/6/2021 3:43:31 PM
 *   Author: student
 */ 

MainLoop:
ldi R22, 3
rcall DelayInMs
rjmp MainLoop

DelayInMs:
  rjmp init
  Loop1:
        dec R22
        brbs 1, End
   init:ldi R24, $040 
        ldi R25, $006 // 0x640 hex to 1,6K, 1600 *5 cykli w petli = 8k cykli, 1 cykl 1uS
        Loop:
                sbiw R24, 1
                brbs 1, Loop1
                rjmp Loop
   End: ret










  
 



