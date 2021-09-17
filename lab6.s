.data 

chCr:	.byte	"A"

.global _start
.text

_start:

	LDR	X0, =chCr	//X0 =chCr
	BL 	putch		//BRANCH TO PUTCH FUNC

exit: 
	MOV	X0, #0		//RETURN CODE 
	MOV 	X8, #93		//CODE 93 TERMINATES PROGRAM
	svc	0		//CALL LINUX TO TERMINATE PROGRAM

//************************************************************
//PUTCH
//************************************************************
//DESIGNED TO TAKE IN A CHARACTER BYTE THAT IS STORED IN THE 
//XO REGISTER AND OUTPUTS IT TO THE CONSOLE. TAKE X0 CONTENT 
//AND STORES IT INTO X1, WHICH IS THEN USED TO PRINT THE CHAR
//ONTO THE CONSOLE. THE CHAR IS THEN LOADED BACK INTO XO, AND 
//THE RETURN IS CALLED 
//************************************************************
putch:
	STR	X0, [X1]	//STORE X1 WITH X0 VALUE 
	MOV 	X0, #1		//1 = StdOut
	MOV 	X2, #1		//LENGTH OF STRING
	MOV 	X8, #64		//LINUX WRITE SYSTEM CALL
	svc 	0		//CALL LINUX TO OUTPUT

	STR 	X1, [X0]	//STORE X1 BACK INTO X0

	BR	LR		//RETURN
