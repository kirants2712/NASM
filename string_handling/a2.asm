section .bss
string1: resw 50
string2: resw 50
c:resw 1
slen:resw 1
temp:resw 1
count:resw 1
d:resw 1

section .data
pal:db "palindrome",0Ah
pallen: equ $-pal
npal:db "not palindrome",0Ah
npallen: equ $-npal

section .text
global _start:
_start:

call stringread
;call stringprint1
call palindrome

exit:
mov eax,1
mov ebx,0
int 80h

palindrome:
pusha

mov ebx,string1
mov ax,word[slen]
mov word[temp],ax
loop2:
cmp word[temp],0
je exit2
mov ax,word[ebx]
push ax
add ebx,2
dec word[temp]
jmp loop2

exit2:
mov cx,word[slen]
mov word[temp],cx
mov ebx,string2
loop3:
cmp word[temp],0
je exit3
pop ax
mov word[ebx],ax
add ebx,2
dec word[temp]
jmp loop3

exit3:
mov cx,word[slen]
mov word[temp],cx
mov ebx,string1
mov edx,string2
loop4:
cmp word[temp],0
je exit4
mov ax,word[ebx]
mov cx,word[edx]
add ebx,2 
add edx,2
dec word[temp]
cmp ax,cx
jne printnot
jmp loop4
exit4:
mov eax,4
mov ebx,1
mov ecx,pal
mov edx,pallen
int 80h
jmp end
printnot:
mov eax,4
mov ebx,1
mov ecx,npal
mov edx,npallen
int 80h
end:
popa
ret

stringread:
pusha
mov word[slen],0
mov ebx,string1
loop1:
push ebx
mov eax,3
mov ebx,0
mov ecx,c
mov edx,1
int 80h
pop ebx
cmp word[c],10
je exit1
inc word[slen]
mov ax,word[c]
mov word[ebx],ax
add ebx,2
jmp loop1
exit1:
popa 
ret
stringprint1:
pusha 
mov ax,word[slen]
mov word[temp],ax
mov ebx,string2
loopx:
cmp word[temp],0
je exitx
mov ax,word[ebx]
mov word[c],ax
push ebx
mov eax,4
mov ebx,1
mov ecx,c
mov edx,1
int 80h
pop ebx
add ebx,2
dec word[temp]
jmp loopx 
exitx:
popa
ret
printno:
pusha
mov ax,word[slen]
mov word[count],0
loopp:
mov dx,0
mov cx,10
div cx
push dx
inc word[count]
cmp ax,0
je exitp
jmp loopp
exitp:
loopq:
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
je exitq
jmp loopq
exitq:
popa
ret

