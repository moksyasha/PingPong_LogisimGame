asect 0x00

#d = y + (224 - x) / vx × vy - (0/256/512)

setsp 0xf0
prog:

ldi r0,0xf2 # y
ldi r1,0xf3 # x
ldi r2,0xf4 # Vxy
ld r0,r0
ld r1,r1
ld r2,r2

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

if
tst r0
is mi
	if
	tst r3
	is nz #вверх часть экрана, летит вверх
	
	add r0, r1
	neg r1
	
	dec r1
	dec r1
	
	ldi r3, 0xf1

	st r3, r1
	
	halt
	fi	
else
	if
	tst r3
	is eq

	add r0, r1
	neg r1
	dec r1
	
	ldi r3, 0xf1
	
	st r3, r1
	
	halt

	fi
fi


add r0, r1

ldi r3, 0xf1
st r3, r1

halt
end