%macro CreatBox 1 
	push ax
	push cx	
	mov ecx , 0x0
	
	; cx = 2k-1 , and k is place of Char in table 
	; for example for C ( 3th in alphabet) cx = 5
	mov cx , %1
	sub cx , 64d
	shl cx , 1
	dec cx 			
	push cx 
	mov ax , 0;
;traking the state of the lines
state:
	;if rich 2k-1th line 
	inc cx
	cmp ax , cx
	je end
	;break the output into two parts. 
	;Above the middle line and the middle line - below the middle line
	shr cx , 1
	cmp ax , cx
	pushf
	shl cx , 1
	dec cx
	popf
	jl top
	jg down
	je IInc
;Making the top and middle lines
IInc: 
	inc ax 
	jmp state
top:
	push ax
	jmp Creator

;Create the rest of the lines from the middle to the bottom
down:
	push ax
	push cx
	sub cx , ax
	mov ax , cx
	pop cx
	jmp Creator
	
;Break each line into three parts. 
;Combined letters - fixed letters and reversed combined letters
Creator:	
	printFor ax ; print forward , A B C D E , . . . . 
	push cx
	shl ax , 1
	sub cx , ax
	shr ax , 1
	; print ax+65 th character cx time 
	printOne cx , ax ; print one char XXXXXX 
	pop cx
	;print ax character befor A
	printBack ax; print backword . . . . , E D C B A
	mov byte [char] , 10d
	printChar char
	pop ax
	inc ax
	jmp state
end:
	pop cx
	pop ax
%endmacro

;print reversed combined letters , from 0x41+ax to 0x41
%macro printBack 1
	push ax
	push cx
	mov cx , %1
	mov ax , 0
loop4:
	cmp ax , cx 
	je end4
	push ax
	mov eax , 0x00000000
	mov ax , 0x40
	add ax , cx
	mov [char], eax
	printChar char
	pop ax
	dec cx 
	jmp loop4
end4:
	pop cx
	pop ax
%endmacro

;print fixed letters , using cx 
%macro printOne 2
	push ax 
	push cx 
	;building chararcter !
	;inc cx 
	add ax , 0x41
	mov [char] , ax 
	mov ax , 0
loop3:
	cmp ax , cx
	je end3
	printChar char 
	inc ax 
	jmp loop3
end3:
	pop cx 
	pop ax
%endmacro
;print combined letters , from from 0x41 to ax
%macro printFor 1
	push ax
	push cx
	mov ax , %1
	mov cx , 0
loop2:
	cmp ax , cx 
	je end2
	push ax
	mov ax , 0x41
	add ax , cx
	push cx
	mov [char], eax
	printChar char
	pop cx
	pop ax
	inc cx 
	jmp loop2
end2:
	pop cx
	pop ax
%endmacro

;macro that will print each character 
%macro printChar 1
	push ax
	push cx
	mov eax , 4 
	mov ebx , 1
	mov ecx , %1
	mov edx , 1
	int 0x80
	mov ecx , 0x00000000
	pop cx
	pop ax
%endmacro

;main!!
section .data
    msg db 'Enter a character: $'
section .bss
    input resb 1
	char resb 1
section .text
    global _start
_start:

GetInput :
	;testing print function
	;mov ax , 0x43
	;mov [char] , ax
	;printChar char
	
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
		
    mov al, [input]
	cmp al , 0x41
	jl GetInput
	cmp al , 0x5A 
	jg GetInput
	mov [char] , al
	CreatBox [char]

    add al, 0b10
	mov [input] , al
    ; Print the result character
    mov eax, 4
    mov ebx, 1
    mov ecx, input
    mov edx, 1
    int 0x80
    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80


