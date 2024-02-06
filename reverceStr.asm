section .data
	hello db 'abcabcabcabcabc' , 0  
section .code
	global _start
_start:
	mov di , 14
	mov si , 0
; reverse string :
loop:
	mov ax ,  hello[di]
	push ax 
	mov ax , hello[si]
	mov hello[di] , ax
	pop ax
	mov hello[si] , ax
	cmp di , si
	jne loop
; print string : 
	mov di , 0
print: 
	mov cx , hello[di]
	inc di
	mov eax , 4
	int 80H
	cmp di , 14
	jne print 
;exit program :
	mov eax, 1        
    xor ebx, ebx      
    int 0x80
