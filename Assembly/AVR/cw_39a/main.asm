 /*
 * cw_39a .asm
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

ldi R16, 9      // "0"
mov Digit_0, R16
clr R16

ldi R16, 8      // "0"
mov Digit_1, R16
clr R16

ldi R16, 7      // "0"
mov Digit_2, R16
clr R16

ldi R16, 6      // "0"
mov Digit_3, R16
clr R16

/*ldi R17, $06      // "1"
ldi R18, $5B      // "2"
ldi R19, $4F      // "3"


mov Digit_1, R17
mov Digit_2, R18
mov Digit_3, R19


clr R17
clr R18
clr R19
*/

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


DigitTo7segCode:
    push R30
    push R31
    ldi R30, low(Table << 1)    //inicjalizacja rejestru Z, << mnozenie x2
    ldi R31, high(Table << 1)
    add R30, R16
    lpm R16, Z
    pop R30
    pop R31
ret
 


Table: .db $3F, $06, $5B, $4F, $66, $6D, $7D, $07, $7F, $6F

/*
0 - 0x3F
1 - 0x06
2 - 0x5B
3 - 0x4F
4 - FGBC    0110 0110 0x66
5 - AFGCD   0110 1101 0x6D
6 - AFGEDC  0111 1101 0x7D
7 - ABC     0000 0111 0x07
8 - ABCDEFG 0111 1111 0x7F
9 - ABCDFG  0110 1111 0x6F
*/

DIGIT_0_ON:
     push R16
     clr R16
     add R16, Digit_0
     rcall DigitTo7segCode
     OUT DDRD, R16          //OUTPUT
     OUT PORTD, R16         //STAN WYSOKI NA "0"
     pop R16
     ret

DIGIT_1_ON:
     push R16
     clr R16
     add R16, Digit_1
     rcall DigitTo7segCode
     OUT DDRD, R16          //OUTPUT
     OUT PORTD, R16         //STAN WYSOKI NA "1" 
     pop R16
     ret

DIGIT_2_ON:
     push R16
     clr R16
     add R16, Digit_2
     rcall DigitTo7segCode
     OUT DDRD, R16          //OUTPUT
     OUT PORTD, R16         //STAN WYSOKI NA "2" 
     pop R16
     ret

DIGIT_3_ON:                     
     push R16
     clr R16
     add R16, Digit_3
     rcall DigitTo7segCode
     OUT DDRD, R16         //OUTPUT
     OUT PORTD, R16        //STAN WYSOKI NA "3"
     pop R16 
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