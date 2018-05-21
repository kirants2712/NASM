section .bss
string: resb 50
c:resb 1
size:resw 1
section .data
error:db "-"
len: equ $-error
section .text
global _start:
_start:

call stringread

call stringprint

exit:
mov eax,1
mov ebx,0
int 80h

stringread:
pusha 
mov word[size],0
mov ebx,string
loop1:
push ebx
mov eax,3
mov ebx,0
mov ecx,c
mov edx,1
int 80h
pop ebx
cmp byte[c],10
je exit1
inc word[size]
mov al,byte[c]
;cmp al,'z'
;je z
;cmp al,'Z'
;je Z
inc al
mov byte[ebx],al
inc ebx
jmp loop1
;z:
;mov al,'a'
;mov byte[ebx],al
;inc ebx
;jmp loop1
;Z:
;mov al,'A'
;mov byte[ebx],al
;inc ebx
;jmp loop1 
exit1:
mov byte[ebx],10
popa 
ret

stringprint:
pusha 
mov ebx,string
loop2:
mov al,byte[ebx]
mov byte[c],al
cmp al,10
je exit2
push ebx
mov eax,4
mov ebx,1
mov ecx,c
mov edx,1
int 80h
pop ebx
inc ebx
jmp loop2 
exit2:
popa
ret
