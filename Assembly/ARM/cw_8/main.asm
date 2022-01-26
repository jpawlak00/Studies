		AREA	MAIN_CODE, CODE, READONLY
		GET		LPC213x.s
;cw7		

		ENTRY
__main
__use_two_region_memory
		EXPORT			__main
		EXPORT			__use_two_region_memory
	
CURRENT_DIGIT	RN	R12

	;delay[ms]
	LDR R0, =5

	;ustawienie pinow sterujacych wyswietlaczem na wyjsciowe
	LDR     R4, =IODIR0				;set digits 0-3 as output (port 0 - digits)
	LDR     R5, =0x00f0000
	STR     R5, [R4]
	LDR     R4, =IODIR1				;set segments A-G as output (port 1 - segments)
	LDR     R5, =0x0ff0000
	STR     R5, [R4]				
	
	;wyzerowanie licznika cyfr
	LDR     R12, =0
main_loop
	;wyzerowanie segments
	LDR     R4, =IOCLR0
	LDR     R5, =0x00f0000
	STR     R5, [R4]
	;wyzerowanie digits
	LDR     R4, =IOCLR1
	LDR     R5, =0x07f0000
	STR     R5, [R4]
	;wlaczenie cyfry o numerze podanym w CURR_DIG
	LDR     R4, =IOSET0
	LDR 	R11, =0x80000			;0x80000
	MOV 	R5, R11, LSR R12		;shift 0x80000 >> CURRENT_DIGIT
	STR     R5, [R4]
	;zamiana numeru CURR_DIG na kod 7seg(R6)
	ADR     R7, Table	
	LDRB	R6, [R7, CURRENT_DIGIT]	;load R6 with byte from R7 address with offset of curr_dig
	;wpisanie kodu 7seg (R6) do segmentow
	LDR     R4, =IOSET1				;set=1
	MOV     R5, R6, LSL #16			;load R5 with R6 shifted << 16
	STR     R5, [R4]
	;inkrementacja CURR-DIG
	CMP CURRENT_DIGIT, #3	
	ADD CURRENT_DIGIT, #1
	BNE dodgeclr
	LDR	CURRENT_DIGIT, =0
dodgeclr
	;delay
	bl delay_in_ms
	b main_loop
		
delay_in_ms
;input R0
	ldr R1, =12000
	mul R1, R0, R1
Internal
		subs R1, R1, #1
		beq finish
		b Internal
finish
	bx	lr ;R14
	
Table	DCB	0x3f,0x06,0x5B,0x4F,0x66,0x6d,0x7D,0x07,0x7f,0x6f
	
		END

