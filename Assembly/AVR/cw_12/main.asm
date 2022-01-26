/*
 * cw_13 .asm
 *
 *  Created: 10/6/2021 3:43:31 PM
 *   Author: student
 */ 

        ldi R20, 5
 Loop:  nop
        dec R20
        brbs 1, 4
        rjmp Loop
        nop
        nop
        nop
