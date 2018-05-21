section .bss
digit:resd 1
sum:resd 1
a:resw 100
ten:resd 1
temp:resd 1
n:resw 1
result:resd 1


section .text
global _start:
_start:

call read
mov ax,word[sum]

mov word[n],ax

call fact
mov eax,dword[result]
mov dword[sum],eax
call print 






exit:
mov eax,1
mov ebx,0
int 80h

fact:
pusha
cmp word[n],0
jne waves
mov dword[result],1
popa
ret
waves:
movzx ecx,word[n]
dec word[n]
call fact
mov eax,dword[result]
mul ecx
mov dword[result],eax
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
mov dword[ten],1
mov edx,0
mov eax,dword[sum]
mov ecx,10
div ecx
mov dword[temp],eax

tens:
cmp dword[temp],0
je printfirst

mov edx,0
mov eax,dword[temp]
mov ecx,10
div ecx
mov dword[temp],eax

mov eax,dword[ten]
mov ebx,10
mul ebx
mov dword[ten],eax

jmp tens

printfirst:

mov edx,0
mov eax,dword[sum]
mov ecx,dword[ten]
div ecx

mov dword[digit],eax
mov dword[sum],edx
add dword[digit],30h

mov eax,4
mov ebx,1
mov ecx,digit
mov edx,1
int 80h

cmp dword[ten],1
je printend

mov edx,0
mov eax,dword[ten]
mov ecx,10
div ecx
mov dword[ten],eax

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

















 


