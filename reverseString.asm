section .data
    hello db 'abc', 0

section .text
    global _start

_start:
    mov edi, 2      ; Point to the second last character
    mov esi, 0       ; Point to the first character

reverse_loop:
    mov eax, [hello]
	add eax , esi 
    push eax 
    ;mov eax, hello[esi]
    ;mov hello[edi], ax
    ;pop ax
    ;mov hello[esi], ax
    inc esi
    dec edi
    cmp esi, edi
    jae exit_program
    jmp reverse_loop

exit_program:
    ; Your code continues...

    ; Print the reversed string
    mov ecx, eax
    mov ebx, 1       ; File descriptor (STDOUT)
    mov eax, 4       ; System call number for sys_write
    int 0x80

    ; Exit the program
    mov eax, 1       ; System call number for sys_exit
    xor ebx, ebx     ; Exit code 0
    int 0x80

