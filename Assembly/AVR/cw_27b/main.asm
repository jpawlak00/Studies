 /*
 * cw_27b .asm
 *
 *  Created: 10/6/2021 3:43:31 PM
 *   Author: student
 */ 

MainLoop:
ldi R16, 7
ldi R17, 1
rcall DelayInMs
rjmp MainLoop


DelayOneMs:
        push R24 
        push R25
        ldi R24, $040 
        ldi R25, $006 
     
        LoopDOM:
            sbiw R24, 1
            brbs 1, EndDOM
            rjmp LoopDOM   
        EndDOM: 
        pop R25
        pop R24
        ret


DelayInMs:
push R24 //sbiw na tym dziala 
push R25
mov R24, R16
mov R25, R17
rjmp Jump
  Loop1:
        sbiw R24, 1
        brbs 1, End
   Jump:rcall DelayOneMS
        rjmp Loop1
   End: pop R25
        pop R24
        ret
