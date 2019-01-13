.include "tn2313def.inc"				
.include "..\myheader.asm"	
		
	rjmp	RESET		
	rjmp	DONKA		;External Interrupt0
	reti			;External Interrupt1
	reti			;Timer1 Capture
	reti			;Timer1 CompareA
	reti			;Timer1 Overflow
	rjmp	TIM0_OVF	;Timer0 Overflow
	reti			;USART0 RX Complete
	reti			;USART0,UDR Empty
	reti			;USART0 TX Complete
	reti			;Analog Comparator
	reti			;Pin Change Interrupt 0
	reti			;Timer1 Compare B
	reti			;Timer0 Compare A
	reti			;Timer0 Compare B
	reti			;USI Start
	reti			;USI Overflow
	reti			;EEPROM Ready
	reti			;Watchdog Overflow
	reti			;Pin Change Interrupt 1
	reti			;Pin Change Interrupt 2PORTD 4 18
.include "..\mymac.asm"
;------- Interrupt Service Routines (isr) -----------				

DONKA:		minpush

		sbis 	pind,echo
		rjmp 	DONK
		sbr	flags,(1<<xi0)
		out	TCNT1L,zero
	rjmp xisr			
				
DONK:		cbr	flags,(1<<xi0)
		in	temp,TCNT1L
		rcall	unit
		rcall	update
	rjmp xisr

;-----------------------------------------------------

TIM0_OVF:		minpush

		rcall	getkey

		out	portb,zero
		out	portd,zero

		dec	scnt	
		andi	scnt,$03

		ldi	YH,0x00
		ldi	YL,disbuf
		add	YL,scnt
		ld	temp,Y		
		out	PORTB,temp

		ldi	ZH,0x06
		mov	ZL,scnt
	
		lpm 	temp,z
		out 	PORTD,temp 	


		inc	tcnt
		cpi	tcnt,8
		brcc 	trigger
	rjmp xisr	

TRIGGER:	clr 	tcnt
		sbrc 	flags,xi0
	rjmp xisr
		sbi	portD,trig	;issue trigger pulse
		rcall	delay
		cbi	portD,trig	;end of trigger pulse
	rjmp xisr

;---------------------------------------------

XISR:  			minpop
		reti

;------------------ Reset --------------------
				
RESET:		iold	SPL,RAMEND		
		iold	DDRB,$FF		
		iold	DDRD,$73		
		iold	TCCR0B,$02
		iold	TCCR1B,$04
		iold	TIMSK,$02
		iold	UBRRL,$19
		iold	GIMSK,$40
		iold	MCUCR,$01
		
		clr 	tcnt
		clr	zero			
		clr	flags		
		clr	scnt
		
		sei

;------- Main program loop -----------	
			
MAIN:		nop
		rjmp		main	

;---------------end-------------------

.include "..\mysubs.asm"

.include "..\mytables.asm"





