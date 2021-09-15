.data 

szX: 	.asciz 		"51"
szY:	.asciz		"9"
szAdd:	.asciz		" + "
chCr: 	.byte		10
dbX:	.dword		0

.global _start		//Provide program starting address to linker
.text

_start
	//convert szX to an integer and add it to the accumulator register
	LDR	X0, =szX	//X0 =&szX
	BL	ascint64	//BL branch Link stores the next LOC in the link register 
				//Upon return X0 = ascint64(*X0)
	LDR X0, =szY		//X0 = szY
	BL ascint64 		//bl Branch link stores the next LOC in the link register
				//Upon return X0 = ascint64(*X0)
				//Code process to X + Y ... registers X10 and above can be safely used



//PRINT RESULTS
//Setup parameters to szX amd then call linux to do it
	MOV	X0, #1		//1 = StdOut
	LDR	X1, =szX	//string to print
	MOV 	X2, #2		//length of our string 
	MOV	X8, #64		//linux write system call
	svc 0			//call linux to output string 

exit:
	//setup parameters to exit the program and then call linux to do it
	MOV X0, #0		//use 0 return code 
	MOV X8, #93		//service command code 93 terminates the program
	svc 0			//call linux to terminate program 


ascint64:
	MOV	X8, X0		//Preserve X0 since strlength will overwrite it
	MOV 	X9, LR		//Preserve LR before losinjg it to strlength
	BL	strlength	//X0 = strlength(*X0)
	MOV 	LR, X9		//restore link register

	MOV	X5, X0		// Copy X0 (length) into X5
	CMP	X0, #0		//if strlegnth(*X0) == 0
	BEQ	botLoop		// exit
	MOV 	X0, X8		// restoring X0 to point to cstring

	//power math for base 10
	MOV	X2, #1		//y
	MOV 	X4, #10		//base 10
	MOV 	X6, #0		//accumulator

topLoop:
	MOV	X7, #0
	ADD	X7, X7, X0	//point to the last digit in *X0 i.e 1's
	ADD	X7, X7, X5	//X7 -> to the end of the cstring so we can work backwards
	SUB	X7, X7 #1	//
	LDRB	W1, [X7], #1	//indirect addressing X1 = *X0

	SUB	W1, W1, #0X30	//subtract the ascii offset of 48
	MUL	X3, X1, X2	//X3 = x * 10^y and y is stored in X3
				//x is now stored in W1

	ADD	X6, X6, X3	//X6 is accumulator
	MUL	X2, X2, X4	//result of X4 ^ X2
	SUB	X5, X5, #1
	CMP	X5, #0		//Compare x5 ==0 
	BEQ	botLoop		// if (X5 == 0)
	B	topLoop		//jump to botLoop

botLoop:
	MOV	X0, X6	//Store result into X0
	BR 	LR	//return

strLength:
	MOV 	X7, X0		//point to first digit of CString
	MOV 	X2, #0		//counter

topLoop2:
	LDRB	W1, [X7], #1	//indirect addressing X1 = *X0
	CMP	W1, #0		//if (W1 == NULL)
	BEQ	botLoop2	//jump to bottom of subroutine
	ADD 	X2, X2, #1	//increment the counter 
	B	topLoop2

botLoop2: 
	MOV 	X0, X2	//X0 = length of cstring
	BR 	LR	//return

	.end
