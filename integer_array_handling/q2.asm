section .bss
n: resw 1
codd: resw 1
ceven: resw 1
sum: resw 1
d1: resw 1
ten: resw 1
temp: resw 1
print: resw 1
quotient: resw 1
arr: resw 50

section .data
junk: dw " "
lenjunk: equ $-junk

section .text
global _start:
_start:

call numread
mov ax,word[sum]
mov word[n],ax

movzx ecx,word[n]
mov ebx,arr
arrayread:
push ecx
push ebx
call numread
mov ax,word[sum]
pop ebx
mov word[ebx],ax
add ebx,2
pop ecx
loop arrayread

mov word[ceven],0
mov word[codd],0
movzx ecx,word[n]
mov ebx,arr

divisible:
push ecx
push ebx
mov dx,0
mov ax,word[ebx]
mov cx,2
div cx
cmp dx,0
jne iodd
inc word[ceven]
jmp end
iodd:
inc word[codd]
end:
pop ebx
add ebx,2
pop ecx
loop divisible
mov ax,word[ceven]
mov word[sum],ax
call printno
mov eax,4
mov ebx,1
mov ecx,junk
mov edx,lenjunk
int 80h
mov ax,word[codd]
mov word[sum],ax
call printno
exit:
mov eax,1
mov ebx,0
int 80h

printno:
pusha
mov word[ten],1
mov dx,0
mov ax,word[sum]
mov cx,10
div cx
mov word[quotient],ax
noten:
cmp word[quotient],0
je printf
mov dx,0
mov ax,word[quotient]
mov cx,10
div cx
mov word[quotient],ax
mov ax,word[ten]
mov bx,10
mul bx
mov word[ten],ax
jmp noten

printf:
mov dx,0
mov ax,word[sum]
mov cx,word[ten]
div cx
mov word[d1],ax
mov word[sum],dx
add word[d1],30h
mov eax,4
mov ebx,1
mov ecx,d1
mov edx,1
int 80h
cmp word[ten],1
je printend
mov dx,0
mov ax,word[ten]
mov cx,10
div cx
mov word[ten],ax
jmp printf
printend:
popa 
ret

numread:
pusha
mov word[sum],0
loopnumread:
mov eax,3
mov ebx,0
mov ecx,d1
mov edx, 1
int 80h
cmp word[d1],10
je endnumread
mov word[ten],10
mov ax ,word[sum] 
mul word[ten]
sub word[d1],30h
add ax ,word[d1]
mov word[sum],ax
jmp loopnumread
endnumread:
popa
ret