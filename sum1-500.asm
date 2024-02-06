section .data
	sum dw 1
section .code
	mov ax , 500
	mov cx , 0
loop :
	add cx , ax 
	dec ax
	cmp ax , 0
	jne loop
	mov eax , 4
	int 80H

