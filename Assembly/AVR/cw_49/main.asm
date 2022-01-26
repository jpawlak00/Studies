/*
 * MIERNIK CZESTOTLIWOSCI
 * cw_49 .asm 
 *
 *  Created: 10/6/2021 3:43:31 PM
 *   Author: student
 */

.include "tn2313Adef.inc"
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

.cseg                               ; segment pamiêci kodu programu
.org 0          rjmp _main          ; skok po resecie (do programu g³ównego)
//.org 0x0001     rjmp _INT0_isr    ; external interrupt request
.org OC1Aaddr   rjmp _timer_isr     ; skok do obs³ugi przerwania timera
.org 0x000B     rjmp _INT0_isr      ; external interrupt request

_INT0_isr:
       cli
       push R12
       in R12, SREG
       add PulseEdgeCtrL, R10
       adc PulseEdgeCtrH, R11
       out SREG, R12
       pop R12
       /*
       // DISABLE THIS INTERRUPT
       push R17
       ldi R17, $0
       out PCMSK0, R17
       pop R17*/

       sei
       reti


_timer_isr:                         ; procedura obs³ugi przerwania timera
            cli
            push R12
            in R12, SREG
            push R16
            push R17
            push R18
            push R19

            movw XH:XL, PulseEdgeCtrH:PulseEdgeCtrL
            ldi YL, low(10000)
            ldi YH, high(10000)
            rcall NumberToDigits
            mov Digit_0, R16
            mov Digit_1, R17
            mov Digit_2, R18
            mov Digit_3, R19
            pop R19
            pop R18
            pop R17
            pop R16
            //DISABLE tamten INTERRUPT
            push R17
            ldi R17, $0
            //out PCMSK0, R17
            clr PulseEdgeCtrL
            clr PulseEdgeCtrH
            pop R17
            out SREG, R12
            pop R12 
            sei
            reti                    ; powrót z procedury obs³ugi przerwania (reti zamiast ret)

_main:
sei                 //global interrupts enable, flag I in SREG

//INT0 interrupt
push R17
ldi R17, $20        
out GIMSK, R17       //GIMSK BIT 6 external interrupt is enabled 0x40               // 5, pin change interrupt 0 is enabled 0x20 
ldi R17, $01
out PCMSK0, R17     //pin 0 (PB0/ INT0) change interrupt enable
ldi R17, $03        
//out MCUCR, R17      //interrupt enabled on rising edge
pop R17
push R17
ldi R17, $00
out TCCR1A, R17

ldi R17, $0C         
out TCCR1B, R17     //3 bit ustawia prescaler na 256(CS12), 4 bit ustawia tryb CTC(WGM12) //TOP OCR1A. str. 113
ldi R17, $3d          //7A                     
out OCR1AH, R17     // porownanie timera z rejestrem 0CR1A. ustawiam liczbe OCR1A, jak timer do niej dojdzie to zapali flage."a match can be used to generate an output compare interrupt"
ldi R17, $09          //12        // bo preskaler             
out OCR1AL, R17
ldi R17, $40
out TIMSK, R17      // TIMER INTERRUPT MASK REGISTER bit 6 OCIE1A, timer1, output compare a match interrupt enable
pop R17             //a match interrupt is enabled. the corresponding interrupt vectore is executed when the OCF1A flag in TIFR is set.

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

ldi R16, 1
mov R10, R16
clr R11
MainLoop:
SET_DIGIT 0
SET_DIGIT 1
SET_DIGIT 2
SET_DIGIT 3
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