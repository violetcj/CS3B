.data 

szX: 	.asciz 		"51"
szY:	.asciz		"9"
szAdd:	.asciz		" + "
chCr: 	.byte		10
dbX:	.dword		0

.global _start
.text

_start
	//convert szX to an integer and add it to the accumulator register
	LDR	X0, =szX	//X) =&szX
	BL	ascint64	//BL branch Link stores the next LOC in the link register 

	LDR X0, =szY	//X0 = szY
	BL ascint64 



//PRINT RESULTS
//Setup parameters to szX amd then call linux to do it
	MOV	X0, #1	//1 = StdOut
	LDR	X1, =szX
	MOV 	X2, #2
	MOV	X8, #64
	svc 0

exit:
	//setup parameters to exit the program and then call linux to do it
	MOV X0, #0
	MOV X8, #93
	svc 0


ascint64:
	MOV	X8, X0
	MOV 	X9, LR
	BL	strlength
	MOV 	LR, X9

	MOV	X5, X0
	CMP	X0, #0
	BEQ	botLoop
	MOV 	X0, X8

	//power math for base 10
	MOV	X2, #1
	MOV 	X4, #10
	MOV 	X6, #0

topLoop:
	MOV	X7, #0
	ADD	X7, X7, X0
	ADD	X7, X7, X5
	SUB	X7, X7 #1
	LDRB	W1, [X7], #1

	SUB	W1, W1, #0X30
	MUL	X3, X1, X2

	ADD	X6, X6, X3
	MUL	X2, X2, X4
	SUB	X5, X5, #1
	CMP	X5, #0
	BEQ	botLoop
	B	topLoop

botLoop:
	MOV	X0, X6
	BR 	LR

strLength:
	MOV 	X7, X0
	MOV 	X2, #0

topLoop2:
	LDRB	W1, [X7], #1
	CMP	W1, #0
	BEQ	botLoop2
	ADD 	X2, X2, #1
	B	topLoop2

botLoop2: 
	MOV 	X0, X2
	BR 	LR

	.end
