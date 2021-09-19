.data 
chCr: 	.asciz 	"A\n"

.global _start
.text

_start:
	LDR	X0, =chCr
	BL	putch		//BRANCH INTO PUTCH FUNC

exit:
	MOV	X0, #0		//RETURN CODE
	MOV	X8, #93		//SERVICE CODE 93; TERMINATES
	svc 	0		//CALL LINUX TO TERMINATE

//******************************************************************
//PUTCH
//******************************************************************
//DESIGNED TO PRINT A CHARACTER BYTE FROM REGISTER X0. WILL STORE 
//THE VALUE INTO A DIFFERENT REGISTER TEMPORARILY TO CALL THE 
//OUTPUT CALL. WILL THEN RETURN THE VALUE BACK INTO X0 AFTER THE 
//VALUE IS PRINTED TO THE CONSOLE
putch:
	MOV 	X1, X0		//STORES VALUE OF X0 INTO X1 
	MOV	X0, #1		//StdOut
	MOV 	X2, #2		//LENGTH OF STRING
	MOV 	X8, #64		//WRITE SYSTEM CALL
	svc 	0		//CALL LINUX TO OUTPUT

	MOV 	X0, X1		//STORE X1 VALUE BACK INTO X0 
	BR	LR		//RETURN
