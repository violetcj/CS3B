.global _start //provide program starting address

//Load registers with data from top to bottom
_start: MOV X0, #0xFFFFFFFFFFFFFFFF
	MOV X1, #0xFFFFFFFFFFFFFFFF
	MOV X2, #0xFFFFFFFFFFFFFFFF
//Second number
	MOV X3, #0xFFFFFFFFFFFFFFFF
	MOV X4, #0xFFFFFFFFFFFFFFFF
	MOV X5, #0xFFFFFFFFFFFFFFFF
//Add the registers together and store them in x0-x2
	ADDS X8, X2, X5 //low
	ADCS X7, X1, X4 //middle
	ADC  X6, X0, X3 //high

MOV X9, #93
SVC 0
