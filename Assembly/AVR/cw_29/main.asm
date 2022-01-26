 /*
 * cw_29 .asm
 *
 *  Created: 10/6/2021 3:43:31 PM
 *   Author: student
 */ 

 // "1" - 0b0000110 BC
 // "0" - 0b0111111 ABCDEF

 .macro LOAD_CONST
ldi @0, high(@2)
ldi @1, low(@2)
.endmacro

LOAD_CONST R17, R16, 250
rcall ENABLE_NR_0

MainLoop:
rcall DISP_1
rcall DelayInMs
rcall DISP_0
rcall DelayInMs
rjmp MainLoop

DISP_0:
     push R16
     push R17
     push R18
     ldi R16, $3F
     ldi R17, $0
     ldi R18, $7F
     OUT DDRD, R18      //OUTPUT
     OUT PORTD, R16     //STAN WYSOKI NA "1"
     pop R18
     pop R17
     pop R16
     ret

 DISP_1:
     push R16
     push R17
     push R18
     ldi R16, $06
     ldi R17, $0
     ldi R18, $7F
     OUT DDRD, R18      //OUTPUT
     OUT PORTD, R16     //STAN WYSOKI NA "1" 
     pop R18
     pop R17
     pop R16
     ret

ENABLE_NR_0:
    ldi R30, $02         // PIN 1
    OUT DDRB, R30
    OUT PORTB, R30
    ret

DelayOneMs:
        push R24 
        push R25
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
    push R24 
    push R25
    movw R25:R24, R17:R16
    rjmp Jump
        Loop1:
            sbiw R24, 1
            brbs 1, End
       Jump:rcall DelayOneMS
            rjmp Loop1
        End:pop R25
            pop R24
            ret