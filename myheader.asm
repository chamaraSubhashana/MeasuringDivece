;--- buffer equates
.equ	disbuf	=$60
.equ	bcdbuf	=$68 
;Register definitions
.def	zero	=R2	;always zero
.def	temp	=R16
.def	tmp	=R17
.def	tcnt	=R19	;trigger counter
.def	scnt	=R20	;scanline counter
.def	flags	=R21	;used in flagged operations
.def	keyst	=R22	;pinD state
	.equ	xi0	=0	;external intr0 occured
	.equ	ka1	=1	;key Action 1
	.equ	ka2	=2	;key Action 2
.def	lpcnt	=R23	;loop counter
.def	wl	=R24
.def	wh	=R25
;---Pin definitions------
.equ	echo=2		;portd input pin
.equ	trig=0		;portd output pin

