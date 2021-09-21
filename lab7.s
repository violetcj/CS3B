.data
default:		.asciz		"DEFAULT CASE\n"
one:			.asciz		"1\n"
two:			.asciz		"2\n"
testValue: 		.byte		3

.global _start
.text

_start:
	LDR 	X0, =testValue  //X0 = &testValue
	LDRB 	W0, [X0]	//loading one byte of actual value into W0(X0)
	LDR 	X1, =default	//X1 = &default
	CMP	X0, #1		//COMPARING VALUE OF X0 TO 1
	B.EQ	ifOne		//JUMPS TO LABEL ifOne IF COMPARION ABOVE IS EQUAL

	CMP 	X0, #2		//COMAPRING VALUE OF X0 TO 2
	B.EQ	ifTwo		//JUMPS TO LABEL ifTwo IF COMPARISON ABOVE IS EQUAL

	B	ifNeither	//BRANCHES TO LABEL ifNeither

ifOne:
	LDR	X1, =one	//LOADS one LABEL INTO X1
	B	putch		//BRANCHES TO LABEL putch

ifTwo:
	LDR 	X1, =two	//LOADS two LABEL INTO X1
	B	putch		//BRANCHES TO LABEL putch

ifNeither:
	MOV	X0, #1		//StdOut
	MOV	X2, #13		//LENGTH OF STRING
	MOV	X8, #64		//LINUX WRITE SYSTEM CALL
	svc	0		//CALL LINUX TO OUTPUT
	B	exit		//BRANCH TO exit LABEL

putch:
	MOV 	X0, #1		//StdOut
	MOV	X2, #2		//LENGTH OF STRING 
	MOV	X8, #64		//LINUX WRITE SYSTEM CALL
	svc	0		//CALL LINUX TO OUTPUT 
	B	exit		//BRANCH TO exit LABEL

exit:
	MOV	X0, #0		//0 RETURN CODE
	MOV 	X8, #93		//SERVICE CODE 93 TERMINATES 
	svc	0		//CALL LINUX TO TERMINATE PROGRAM
