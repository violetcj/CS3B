.data 
szX:	.asciz		"51"
szY:	.asciz		"9"
szAdd:	.asciz		" + " 
chCr:	.byte		10
dbX:	.dword		0

	.global _start //start of the program
	.text
_start:
//converting szX into an integer, and add into accumulator register 
	ldr X0, =szX	// X0 = &szX
	bl  ascint64	//bl Branch link stores the next LOC in the link register 
			//upon return X0 = ascint64 (*X0)

	ldr X0, =szY	//X0  =&szY
	bl ascint64	//bl Branch Link stores the next  LOC in the link register 
			// Upon return X0 = ascint64(*X0)
	
			
