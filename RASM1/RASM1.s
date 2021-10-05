//RASM1 Project
.data
hexStr: 	.asciz  	"0123456789ABCDEFG"
szName:		.asciz		" Name: CJ Carroll"
szClass:	.asciz		"Class: CS3B"
szLab:		.asciz		"  Lab: RASM1"
szDate: 	.asciz		" Date: 10/6/21"
chCr:		.asciz		"\n"
szPr:		.asciz		"Enter a whole number: "
szFp:		.asciz		"( "
szBp:		.asciz		" )"
szPlus:		.asciz		" + "
szMinus:	.asciz		" - "
szEqual:	.asciz		" = "
szAin:		.skip		19
szBin:		.skip		19
szCin:		.skip		19
szDin:		.skip		19
qA:		.quad		0
qB:		.quad		0
qC:		.quad		0
qD:		.quad		0
qABsum:		.quad		0
qCDsum:		.quad		0
qTotal:		.quad		0
.text
.global _start

_start:
	//PRINTING szName
	LDR	X0, =szName	//X0 = &szName
	BL	putstring	//print szName
	LDR 	X0, =chCr	//X0 = &chCr
	BL	putstring	//execute a newline

	//PRINTING szClass
	LDR 	X0, =szClass	//X0 = &szClass
	BL 	putstring	//print szClass
	LDR	X0, =chCr	//X0 = &chCr
	BL	putstring	//execute a newline

	//PRINTING szLab
	LDR	X0, =szLab	//X0 = &szLab
	BL	putstring	//print szLab
	LDR	X0, =chCr	//X0 = &chCr
	BL	putstring	//execute newline

	//PRINTING szDate
	LDR	X0, =szDate	//X0 = &szDate
	BL	putstring	//print	szDate
	LDR	X0, =chCr	//X0 = &chCr
	BL	putstring	//execute newline
	LDR	X0, =chCr	//reload X0
	BL	putstring	//execute newline once more
        LDR     X0, =chCr       //reload X0
        BL      putstring       //execute newline once more

	//GETTING INPUT A
	LDR 	X0, =szPr	//X0 = &szPr
	BL	putstring	//print szPr
	LDR	X1, =szAin	//X1 = &szAin
	MOV	X2, #19		//X2 holds literal 19
	BL	getstring	//Get a number into szAin
	MOV	X19, X1		//Preserve szAin

	//GETTING INPUT B
	LDR	X0, =szPr	//X0 = &szPr
	BL	putstring	//print szPr
	LDR	X1, =szBin	//X1 = &szBin
	MOV	X2, #19		//X2 holds literal 19
	BL	getstring	//Get value into szBin
	MOV	X20, X1		//Preserve szBin

	//GETTING INPUT C
	LDR	X0, =szPr	//X0 = &szPr
	BL	putstring	//print szPr
	LDR	X1, =szCin	//X1 = &szCin
	MOV	X2, #19		//X2 holds literal 19
	BL 	getstring	//Get value into szCin
	MOV	X21, X1		//Preserve szCin

        //GETTING INPUT D
        LDR     X0, =szPr       //X0 = &szPr
        BL      putstring       //print szPr
        LDR     X1, =szDin      //X1 = &szDin
        MOV     X2, #19         //X2 holds literal 19
        BL      getstring       //Get value into szDin
        MOV     X22, X1         //Preserve szDin

	//OUTPUTTING EQUATION DISPLAY: (A + B) - (C + D) = ???
	LDR	X0, =chCr	//X0 = &chCr
	BL	putstring	//execute newline
	LDR	X0, =szFp	//X0 = &szFp
	BL	putstring	//print szFp

	MOV	X0, X19		//X0 = &szAin
	BL 	putstring	//Print szAin

	LDR	X0, =szPlus	//X0 = &szPlus
	BL 	putstring	//Print szPlus

	MOV	X0, X20		//X0 = &szBin
	BL	putstring	//print szBin

	LDR	X0, =szBp	//X0 = &szBp
	BL	putstring	//print szBp

	LDR	X0, =szMinus	//X0 = &szMinus
	BL 	putstring	//Print szMinus

	LDR	X0, =szFp	//X0 = &szFp
	BL	putstring	//Print szFp

	MOV	X0, X21		//X0 = &szCin
	BL	putstring	//print szCin

	LDR	X0, =szPlus	//X0 = &szPlus
	BL	putstring	//print szPlus

	MOV	X0, X22		//X0 = &szDin
	BL	putstring	//print szDin

	LDR	X0, =szBp	//X0 = &szBp
	BL	putstring	//print szBp

	LDR	X0, =szEqual	//X0 = &szEqual
	BL	putstring	//print szEqual

	//CONVERTING A STRING TO HEX
	MOV	X0, X19		//X0 = &szAin
	BL	ascint64	//Convert szAin to int
	LDR	X19, =qA	//X19 = &qA
	STR	X0, [X19]	//*X19 = X0

	//CONVERTING B STRING TO HEX
	MOV	X0, X20		//X0 = &szBin
	BL	ascint64	//convert szBin to int
	LDR	X20, =qB	//X20 = &qB
	STR	X0, [X20]	//*X20 = X0

	//CONVERTING C STRING TO HEX
	MOV 	X0, X21		//X0 = &szCin
	BL	ascint64	//convert szCin to int
	LDR	X21, =qC	//X21 = &qC
	STR	X0, [X21]	//*X21 = X0

	//CONVERTING D STRING TO HEX
	MOV	X0, X22		//X0 = &szDin
	BL	ascint64	//convert szDin to int
	LDR	X22, =qD	//X22 = &qD
	STR	X0, [X22]	//*X22 = X0

exit:
        //SETUP PARAMETERS TO EXIT PROGRAM AND THEN CALL
        //LINUX TO DO IT
        MOV     X0, #0  //USE 0 RETURN CODE
        MOV     X8, #93 //SERVICE COMMAND CODE 93 TERMINATES PROGRAM
        svc     0       //CALL LINUX TO TERMINATE PROGRAM







//getstring: will read a string of characters terminated by a null and stores it within the address of X1

//X1: Points to the first byte of buffer to receive the string
//X2: The length of the string buffer
//LR: Contains return address

//Returned Register contents:
//X0: Will return the # of bytes read
//All AAPCS mandated registers are preserved

getstring:
	//Preserve registers X19-X30 by pushing onto stack
	STR	X19,[SP, #-16]!		//X19 onto stack
        STR     X20,[SP, #-16]!         //X20 onto stack
        STR     X21,[SP, #-16]!         //X21 onto stack
        STR     X22,[SP, #-16]!         //X22 onto stack
        STR     X23,[SP, #-16]!         //X23 onto stack
        STR     X24,[SP, #-16]!         //X24 onto stack
        STR     X25,[SP, #-16]!         //X25 onto stack
        STR     X26,[SP, #-16]!         //X26 onto stack
        STR     X27,[SP, #-16]!         //X27 onto stack
        STR     X28,[SP, #-16]!         //X28 onto stack
        STR     X29,[SP, #-16]!         //X29 onto stack
        STR     X30,[SP, #-16]!         //LR onto stack

	//Setting up system call
	MOV 	X0, #0	//0 = StdIn
	MOV 	X8, #63	//Linux read system call
	SVC 	0	//Calls linux

	//system call will keep reading until a \n is typed
	SUBS	X0, X0, #1	//Sets address pointed to by X0 to be one less than
				//its current length in order to access the memory address
				//with the string's newline character
	LDRB	W8, [X1, X0]	//Loads W8 with the byte containing the '\n' character
	CMP	W8, #'\n'	//Compares the contents of W8 with ascii for '\n'
	BEQ	getstringend	//conditional jump to end of function if the value is
				//'\n'
	ADD	X0, X0, #1	//If the previous jump fails, adjust by adding 1 to X0

getstringend:
	MOV	W3, #0		//stores the null terminating character ascii value in X3
	STRB	W3, [X1, X0]	//stores null character in the memory address currently being
				//pointed to by X1 with an offset of X0

	//Popping registers off the stack
	LDR	X30, [SP], #16	//Pops LR
	LDR     X29, [SP], #16  //Pops X29
	LDR     X28, [SP], #16  //Pops X28
	LDR     X27, [SP], #16  //Pops X27
	LDR     X26, [SP], #16  //Pops X26
	LDR     X25, [SP], #16  //Pops X25
	LDR     X24, [SP], #16  //Pops X24
	LDR     X23, [SP], #16  //Pops X23
	LDR     X22, [SP], #16  //Pops X22
	LDR     X21, [SP], #16  //Pops X21
	LDR     X20, [SP], #16  //Pops X20
	LDR     X19, [SP], #16  //Pops X19

	RET 	LR	//Return



//ascint64: converts string of characters to an equivalent 8-byte value. The binary
//          value of the converted string is returned in the X0 register. If there is
//          an invalid character in the numeric string which would invalidate the conversion
//          the carry flag is set to 1 and the X0 rtegister returns 0.
//          If the numeric string contains a number that is too large to fit in a dword, the
//          overflow is set to 1 and the X0 register returns 0
//X0: must point to a null terminated string
//LR: contains return address

//Returned register contents :
//      X0: Decimal result
//Registers X0 - X8 are modified and not preserved

ascint64:
        MOV     X8, X0          //Preserve X0 since strlength will overwrite it
        MOV     X9, LR          //Preserve LR before losinjg it to strlength
        BL      strlength       //X0 = strlength(*X0)
        MOV     LR, X9          //restore link register

        MOV     X5, X0          // Copy X0 (length) into X5
        CMP     X0, #0          //if strlegnth(*X0) == 0
        BEQ     botLoop         // exit
        MOV     X0, X8          // restoring X0 to point to cstring

        //power math for base 10
        MOV     X2, #1          //y
        MOV     X4, #10         //base 10
        MOV     X6, #0          //accumulator

topLoop:
        MOV     X7, #0
        ADD     X7, X7, X0      //point to the last digit in *X0 i.e 1's
        ADD     X7, X7, X5      //X7 -> to the end of the cstring so we can work backwards
        SUB     X7, X7, #1      //
        LDRB    W1, [X7], #1    //indirect addressing X1 = *X0

        SUB     W1, W1, #0X30   //subtract the ascii offset of 48
        MUL     X3, X1, X2      //X3 = x * 10^y and y is stored in X3
                                //x is now stored in W1

        ADD     X6, X6, X3      //X6 is accumulator
        MUL     X2, X2, X4      //result of X4 ^ X2
        SUB     X5, X5, #1
        CMP     X5, #0          //Compare x5 ==0
        BEQ     botLoop         // if (X5 == 0)
        B       topLoop         //jump to botLoop

botLoop:
        MOV     X0, X6  //Store result into X0
        BR      LR      //return


strlength:
        MOV     X7, X0          //point to first digit of CString
        MOV     X2, #0          //counter

topLoop2:
        LDRB    W1, [X7], #1    //indirect addressing X1 = *X0
        CMP     W1, #0          //if (W1 == NULL)
        BEQ     botLoop2        //jump to bottom of subroutine
        ADD     X2, X2, #1      //increment the counter
        B       topLoop2

botLoop2:
        MOV     X0, X2  //X0 = length of cstring
        BR      LR      //return
hex64asc:
        STR     X19, [SP,#-16]!         //PUSH
        STR     X20, [SP,#-16]!         //PUSH
        STR     X21, [SP,#-16]!         //PUSH
        STR     X22, [SP,#-16]!         //PUSH
        STR     X23, [SP,#-16]!         //PUSH
        STR     X24, [SP,#-16]!         //PUSH
        STR     X25, [SP,#-16]!         //PUSH
        STR     X26, [SP,#-16]!         //PUSH
        STR     X27, [SP,#-16]!         //PUSH
        STR     X28, [SP,#-16]!         //PUSH
        STR     X29, [SP,#-16]!         //PUSH
        STR     X30, [SP,#-16]!         //PUSH

//X0 - is address of the destination c-string (19 bytes)
//X1 - holds hexadecimal value to be converted to c-string
//W2 - loop index
//W3 - scratch register

        //Hardcode '0x' into our destination string
        MOV     W3, #0x30
        STRB    W3, [X0], #1
        MOV     W3, #0x78
        STRB    W3, [X0], #1

        MOV     W2, #60
loop:

        MOV     X3, X1          //SCRATCH REGISTER, PRESERVE X1
        LSR     X3, X3, X2
        AND     X3, X3, #0x0000000F //Mask off all but the right most nibble of result

        LDR     X4, =hexStr
        ADD     X4, X4, X3      //X4 ->hex[X3]
        LDRB    W4, [X4]        //X4 = *X4

        STRB    W4, [X0], #1

        SUB     W2, W2, #4
        CMP     W2, #0

        B.GE    loop            //If I >= 0 goto loop

	MOV     W3, #0          //NULL
        STRB    W3, [X0]        //STORED NULL TO MAKE destString A C-STRING


        LDR     X30, [SP], #16          //POP
        LDR     X29, [SP], #16          //POP
        LDR     X28, [SP], #16          //POP
        LDR     X27, [SP], #16          //POP
        LDR     X26, [SP], #16          //POP
        LDR     X25, [SP], #16          //POP
        LDR     X24, [SP], #16          //POP
        LDR     X23, [SP], #16          //POP
        LDR     X22, [SP], #16          //POP
        LDR     X21, [SP], #16          //POP
        LDR     X20, [SP], #16          //POP
        LDR     X19, [SP], #16          //POP

        RET     LR      //Return to caller

//putstring
//      subroutine: provided a pointer to a null terminated string, putstring will
//      display the string to the terminal
//      X0: Must point to a null terminated string
//      LR: Must contain the return address
//      All registers except X2, X3, X7, are preserved
//X2 - stores the strlength of *X(cstring)
//X3 - Saves LR bc strlength will change it
//X8 - Saves X0 bc strlegnth will change it
putstring:
          STR     X19, [SP,#-16]!         //PUSH
          STR     X20, [SP,#-16]!         //PUSH
          STR     X21, [SP,#-16]!         //PUSH
          STR     X22, [SP,#-16]!         //PUSH
          STR     X23, [SP,#-16]!         //PUSH
          STR     X24, [SP,#-16]!         //PUSH
          STR     X25, [SP,#-16]!         //PUSH
          STR     X26, [SP,#-16]!         //PUSH
          STR     X27, [SP,#-16]!         //PUSH
          STR     X28, [SP,#-16]!         //PUSH
          STR     X29, [SP,#-16]!         //PUSH
          STR     X30, [SP,#-16]!         //PUSH

          MOV     X8, X0  //X8 = X0
          BL      strlength       //X0 = strlength(*X0)
          MOV     X2, X0          //X2 = strlength(*X0)

	  //Print string
          //setup parameters to X0 and then call linux to do it
          MOV     X0, #1  //1 = stdout
          MOV     X1, X8  //string to print
          MOV     X8, #64 //Linux write system call
          SVC     0       //call linux to output to screen

          LDR     X30, [SP], #16          //POP
          LDR     X29, [SP], #16          //POP
          LDR     X28, [SP], #16          //POP
          LDR     X27, [SP], #16          //POP
          LDR     X26, [SP], #16          //POP
          LDR     X25, [SP], #16          //POP
          LDR     X24, [SP], #16          //POP
          LDR     X23, [SP], #16          //POP
          LDR     X22, [SP], #16          //POP
          LDR     X21, [SP], #16          //POP
          LDR     X20, [SP], #16          //POP
          LDR     X19, [SP], #16          //POP

          BR      LR      //return

putch:
	MOV 	X1, X0	//STORES VALUE OF X0 INTO X1 
	MOV	X0, #1	//StdOut
	MOV 	X2, #2  //LENGTH OF STRING
	MOV 	X8, #64	//WRITE SYSTEM CALL
	SVC 	0	//CALL LINUX TO OUTPUT
	MOV 	X0, X1	//STORE X1 VALUE BACK INTO X0 
	BR	LR	//RETURN
