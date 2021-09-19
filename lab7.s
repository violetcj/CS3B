.data
testCase: 	.byte		1
scrPr:		.asciz		"DEFAULT CASE"

.global _start
.text

_start:
	LDR 	X0, =testCase	//XO = &testCase
	LDR 	X0, [X0]	//DEREFERENCING XO AND STORING VALUE IN X0 

	LDR 	X1, =scrPr	//X1 = &scrPr
	CMP	X0, #1		//COMPARING VALUE OF X0 TO 1
	B.EQ	ifOne		//JUMPS TO LABEL ifOne IF COMPARION ABOVE IS EQUAL

	CMP 	X0, #2		//COMAPRING VALUE OF X0 TO 2
	B.EQ	ifTwo		//JUMPS TO LABEL ifTwo IF COMPARISON ABOVE IS EQUAL

	B	ifNeither	//BRANCHES TO LABEL ifNeither

ifOne:
	MOV	X1, #1		//REPLACES X1 VALUE WITH 1

	B	putch		//BRANCHES TO LABEL putch

ifTwo:
	MOV 	X1, #2		//REPLACES X1 VALUE WITH 2
	B	putch		//BRANCHES TO LABEL putch

ifNeither:
	MOV	X0, #1
	MOV	X2, #13
	MOV	X8, #64
	svc	0
	B	exit

putch:
	MOV 	X0, #1
	MOV	X2, #2
	MOV	X8, #64
	svc	0
	B	exit

exit:
	MOV	X0, #0
	MOV 	X8, #93
	svc	0
