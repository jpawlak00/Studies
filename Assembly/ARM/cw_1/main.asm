		AREA	MAIN_CODE, CODE, READONLY
		GET		LPC213x.s
		
		ENTRY
__main
__use_two_region_memory
		EXPORT			__main
		EXPORT			__use_two_region_memory
		
	ldr R1, =1000
main_loop	
	subs R1, R1, #1
	beq finish
		
	b	main_loop
finish
	nop
		END