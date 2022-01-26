		AREA	MAIN_CODE, CODE, READONLY
		GET		LPC213x.s
;cw7		

		ENTRY
__main
__use_two_region_memory
		EXPORT			__main
		EXPORT			__use_two_region_memory


PORT1SET      EQU     0x0ff0000 	;set port 1 16-23 as output (port 1 - segments)
PORT1SETSEG	  EQU     0x03f0000		;A-G - 16-23, set segments "0" - 0x3F, 0x080000 - dot

PORT0SET      EQU     0x00f0000		;set pin 16-19 as output  
PORT0SETDIG	  EQU     0x0080000		;pin 16 - digit 0 enable 8 - ones digit, 4 - tens digit etc.
; Setup PORT0, PORT1


	

	LDR     R4, =IODIR1				;direction, 1=output
	LDR     R5, =PORT1SET
	STR     R5, [R4]				;value found in R1 is stored to adress found in R0
	LDR     R4, =IOSET1				;set=1
	LDR     R5, =PORT1SETSEG
	STR     R5, [R4]
	
	LDR     R4, =IODIR0				;set digits 0-3 as output (port 0 - digits)
	LDR     R5, =PORT0SET
	STR     R5, [R4]
	LDR     R4, =IOSET0				;set digit 0
	LDR     R5, =PORT0SETDIG
	STR     R5, [R4]

	
	ldr R0, =1000
	
DISABLEDIGITS	EQU		0x00f0000
CURRENT_DIGIT	RN	R12
	LDR     R12, =0
main_loop
	
	LDR     R4, =IOCLR0
	LDR     R5, =DISABLEDIGITS
	STR     R5, [R4]
	
	LDR     R4, =IOSET0
	LDR 	R11, =PORT0SETDIG	;0x80000
	MOV 	R5, R11, LSR R12	;shift 0x80000 >> CURRENT_DIGIT
	STR     R5, [R4]
	
	CMP CURRENT_DIGIT, #3	
	ADR     R7, Table	
	LDRB	R6, [R7, CURRENT_DIGIT]	;load R9 with byte from R8 address with offset of curr_dig
	ADD CURRENT_DIGIT, #1
	BNE dodgeclr
	LDR	CURRENT_DIGIT, =0
dodgeclr

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

