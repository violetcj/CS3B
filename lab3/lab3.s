.global _start //provide program starting address

//Load registers with some data
// first 64 bit number is 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
_start: MOV X2, #0xFFFFFFFFFFFFFFFF
	MOV X3, #0xFFFFFFFFFFFFFFFF //Assem will change to MOVN

//Second 64-bit num is 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
	MOV X4, #0xFFFFFFFFFFFFFFFF
	MOV X5, #0xFFFFFFFFFFFFFFFF

	SUBS X1, X3, X5 //Lower order 64 bits, Subtracts x5 from x3 and stores in x1, stores carry flag
	SBC X0, X2, X4 //Higher order 64-bits, subtracts x4 and x2, and stores in x0 with carry from last operation

//Setup the paraeters to exit the program
// and then call linux to do it
//W0 is the return code and will be what we calculated above

	MOV X8, #93 // Service command code 93 terminates
	SVC 0 //Call linx to terminate the program.
 