 /*
 * cw_35 .asm
 *
 *  Created: 10/6/2021 3:43:31 PM
 *   Author: student
 */ 


.equ DIGITS_P = PORTB
.equ SEGMENTS_P = PORTD

 .macro LOAD_CONST
ldi @0, high(@2)
ldi @1, low(@2)
.endmacro

.def Digit_0 = R2
.def Digit_1 = R3
.def Digit_2 = R4
.def Digit_3 = R5

ldi R16, $3F      // "0"
ldi R17, $06      // "1"
ldi R18, $5B      // "2"
ldi R19, $4F      // "3"

mov Digit_0, R16
mov Digit_1, R17
mov Digit_2, R18
mov Digit_3, R19

clr R16
clr R17
clr R18
clr R19

//podaje wartosc do DelayInMs
LOAD_CONST R17, R16, 5  // 1/50= 0.02 , 0.02/4(ilosc delay)= 0.005 

MainLoop:
rcall ENABLE_NR_0
rcall DIGIT_0_ON
rcall DelayInMs
rcall DISABLE_ALL_DISPLAYS

rcall ENABLE_NR_1
rcall DIGIT_1_ON
rcall DelayInMs
rcall DISABLE_ALL_DISPLAYS

rcall ENABLE_NR_2
rcall DIGIT_2_ON
rcall DelayInMs
rcall DISABLE_ALL_DISPLAYS

rcall ENABLE_NR_3
rcall DIGIT_3_ON
rcall DelayInMs
rcall DISABLE_ALL_DISPLAYS
rjmp MainLoop

DIGIT_0_ON:
     OUT DDRD, Digit_0          //OUTPUT
     OUT PORTD, Digit_0         //STAN WYSOKI NA "0"
     ret

DIGIT_1_ON:
     OUT DDRD, Digit_1          //OUTPUT
     OUT PORTD, Digit_1         //STAN WYSOKI NA "1" 
     ret

DIGIT_2_ON:                     //ABGED 0101 1011 0x05B
     OUT DDRD, Digit_2          //OUTPUT
     OUT PORTD, Digit_2         //STAN WYSOKI NA "2" 
     ret

DIGIT_3_ON:                     //ABCDG 0100 1111 0x8F
     OUT DDRD, Digit_3          //OUTPUT
     OUT PORTD, Digit_3         //STAN WYSOKI NA "3" 
     ret


DISABLE_ALL_DISPLAYS:
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