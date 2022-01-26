		AREA	MAIN_CODE, CODE, READONLY
		GET		LPC213x.s
		

		ENTRY
__main
__use_two_region_memory
		EXPORT			__main
		EXPORT			__use_two_region_memory

	ldr R0, =347
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