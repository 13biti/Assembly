.data
    hello db 'Hello, Assembly' , 0

.code
    global _start

_start:
    ; write 'Hello, Assembly!' to stdout
    mov eax, 4         ; system call number for sys_write
    mov ebx, 1         ; file descriptor 1 is stdout
    mov ecx, hello     ; pointer to the message
    mov edx, 16        ; length of the message
    int 80H           ; call kernel
    ; exit the program
    mov eax, 1         ; system call number for sys_exit
    xor ebx, ebx       ; exit code 0
    int 80H           ; call kernel

