;------- Subroutines -----------
				

DELAY:		ldi	tmp,1		;trigger pulse width
	 	dec	tmp
		brne	delay+1
		ret


UPDATE:		rcall	binbcd		;update disbuf
		rcall	split
		rcall	pict
		ret
			
PICT: 		clr	YH		;7 segment pictures
		ldi 	YL,disbuf
		ldi 	ZH,0x06
	    p1: ldd 	temp,Y+8	;get value
		ldi 	ZL,0x20		;setup ZL
		add 	ZL,temp
		lpm 	temp,z		;get pic
		st  	Y+,temp		;store pic in disbuf and next
		cpi  	YL,disbuf+4
		brlo 	p1
		ret

BINBCD:		clr	wl		;binary >> packed BCD
		clr	wh
		ldi	lpcnt,8
	    p2:	da	wl
		da	wh
		rol	temp
		rol	wl
		rol	wh
		dec	lpcnt
		brne	p2
		ret

SPLIT:		clr	YH		;packed BCD >> BCD
		ldi	YL,bcdbuf
		mov	tmp,wl
		rcall	splt+1
		mov		tmp,wl
		rcall	splt
		mov		tmp,wh
		rjmp	splt+1
   	  splt:	swap	tmp
		andi	tmp,0x0F
		st		Y+,tmp
		ret

GETKEY:		clc			;debouncing
		sbic	PIND,3
		sec
		rol	keyst

	 	cpi	keyst,$FF
		brcs	check
	keyup:	cbr	flags,(1<<ka1)	;for next keydown action to be occured
		ret

	check:	cpi	keyst,$00
		breq	keyDow
		ret

  	keydow:	sbrc	flags,ka1	;checking for avoiding repeatition of keydown action
		ret

		ldi	temp,$04	;for toggle on/off
		clr	tmp		
		eor	tmp,temp
		add	flags,tmp

		sbr	flags,(1<<ka1)	;represents 'keydown action has occured once'
		ret

UNIT:		mov	wl,temp		;select unit
		ldi	temp,5		;in cm
		sbrs	flags,ka2
		ldi	temp,2		;in inch
		ldi	lpcnt,8
		mov	wh,wl
		sub	wl,wl
		rol	wl
		rol	wh
		brcc	PC+3
		add	wl,temp
		dec	lpcnt
		brne	unit+7
		mov	temp,wl
		ret
