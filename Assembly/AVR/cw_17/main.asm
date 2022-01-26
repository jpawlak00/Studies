/*
 * cw_17 .asm
 *
 *  Created: 10/6/2021 3:43:31 PM
 *   Author: student
 */ 
  
 ldi R22, 3
 rjmp jmp1
 Loop3:
 dec R22
 brbs 1, End1
jmp1: ldi R19, 5
 Loop2:
    nop
    dec R19
    brbs 1, Loop3
    ldi R20, 241
    ldi R21, 2
    rjmp Loop

    Loop1:
        dec R21
        brbs 1, Loop2

            Loop:
                    dec R20       
                    brbs 1, Loop1 
                    rjmp Loop
    End1:nop

