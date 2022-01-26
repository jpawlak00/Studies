/*
 * cw_18 .asm
 *
 *  Created: 10/6/2021 3:43:31 PM
 *   Author: student
 */ 
 ldi R22, 10

 ldi R27, 1
 inc R22
 Loop1:   dec R22
          brbs 1, End                      
          ldi R25, 54    // od 0 jest 219 cykli za duzo przy F8 w R26, 4 cykle w malej petli; 220/4= 55; czyli 54 bo jedziemy od 0
          ldi R26, $F8   //skracam licznik, nominalnie 256*256 = 65536

        Loop:
                add R25, R27 
                brbs 1, jump
                rjmp Loop
                jump: adc R26, R25
                brbs 1, Loop1
                rjmp Loop
End: nop


