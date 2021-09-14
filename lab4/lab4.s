.global _start

.data 
szMsg1:	.asciz "The sun did not shine.\n"
szMsg2: .asciz "It was too wet to play.\n"
chCr: .byte 10
.text

_start: mov	X0, #1	//1 = StdOut
	ldr X1, =szMsg1 //string to print
	mov X2, #24	//length of the string 
	mov X8, #64	//linux write system call
	svc 0	//Call linux to output the string 

	mov	X0, #1  //1 = StdOut
	ldr X1, =szMsg2 //next string to print
	mov X2, #25     //length of the string
	mov X8, #64     //linux write system call
	svc 0

//Setup the paramters to exit the program
// and then call linux to do it
	mov	X0, #0 //Use 0 return code
	mov	X8, #93 //Service code 93 terminates 
	svc	0	//Call linux to terminate 
