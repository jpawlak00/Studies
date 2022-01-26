 /*
 * cw_42 .asm
 *
 *  Created: 10/6/2021 3:43:31 PM
 *   Author: student
 */ 

/*
Quotient=0
while (Divident>=Divisor) { // for “>” use cp and cpc instructions
Divident = Divident - Divisor;
Quotient++; // use adiw instruction
}
Remainder = Divident

--------------------------------------------------------------------------------------------------------*/
;*** Divide ***
; X/Y -> Quotient,Remainder
; Input/Output: R16-19, Internal R24-25
; inputs

ldi R16, $10//$B0    //XL
ldi R17, $27//$04    //XH

ldi R18, $e8     //YL
ldi R19, $3     //YH

Divide:

    push R24
    push R25

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

/*cp XH, YH
    brne jump
    rjmp SRODEK
    jump: cp XL, YL
    brne endLoop
    SRODEK:
    */

