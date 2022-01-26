/*
 * cw_25 .asm
 *
 *  Created: 10/6/2021 3:43:31 PM
 *   Author: student
 */ 

MainLoop:
ldi R24, 5
rcall DelayInMs
rjmp MainLoop


DelayOneMs:
        sts $060, R24 //przetrzymuje dane z rejestru w pamieci
        ldi R24, $040 
        ldi R25, $006 
     
        LoopDOM:
            sbiw R24, 1
            brbs 1, EndDOM
            rjmp LoopDOM   
        EndDOM: 
        lds R24, $060 //zwalnia dane
        ret


DelayInMs: 
rjmp Jump
  Loop1:
        dec R24
        brbs 1, End
   Jump:rcall DelayOneMS
        rjmp Loop1
   End: ret












  
 



