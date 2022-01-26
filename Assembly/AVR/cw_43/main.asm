 /*
 * cw_43 .asm
 *
 *  Created: 10/6/2021 3:43:31 PM
 *   Author: student
 */ 
 
    ; inputs
    .def XL=R16 ; divident
    .def XH=R17

    .def YL=R18 ; divisor
    .def YH=R19

    ; outputs

    .def RL=R16 ; remainder
    .def RH=R17

    .def QL=R18 ; quotient
    .def QH=R19

    ; internal

    .def QCtrL=R24
    .def QCtrH=R25

    
    ;*** NumberToDigits ***
    ;input : Number: R16-17
    ;output: Digits: R16-19
    ;internals: X_R,Y_R,Q_R,R_R - see _Divide
    ; internals
    .def Dig0=R22 ; Digits temps
    .def Dig1=R23 ;
    .def Dig2=R24 ;
    .def Dig3=R25 ;


ldi XL, low(6052)
ldi XH, high(6052)

NumberToDigits:
    push XL
    push XH
    push QL
    ldi YL, low(1000)
    ldi YH, high(1000) 
    rcall Divide
    mov DIG0, QL

    mov XL, RL
    mov XH, RH
    ldi YL, 100
    rcall Divide
    mov DIG1, QL

    mov XL, RL
    mov XH, RH
    ldi YL, 10
    rcall Divide
    mov DIG2, QL

    mov DIG3, RL

    pop QL
    pop XH
    pop XL
ret


Divide:
    push R24
    push R25

    ldi QCtrL, 0
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

