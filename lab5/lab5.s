.data 

szX: 	.asciz 		"10"
szY:	.asciz		"15"
szAdd:	.asciz		" + "
szSum:	.asciz		" = ?? "
dbX:	.word		0
dbY:	.word		0
dbSum:	.word		0

.global _start		//Provide program starting address to linker
.text

_start:
	//convert szX to an integer and add it to the accumulator register
	LDR	X0, =szX	//X0 =&szX
	BL	ascint64	//BL branch Link stores the next LOC in the link register 
				//Upon return X0 = ascint64(*X0)

	LDR	 X10, =dbX	//X10 = &dbX
	STR	 X0, [X10]	//stores the dereferenced value of X10 into X0
	MOV	 X13, X0	//value of X0 moved into X13

	LDR 	X0, =szY	//X0 = &szY
	BL 	ascint64 	//bl Branch link stores the next LOC in the link register
				//Upon return X0 = ascint64(*X0)
				//Code process to X + Y ... registers X10 and above can be safely used

	LDR	X12, =dbY	//X12 = &dbY
	STR 	X0, [X12]	//stores dereferenced value of X12 into X0
	MOV 	X14, X0		//value of X0 moved into X14

	ADD	X15, X13, X14	//Adds X13 and X14 and stores into X15
	LDR 	X16, =dbSum	//X16 = &dbSum
	STR	X15, [X16]	//dereferenced value of X16 into X15


//PRINT RESULTS
//Setup parameters to szX amd then call linux to do it
	MOV	X0, #1		//1 = StdOut
	LDR	X1, =szX	//string to print
	MOV 	X2, #2		//length of our string 
	MOV	X8, #64		//linux write system call
	svc 0			//call linux to output string 

	MOV	X0, #1		//1 = StdOut
	LDR 	X1, =szAdd	//string to print
	MOV	X2, #3		//length of string
	MOV	X8, #64		//linux write system call
	svc 0			//call linux to output string

	MOV 	X0, #1		//1 = StdOut
	LDR	X1, =szY	//string to print
	MOV	X2, #2		//length of string 
	MOV	X8, #64		//linux write system call
	svc 0			//call linux to output string

	MOV	X0, #1		//1 = StdOut
	LDR 	X1, =szSum	//string to print 
	MOV	X2, #6		//length of string
	MOV	X8, #64		//linux write system call
	svc 0			//call linux to output string 

exit:
	//setup parameters to exit the program and then call linux to do it
	MOV X0, #0		//use 0 return code 
	MOV X8, #93		//service command code 93 terminates the program
	svc 0			//call linux to terminate program 

//ascint64: converts string of characters to an equivalent 8-byte value. The binary
//	    value of the converted string us returned in the X0 register. If there is 
//	    an invalid character in the numeric string which would invalidate the conversion
//	    the carry flag is set to 1 and the X0 rtegister returns 0.
//	    If the numeric string contains a number that is too large to fit in a dword, the 
//	    overflow is set to 1 and the X0 register returns 0
//X0: must point to a null terminated string
//LR: contains return address 

//Returned register contents :
//	X0: Decimal result
//Registers X0 - X8 are modified and not preserved

ascint64:
	MOV	X8, X0		//Preserve X0 since strlength will overwrite it
	MOV 	X9, LR		//Preserve LR before losinjg it to strlength
	BL	strLength	//X0 = strlength(*X0)
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
	SUB	X7, X7, #1	//
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
