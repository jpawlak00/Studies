		AREA	MAIN_CODE, CODE, READONLY
		GET		LPC213x.s
;cw4		

		ENTRY
__main
__use_two_region_memory
		EXPORT			__main
		EXPORT			__use_two_region_memory


IODIR0SET      EQU     0x00000f0 	;4-7
; Setup PORT0
	IF      IOPIN0 <> 0
	LDR     R0, =IODIR0				;dircetion, 1=output
	LDR     R1, =IODIR0SET
	STR     R1, [R0]				;value found in R1 is stored to adress found in R0
	ENDIF

	
	ldr R0, =1
main_loop	
	bl delay_in_ms
	nop
	b main_loop
		
		

delay_in_ms
;input R0
	ldr R1, =2400
	mul R1, R0, R1
Internal
		subs R1, R1, #1
		beq finish
		b Internal
finish
	bx	lr ;R14
		END