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
.equ DisplayRefreshPeriod = 5   ; TBD

; SET_DIGIT diplay digit of a number given in macro argument, example: SET_DIGIT 2
.MACRO SET_DIGIT  
; TBD
push R16
ldi R16, $2 << @0
OUT DDRB, R16
OUT DigitsPort, R16
mov R16, Dig_@0
rcall DigitTo7segCode
OUT DDRD, R16
OUT SegmentsPort, R16
pop R16
rcall DelayInMs
.ENDMACRO 

; ### GLOBAL VARIABLES ###

.def PulseEdgeCtrL=R0
.def PulseEdgeCtrH=R1

.def Dig_0=R2
.def Dig_1=R3
.def Dig_2=R4
.def Dig_3=R5

; ### INTERRUPT VECTORS ###
.cseg		     ; segment pamiêci kodu programu 

.org	 0      rjmp	_main	 ; skok do programu g³ównego
.org OC1Aaddr	rjmp _Timer_ISR ; TBD
.org PCIBaddr   rjmp _ExtInt_ISR ; TBD ; skok do procedury obs³ugi przerwania zenetrznego 

; ### INTERRUPT SEERVICE ROUTINES ###

_ExtInt_ISR: 	 ; procedura obs³ugi przerwania zewnetrznego
 ; TBD
       cli
       push R12
       push R16
       in R12, SREG
       ldi R16, 1
       mov R10, R16
       clr R11
       add PulseEdgeCtrL, R10
       adc PulseEdgeCtrH, R11
       out SREG, R12
       pop R16
       pop R12
       sei
       reti

reti   ; powrót z procedury obs³ugi przerwania (reti zamiast ret)      

_Timer_ISR:
    push R16
    push R17
    push R18
    push R19
    ; TBD
    cli
    push R12
    in R12, SREG
    movw R17:R16, PulseEdgeCtrH:PulseEdgeCtrL
    ldi R18, low(10000)
    ldi R19, high(10000)
    rcall _Divide
    rcall NumberToDigits
    mov Dig_0, R16
    mov Dig_1, R17
    mov Dig_2, R18
    mov Dig_3, R19
    clr PulseEdgeCtrL
    clr PulseEdgeCtrH
    out SREG, R12
    pop R12 
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
    ; TBD
    push R17
    ldi R17, $20        
    out GIMSK, R17       //GIMSK BIT 6 external interrupt is enabled 0x40               // 5, pin change interrupt 0 is enabled 0x20 
    ldi R17, $01
    out PCMSK0, R17     //pin 0 (PB0/ INT0) change interrupt enable

	;--- Timer1 --- CTC with 256 prescaller
    ; TBD
    ldi R17, $0C         
    out TCCR1B, R17     //3 bit ustawia prescaler na 256(CS12), 4 bit ustawia tryb CTC(WGM12) //TOP OCR1A. str. 113
    ldi R17, $3d          //7A                     
    out OCR1AH, R17     // porownanie timera z rejestrem 0CR1A. ustawiam liczbe OCR1A, jak timer do niej dojdzie to zapali flage."a match can be used to generate an output compare interrupt"
    ldi R17, $09          //12        // bo preskaler             
    out OCR1AL, R17
    ldi R17, $40
    out TIMSK, R17      // TIMER INTERRUPT MASK REGISTER bit 6 OCIE1A, timer1, output compare a match interrupt enable
    pop R17             //a match interrupt is enabled. the corresponding interrupt vectore is executed when the OCF1A flag in TIFR is set.		
	;---  Display  --- 

	; --- enable gloabl interrupts
    ; TBD
    sei                 //global interrupts enable, flag I in SREG

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

NumberToDigits:

	push Dig0
	push Dig1
	push Dig2
	push Dig3
	; thousands 
    ldi R18, low(1000)
    ldi R19, high(1000) 
    rcall _Divide
    mov Dig0, R18
	; hundreads      
    ldi R18, 100
    ldi R19, 0
    rcall _Divide
    mov Dig1, R18
	; tens    
    ldi R18, 10
    ldi R19, 0
    rcall _Divide
    mov Dig2, R18
	; ones 
    mov Dig3, RL 
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
        ; TBD
        ldi QCtrL, 0
        ldi QCtrH, 0
        Loop:
            cp XL, YL    
            cpc XH, YH         
            brbs 0, endLoop
            sub XL, YL
            sbc XH, YH
            adiw QCtrH:QCtrL, 1
            rjmp Loop
            endLoop:
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
    ; TBD
    ldi R30, low(Table << 1)  
    ldi R31, high(Table << 1)
    add R30, R16
    lpm R16, Z
pop R31
pop R30

ret


; *** DelayInMs ***
; In: R16,R17
DelayInMs:  
        push R24
		push R25
        ; TBD
        LOAD_CONST R25, R24, DisplayRefreshPeriod
        //movw R25:R24, R17:R16
            Loop1:
                sbiw R25:R24, 1
                brbs 2, End
                rcall OneMsLoop
                rjmp Loop1
            End:
			pop R25
			pop R24
			ret

; *** OneMsLoop ***
OneMsLoop:	
			push R24
			push R25 
			
			LOAD_CONST R25,R24,2000                    

L1:			SBIW R24:R25,1 
			BRNE L1

			pop R25
			pop R24

			ret

