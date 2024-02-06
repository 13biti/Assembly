.data
    hello db 'Hello, Assembly' , 0
	sum dw 1 
.code
    global _start

_start:
	mov eax , 00000004H
    int 80H           ; call kernel
    ; exit the program
    mov eax, 1         ; system call number for sys_exit
    xor ebx, ebx       ; exit code 0
    int 80H           ; call kernel

