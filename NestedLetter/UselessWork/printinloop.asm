section .data
    msg db 'Enter a character: $'

section .bss
    input resb 1

section .text
    global _start

_start:

; Printing Macro
%macro printChar 1
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, 1
    int 0x80
%endmacro

; Loop Macro
%macro printLoop 1
    mov ecx, %1 ; Number of iterations
    movzx eax, byte [input] ; Load character from input
.loop:
    printChar al ; Print the character
    inc al ; Move to next character
    loop .loop ; Repeat until ecx becomes 0
%endmacro

; Main program
GetInput:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, 17
    int 0x80

    ; Read one character 
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 1
    int 0x80

    ; Check if the input is between 'A' and 'Z'
    cmp byte [input], 'A'
    jl GetInput
    cmp byte [input], 'Z'
    jg GetInput

    ; Call the loop macro to print the characters
    printLoop 6

    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80

