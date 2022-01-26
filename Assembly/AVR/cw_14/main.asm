/*
 * cw_14 .asm
 *
 *  Created: 10/6/2021 3:43:31 PM
 *   Author: student
 */ 


ldi R20, 244
ldi R21, 2
rjmp Loop
Loop1:
    dec R21
    brbs 1, End

        Loop:
                dec R20
                nop
                brbs 1, Loop1
                rjmp Loop
        rjmp Loop1
End: