section .data
section .text
	global _start

_start :
	push 12
	push 0x005
	push 80H
	pop eax
	pop ax
	pop ax
	pushf 
	popf 
	mov eax, 1      
    xor ebx, ebx    
    int 80H
