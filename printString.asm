section .data
	hello db "lets do something " , 0 

section .code 
		global _start

_start:
		mov ax , 4
		lea cx , [hello]
		mov dx , 19
		int 80H
		mov ah , 4Ch
		int 80h

		
