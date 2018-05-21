section .bss
digit:resw 1
sum:resw 1
a:resw 100
ten:resw 1
temp:resw 1
n:resw 1
result:resd 1

section .text
global _start:
_start:

call read
mov ax,word[sum]
mov word[n],ax
call fibonacci
mov ax,word[result]
mov word[sum], ax
call print

exit:
mov eax,1
mov ebx,0
int 80h

fibonacci:
pusha
cmp word[n],0
jne waves
mov word[result],0
popa
ret
waves:
cmp word[n],1
jne waves1
mov word[result],1
popa
ret
waves1:
mov cx,word[n]
dec word[n]
call fibonacci
mov dx,word[result]
mov word[n],cx
sub word[n],2
call fibonacci
add word[result],dx
popa
ret



arrayread:
pusha
movzx ecx,word[n]
mov ebx,a
 
enterarray:
push ecx 
push ebx
call read
mov ax,word[sum]

pop ebx
mov word[ebx],ax
add ebx,2
pop ecx
loop enterarray
popa
ret

arrayprint:
pusha
movzx ecx,word[n]
mov ebx,a

printarray:
push ecx

mov ax,word[ebx]
mov word[sum],ax
push ebx

call print
call spaceprint
pop ebx
add ebx,2
pop ecx
loop printarray
popa
ret



read:
pusha
mov word[sum],0
scanfirst:

mov eax,3
mov ebx,0
mov ecx,digit
mov edx,1
int 80h

cmp word[digit],0Ah
je readend
cmp word[digit],20h
je readend

sub word[digit],30h

mov ax,word[sum]
mov bx,10
mul bx
add ax,word[digit]
mov word[sum],ax

jmp scanfirst

readend:
popa
ret


print:
pusha
mov word[ten],1
mov dx,0
mov ax,word[sum]
mov cx,10
div cx
mov word[temp],ax

tens:
cmp word[temp],0
je printfirst

mov dx,0
mov ax,word[temp]
mov cx,10
div cx
mov word[temp],ax

mov ax,word[ten]
mov bx,10
mul bx
mov word[ten],ax

jmp tens

printfirst:

mov dx,0
mov ax,word[sum]
mov cx,word[ten]
div cx

mov word[digit],ax
mov word[sum],dx
add word[digit],30h

mov eax,4
mov ebx,1
mov ecx,digit
mov edx,1
int 80h

cmp word[ten],1
je printend

mov dx,0
mov ax,word[ten]
mov cx,10
div cx
mov word[ten],ax

jmp printfirst
printend:
popa 
ret


enterprint:
pusha 
mov word[digit],10
mov eax,4
mov ebx,1
mov ecx,digit
mov edx,1
int 80h

popa
ret

spaceprint:
pusha 
mov word[digit],20h
mov eax,4
mov ebx,1
mov ecx,digit
mov edx,1
int 80h

popa
ret

















 


