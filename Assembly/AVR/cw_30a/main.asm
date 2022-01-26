 /*
 * cw_30b .asm
 *
 *  Created: 10/6/2021 3:43:31 PM
 *   Author: student
 */ 

 .macro LOAD_CONST
ldi @0, high(@2)
ldi @1, low(@2)
.endmacro

LOAD_CONST R17, R16, 250
rcall ENABLE_NR_0

MainLoop:
rcall ENABLE_NR_0
rcall DISP_0
rcall DelayInMs
rcall DISABLE_ALL
 
rcall ENABLE_NR_1
rcall DISP_0
rcall DelayInMs
rcall DISABLE_ALL

rcall ENABLE_NR_2
rcall DISP_0
rcall DelayInMs
rcall DISABLE_ALL

rcall ENABLE_NR_3
rcall DISP_0
rcall DelayInMs
rcall DISABLE_ALL
rjmp MainLoop

DISP_0:
     push R16
     push R17
     push R18
     ldi R16, $3F
     ldi R17, $0
     ldi R18, $7F
     OUT DDRD, R18      //OUTPUT
     OUT PORTD, R16     //STAN WYSOKI NA "0"
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

DISABLE_ALL:
    push R16
    push R17
    ldi R16, $0
    ldi R17, $1E        //0b00011110
    OUT DDRB, R17
    OUT PORTB, R16
    pop R17
    pop R16
    ret

ENABLE_NR_0:
    push R16
    ldi R16, $02         // PORT B - PIN 1 (bo jest pin 0)
    OUT DDRB, R16
    OUT PORTB, R16
    pop R16
    ret

ENABLE_NR_1:
    push R16
    ldi R16, $04         // PIN 2
    OUT DDRB, R16
    OUT PORTB, R16
    pop R16
    ret

ENABLE_NR_2:
    push R16
    ldi R16, $08         // PIN 3
    OUT DDRB, R16
    OUT PORTB, R16
    pop R16
    ret

ENABLE_NR_3:
    push R16
    ldi R16, $10         // PIN 4
    OUT DDRB, R16
    OUT PORTB, R16
    pop R16
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