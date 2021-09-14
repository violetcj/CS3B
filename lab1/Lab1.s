//
//Assembler program to print "CJ Carroll!"
// to std out 
//
//X0 -X2 - parameters to linux function services 
//X8 - Linux function number 
//

.global _start //Provide program starting address 

// Setup the parameters to print CJ Carroll
//and then call linux to do it. 

_start: mov	X0, #1	//1 = StdOut
	ldr X1, =helloworld //string to print
	mov X2, #13	//length of the string 
	mov X8, #64	//linux write system call
	svc 0	//Call linux to output the string 

//Setup the paramters to exit the program
// and then call linux to do it
	mov	X0, #0 //Use 0 return code
	mov	X8, #93 //Service code 93 terminates 
	svc	0	//Call linux to terminate 
.data 
helloworld:	.ascii "CJ Carroll!\n"
