section .bss
sia:resw 1
sie:resw 1
sii:resw 1
sio:resw 1
siu:resw 1
string: resb 50
c:resb 1
sum:resw 1
count:resw 1
d:resw 1

section .data
pa:db "a-"
palen:equ $-pa
pe:db "e-"
pelen:equ $-pe
pi:db "i-"
pilen:equ $-pi
po:db "o-"
polen:equ $-po
pu:db "u-"
pulen:equ $-pu
enter:db "",0Ah
elen:equ $-enter
section .text
global _start:
_start:
mov word[sia],0
mov word[sie],0
mov word[sii],0
mov word[sio],0
mov word[siu],0
call stringread
mov eax,4
mov ebx,1
mov ecx,pa
mov edx,palen
int 80h
mov ax,word[sia]
call printno
call printenter
mov eax,4
mov ebx,1
mov ecx,pe
mov edx,pelen
int 80h
mov ax,word[sie]
call printno
call printenter
mov eax,4
mov ebx,1
mov ecx,pi
mov edx,pilen
int 80h
mov ax,word[sii]
call printno
call printenter
mov eax,4
mov ebx,1
mov ecx,po
mov edx,polen
int 80h
mov ax,word[sio]
call printno
call printenter
mov eax,4
mov ebx,1
mov ecx,pu
mov edx,pulen
int 80h
mov ax,word[siu]
call printno
call printenter
exit:
mov eax,1
mov ebx,0
int 80h


printenter:
pusha 
mov eax,4
mov ebx,1
mov ecx,enter
mov edx,elen
int 80h
popa
ret


stringread:
pusha 
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
mov al,byte[c]
cmp al,'a'
je a
cmp al,'A'
je a
cmp al,'e'
je e
cmp al,'E'
je e
cmp al,'i'
je i
cmp al,'I'
je i
cmp al,'o'
je o
cmp al,'O'
je o
cmp al,'u'
je u
cmp al,'U'
je u
mov byte[ebx],al
inc ebx
jmp loop1
a:
add word[sia],1
mov byte[ebx],al
inc ebx
jmp loop1
e:
add word[sie],1
mov byte[ebx],al
inc ebx
jmp loop1 
i:
add word[sii],1
mov byte[ebx],al
inc ebx
jmp loop1 
o:
add word[sio],1
mov byte[ebx],al
inc ebx
jmp loop1 
u:
add word[siu],1
mov byte[ebx],al
inc ebx
jmp loop1 
exit1:
mov byte[ebx],10
popa 
ret

printno:
pusha
mov word[count],0
loop2:
mov dx,0
mov cx,10
div cx
push dx
inc word[count]
cmp ax,0
je exit2
jmp loop2
exit2:
loop3:
mov dx,0
pop dx
mov word[d],dx
add word[d],30h
mov eax,4
mov ebx,1
mov ecx,d
mov edx,1
int 80h
dec word[count]
cmp word[count],0
je exit3
jmp loop3
exit3:
popa
ret
