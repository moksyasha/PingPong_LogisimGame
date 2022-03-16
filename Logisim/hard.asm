asect 0x00

#d = y + (224 - x) / vx × vy - (0/256/512)

setsp 0xf0
prog:

ldi r0,0xf2 # y
ldi r1,0xf3 # x
ldi r2,0xf4 # Vxy
ldi r3,0xff #area
ld r0,r0
ld r1,r1
ld r2,r2
ld r3,r3
push r3 #push area

ldi r3, 224
sub r3,r1 #r1 = 224 -x

tst r1
shr r1 # 224 -x / 2


if
	ldi r3,0b00100000
	and r2,r3 # vy -1 / 1
	tst r3
is nz
	neg r1
	ldi r3, 0
else
	ldi r3, 1
fi

#r1 = +- (224 -x)/ 2

pop r2 #area
push r1
move r2, r1

if
tst r2
is eq
pop r1
add r0, r1
ldi r3, 0xf1
st r3, r1
halt
else
	if
	tst r2
	is mi	#upper area
		if
		tst r3
		is nz
		pop r1
		add r0, r1
		neg r1
		
		dec r1
		
		ldi r3, 0xf1
		st r3, r1
		halt
		fi
	else
		if	#lower area
		ldi r2, 0b00000001
		and r1, r2
		is nz
			if
			tst r3
			is eq
			pop r1
			add r0, r1
			neg r1
			
			inc r1
			ldi r3, 0xf1
			st r3, r1
			halt
			fi
		fi
	fi
fi

halt
end