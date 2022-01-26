/*
 * cw_24 .asm
 *
 *  Created: 10/6/2021 3:43:31 PM
 *   Author: student
 */ 


// R24 modyfikuje funkcja wewnetrzna

MainLoop:
ldi R24, 1
rcall DelayInMs
rjmp MainLoop


DelayOneMs:
        ldi R24, $040 
        ldi R25, $006 
        LoopDOM:
            sbiw R24, 1
            brbs 1, EndDOM
            rjmp LoopDOM   
        EndDOM: ret


DelayInMs: 
rjmp Jump
  Loop1:
        dec R24
        brbs 1, End
   Jump:rcall DelayOneMS
        rjmp Loop1
   End: ret











  
 



