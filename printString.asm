section .data
	hello db "lets do something " , 0 

section .text 
		global _start

_start:
		mov ax  , 09H
		lea dx , [hello]
		int 21h
		mov ah , 4Ch
		int 21h

		
