/*
 * cw_45 .asm
 *
 *  Created: 10/6/2021 3:43:31 PM
 *   Author: student
 */

.def XL=R16  //divident //divide input
.def XH=R17
.def YL=R18  //divisor
.def YH=R19
.def QCtrL=R24  //internal
.def QCtrH=R25
.def RL=R16  //remainder //divide output
.def RH=R17
.def QL=R18  //quotient
.def QH=R19
.def Digit_0 = R2
.def Digit_1 = R3
.def Digit_2 = R4
.def Digit_3 = R5
.def PulseEdgeCtrL=R0 
.def PulseEdgeCtrH=R1
.equ DIGITS_P = PORTB
.equ SEGMENTS_P = PORTD

.macro LOAD_CONST
ldi @0, high(@2)
ldi @1, low(@2)
.endmacro

.macro SET_DIGIT //ENABLE SCREEN, DIGIT ON
push R16
ldi R16, $2 << @0
OUT DDRB, R16
OUT Digits_P, R16
mov R16, Digit_@0
rcall DigitTo7segCode
OUT DDRD, R16
OUT Segments_P, R16
pop R16
rcall DelayInMs
.endmacro

.cseg                               ; segment pami?ci kodu programu
.org 0          rjmp _main          ; skok po resecie (do programu g??wnego)
.org OC1Aaddr   rjmp timer_isr     ; skok do obs?ugi przerwania timera
timer_isr:                         ; procedura obs?ugi przerwania timera
            inc R0                  ; jaki? kod
            reti                    ; powr?t z procedury obs?ugi przerwania (reti zamiast ret)
_main:
ldi R16, 1
mov R10, R16
clr R11

MainLoop:

SET_DIGIT 0
SET_DIGIT 1
SET_DIGIT 2
SET_DIGIT 3

movw XH:XL, PulseEdgeCtrH:PulseEdgeCtrL
ldi YL, low(10000)
ldi YH, high(10000)
rcall Divide
rcall NumberToDigits
add PulseEdgeCtrL, R10
adc PulseEdgeCtrH, R11

mov Digit_0, R16
mov Digit_1, R17
mov Digit_2, R18
mov Digit_3, R19



rjmp MainLoop


DigitTo7segCode:
    //input: cyfra w R16
    //output: kod cyfry w 7seg w R16 
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

DelayInMs:
//input: ilosc ms w R17:R16 //edit: podaje to od razu do funkcji 
    push R24 
    push R25
    LOAD_CONST R25, R24, 1
    //movw R25:R24, R17:R16
    rjmp Jump
        Loop1:
            sbiw R24, 1
            brbs 1, End
       Jump:rcall DelayOneMS
            rjmp Loop1
        End:pop R25
            pop R24
ret

NumberToDigits:
    //input: liczba w R16, R17
    //output: cyfry liczby w R16, R17, R18, R19
    push R22
    push R23
    push R24
    push R25
    //internals
    .def Dig0=R22 //Digits temps
    .def Dig1=R23 
    .def Dig2=R24 
    .def Dig3=R25 

    ldi R18, low(1000)
    ldi R19, high(1000) 
    rcall Divide
    mov Dig0, R18
    // X <- R po dzieleniu remainder jest w R16, automatycznie jest argumentem nastepnego divide
    ldi R18, 100
    ldi R19, 0
    rcall Divide
    mov Dig1, R18

    ldi R18, 10
    ldi R19, 0
    rcall Divide
    mov Dig2, R18

    mov Dig3, RL
    
    mov R16, R22 //Digit1 do R16 z temp R22
    mov R17, R23
    mov R18, R24
    mov R19, R25
    
    pop R25
    pop R24
    pop R23
    pop R22    
ret

Divide:
    //input: divident: R16, R17 / divisor: R18,R19
    //output: remainder: R16, R17 / quotient: R18, R19
    push R24
    push R25


    ldi QCtrL, 0
    ldi QCtrH, 0
    Loop:
        cp XL, YL    
        cpc XH, YH         
        brbs 0, endLoop
        SRODEK:
        sub XL, YL
        sbc XH, YH
        adiw QCtrH:QCtrL, 1
        rjmp Loop
        endLoop:
    mov QH, QCtrH
    mov QL, QCtrL
    pop R25
    pop R24
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