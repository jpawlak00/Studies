 ;### MACROS & defs (.equ)###

; Macro LOAD_CONST loads given registers with immediate value, example: LOAD_CONST  R16,R17 1234 
.MACRO LOAD_CONST  
 ; TBD
 ldi @0, high(@2)
 ldi @1, low(@2)
.ENDMACRO 

/*** Display ***/
.equ DigitsPort = PORTB            ; TBD
.equ SegmentsPort = PORTD          ; TBD
.equ DisplayRefreshPeriod = 5  ; TBD

; SET_DIGIT diplay digit of a number given in macro argument, example: SET_DIGIT 2
.MACRO SET_DIGIT 
push R16
ldi R16, $2 << @0
out DDRB, R16
out DigitsPort, R16
mov R16, Dig_@0
rcall DigitTo7segCode
out DDRD, R16
out SegmentsPort, R16
pop R16 
rcall DelayInMs
 ; TBD

.ENDMACRO 

; ### GLOBAL VARIABLES ###

.def PulseEdgeCtrL=R0
.def PulseEdgeCtrH=R1

.def Dig_0=R2
.def Dig_1=R3
.def Dig_2=R4
.def Dig_3=R5

; ### INTERRUPT VECTORS ###
.cseg		     ; segment pami�ci kodu programu 

.org	 0      rjmp	_main	 ; skok do programu g��wnego
.org OC1Aaddr	rjmp  _Timer_ISR; TBD
.org PCIBaddr   rjmp  _ExtInt_ISR; TBD ; skok do procedury obs�ugi przerwania zenetrznego 

; ### INTERRUPT SEERVICE ROUTINES ###

_ExtInt_ISR: 	 ; procedura obs�ugi przerwania zewnetrznego

 ; TBD
 cli
 push R16
 push R12
 in R12, SREG
 ldi R16, 1
 mov R10, R16
 clr R11
 add PulseEdgeCtrL, R10
 adc PulseEdgeCtrH, R11
 pop R12
 out SREG, R12
 pop R16
 sei

reti   ; powr�t z procedury obs�ugi przerwania (reti zamiast ret)      

_Timer_ISR:
    push R16
    push R17
    push R18
    push R19
    push R12
    in R12, SREG
    ; TBD
    cli
    movw R17:R16, PulseEdgeCtrH:PulseEdgeCtrL
    LOAD_CONST R19, R18, 10000
    //rcall _Divide   //! 
    rcall _NumberToDigits
    pop R12
    out SREG, R12
	pop R19
    pop R18
    pop R17
    pop R16
    sei
  reti

; ### MAIN PROGAM ###

_main: 
    ; *** Initialisations ***

    ;--- Ext. ints --- PB0
    push R17
    ldi R17, 32
    out GIMSK, R17
    ldi R17, 1
    out PCMSK0, R17
    ; TBD

	;--- Timer1 --- CTC with 256 prescaller
    ; TBD
    ldi R17, $3d 
    out OCR1AH, R17
    ldi R17, $09
    out OCR1AL, R17
    ldi R17, $0c
    out TCCR1B, R17
    ldi R17, $40
    out TIMSK, R17
			
	;---  Display  --- 

	; --- enable gloabl interrupts
    ; TBD
    sei

MainLoop:   ; presents Digit0-3 variables on a Display
			SET_DIGIT 0
			SET_DIGIT 1
			SET_DIGIT 2
			SET_DIGIT 3

			RJMP MainLoop

; ### SUBROUTINES ###

;*** NumberToDigits ***
;converts number to coresponding digits
;input/otput: R16-17/R16-19
;internals: X_R,Y_R,Q_R,R_R - see _Divider

; internals
.def Dig0=R22 ; Digits temps
.def Dig1=R23 ; 
.def Dig2=R24 ; 
.def Dig3=R25 ; 

_NumberToDigits:

	push Dig0
	push Dig1
	push Dig2
	push Dig3

	; thousands 
    ; TBD
    ldi R18, low(1000)

    rcall _Divide
    mov Dig0, R18
	; hundreads 
    ; TBD     
    LOAD_CONST R19,R18, 100
    rcall _Divide
    mov Dig1, R18
	; tens 
    ; TBD    
    LOAD_CONST R19,R18, 10
    rcall _Divide
    mov Dig2, R18
	; ones 
    mov Dig3, R16
    ; TBD

	; otput result
	mov R16,Dig0
	mov R17,Dig1
	mov R18,Dig2
	mov R19,Dig3

	pop Dig3
	pop Dig2
	pop Dig1
	pop Dig0

	ret

;*** Divide ***
; divide 16-bit nr by 16-bit nr; X/Y -> Qotient,Reminder
; Input/Output: R16-19, Internal R24-25

; inputs
.def XL=R16 ; divident  
.def XH=R17 

.def YL=R18 ; divider
.def YH=R19 

; outputs

.def RL=R16 ; reminder 
.def RH=R17 

.def QL=R18 ; quotient
.def QH=R19 

; internal
.def QCtrL=R24
.def QCtrH=R25

_Divide:push R24 ;save internal variables on stack
        push R25
		ldi QCtrL, 0
        ldi QCtrH, 0
        Loop2:
        cp XL,YL
        cpc XH,YH
        brbs 0, End2
        sub XL,YL
        sbc XH,YH
        adiw QCtrH:QCtrL, 1
        rjmp Loop2

        ; TBD
        End2:
        mov QH, QCtrH
        mov QL, QCtrL
		pop R25 ; pop internal variables from stack
		pop R24

		ret

; *** DigitTo7segCode ***
; In/Out - R16

Table: .db 0x3f,0x06,0x5B,0x4F,0x66,0x6d,0x7D,0x07,0xff,0x6f

DigitTo7segCode:

push R30
push R31

ldi R31, high(Table<<1)
ldi R30, low(Table<<1)
add R30, R16
lpm R16, Z

    ; TBD

pop R31
pop R30

ret

; *** DelayInMs ***
; In: R16,R17
DelayInMs:  
            push R24
			push R25

            ; TBD
            LOAD_CONST R25,R24, DisplayRefreshPeriod
            Loop1:
            sbiw R25:R24, 1
            brbs 2, EndLoop
            rcall OneMsLoop
            rjmp Loop1
            EndLoop: 
			pop R25
			pop R24

			ret

; *** OneMsLoop ***
OneMsLoop:	
			push R24
			push R25 
			
			LOAD_CONST R25,R24,2000                    

L1:			SBIW R25:R24,1 
			BRNE L1

			pop R25
			pop R24

			ret