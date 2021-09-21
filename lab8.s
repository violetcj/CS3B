.data
chStr: 	.asciz	"CJ Carroll"

.global _start 
.text 

_start:
	LDR 	X0, =chStr	//X0 = &chStr
	MOV 	X6, X0		//preserving X0

	BL 	strLength
	MOV	LR, X9		//restore link register 

print:
	MOV 	X2, X0		//move length of string 
	MOV 	X0, #1 		//stdOut
	LDR	X1, =chStr	//string to print
	MOV	X8, #64		//Linux write system call 
	svc 	0		//call linux to output

exit:
	MOV	X0, #0		//0 return code
	MOV	X8, #93		//service command to terminate program
	svc 	0		//call linux to terminate
strLength:
	MOV	X7, X0		//Point to first digit of C-string
	MOV	X2, #0		//counter

topLoop:
	LDRB	W1, [X7], #1	//INDIRECT ADDRESSING
	CMP 	W1, #0		//if (W1 == NULL)
	BEQ	botLoop		//jump to bottom of subroutine
	ADD	X2, X2, #1	//increment counter 
	B	topLoop

botLoop:
	MOV	X0, X2		//length of string
	BR 	LR		//return
