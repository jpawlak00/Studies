/*
 * cw_13 .asm
 *
 *  Created: 10/6/2021 3:43:31 PM
 *   Author: student
 */ 



Loop1:
        ldi R20, 10
        Loop:
                nop
                dec R20
                brbs 1, 6
                rjmp Loop
        nop
        rjmp Loop1
        
   







/*


        ldi R20, 10
 Loop:  nop
        dec R20
        brbs 1, 4 
        rjmp Loop
        nop
        nop
        nop
        // Cykle na wykonanie kodu w petli: (R20*5) + 1
*/