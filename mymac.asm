.macro	minpush		;protect sreg and working registers
	push	temp	
	in	temp,SREG	
	push	temp
	push	tmp
	push	wl
	push	wh
	push	lpcnt
.endm

.macro	minpop		;protect sreg and working registers
	pop	lpcnt
	pop	wh
	pop	wl
	pop	tmp
	pop	temp	
	out	SREG,temp	
	pop	temp	
.endm

.macro	da		;decimal adjust w register
	ldi	R18,0x33
	add	@0,R18
	sbrs	@0,3
	subi	@0,0x03
	sbrs	@0,7
	subi	@0,0x30
.endm

.macro	iold		;load derectly to io registers
	ldi	R18,@1
	out	@0,R18
.endm		
