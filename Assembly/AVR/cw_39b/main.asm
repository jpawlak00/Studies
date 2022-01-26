 /*
 * cw_39b .asm
 *
 *  Created: 10/6/2021 3:43:31 PM
 *   Author: student
 */ 

.def Digit_0 = R2
.def Digit_1 = R3
.def Digit_2 = R4
.def Digit_3 = R5

.equ DIGITS_P = PORTB
.equ SEGMENTS_P = PORTD

.macro LOAD_CONST
ldi @0, high(@2)
ldi @1, low(@2)
.endmacro

.macro SET_DIGIT
push R18
ldi R18, @0
dec R18
brbs 2, SCREEN_0 
dec R18
brbs 2, SCREEN_1
dec R18
brbs 2, SCREEN_2
dec R18
brbs 2, SCREEN_3    //estetyka :)

SCREEN_3: 
    rcall ENABLE_NR_3
    rcall DIGIT_3_ON
    rcall DelayInMs             //uzywa R16 i R17!!!
    rcall DISABLE_ALL_DISPLAYS
    rjmp End

SCREEN_2:
    rcall ENABLE_NR_2
    rcall DIGIT_2_ON
    rcall DelayInMs
    rcall DISABLE_ALL_DISPLAYS
    rjmp End

SCREEN_1:
    rcall ENABLE_NR_1
    rcall DIGIT_1_ON
    rcall DelayInMs
    rcall DISABLE_ALL_DISPLAYS
    rjmp End

SCREEN_0:
    rcall ENABLE_NR_0
    rcall DIGIT_0_ON
    rcall DelayInMs
    rcall DISABLE_ALL_DISPLAYS

End:
pop R18
.endmacro

//WYBIERAM CYFRY
ldi R16, 8      
mov Digit_0, R16

ldi R16, 0      
mov Digit_1, R16

ldi R16, 0      
mov Digit_2, R16

ldi R16, 8      
mov Digit_3, R16

//podaje wartosc do DelayInMs
LOAD_CONST R17, R16, 5

MainLoop:
SET_DIGIT 0
SET_DIGIT 1
SET_DIGIT 2
SET_DIGIT 3
rjmp MainLoop


DigitTo7segCode:
    push R30
    push R31
    ldi R30, low(Table << 1)  
    ldi R31, high(Table << 1)
    add R30, R16
    lpm R16, Z
    pop R30
    pop R31
ret
 


Table: .db $3F, $06, $5B, $4F, $66, $6D, $7D, $07, $7F, $6F

// FUNKCJE USTAWIAJACE CYFRY

DIGIT_0_ON:
     push R16
     clr R16
     add R16, Digit_0
     rcall DigitTo7segCode
     OUT DDRD, R16         
     OUT PORTD, R16         
     pop R16
     ret

DIGIT_1_ON:
     push R16
     clr R16
     add R16, Digit_1
     rcall DigitTo7segCode
     OUT DDRD, R16          
     OUT PORTD, R16         
     pop R16
     ret

DIGIT_2_ON:
     push R16
     clr R16
     add R16, Digit_2
     rcall DigitTo7segCode
     OUT DDRD, R16          
     OUT PORTD, R16         
     pop R16
     ret

DIGIT_3_ON:                     
     push R16
     clr R16
     add R16, Digit_3
     rcall DigitTo7segCode
     OUT DDRD, R16         
     OUT PORTD, R16        
     pop R16 
     ret

//FUNKCJE WLACZAJACE SEGMENTY

DISABLE_ALL_DISPLAYS:
    push R16
    push R17
    ldi R16, $0
    ldi R17, $1E        
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