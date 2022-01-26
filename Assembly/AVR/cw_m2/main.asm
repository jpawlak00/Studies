 /*
 * cw_m2 .asm
 *
 *  Created: 10/6/2021 3:43:31 PM
 *   Author: student
 */ 

 .macro LOAD_CONST
ldi @0, high(@2)
ldi @1, low(@2)
.endmacro


MainLoop:
LOAD_CONST R17, R16, 250
rcall DelayInMs
rjmp MainLoop




DelayOneMs:
        push R24 
        push R25
        //ldi R24, $040 
        //ldi R25, $006
        LOAD_CONST R25, R24, $0640
     
        LoopDOM:
            sbiw R24, 1
            brbs 1, EndDOM
            rjmp LoopDOM   
        EndDOM: 
        pop R25
        pop R24
        ret


DelayInMs:
//push R16 //w sumie nie musze pushowac tych dwoch - brak pracy na nich
//push R17
push R24 //sbiw na tym dziala 
push R25
movw R25:R24, R17:R16
rjmp Jump
    Loop1:
        sbiw R24, 1
        brbs 1, End
   Jump:rcall DelayOneMS
        rjmp Loop1
   End: pop R25
        pop R24
        //pop R17
        //pop R16
        ret

