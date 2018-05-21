section .data
space:dw " "
slen: equ $-space
enter:dw "",0Ah
elen: equ $-enter

section .bss
index:resd 1
d1: resw 1
sum: resw 1
ten: resw 1
temp: resw 1
counter:resw 1
n: resw 1
row: resw 1
col: resw 1
arr:resw 50
;arr2:resw 50
quotient:resw 1
i:resw 1
j:resw 1
;p:resw 1
;q:resw 1
;temp1:resw 1
;temp2:resw 1
;dia1:resd 1
;dia2:resd 1

section .text
global _start:
_start:

call numread
mov ax,word[sum]
mov word[row],ax
cmp word[row],0
je exit
call numread
mov ax,word[sum]
mov word[col],ax
cmp word[col],0
je exit
mov ax,word[row]
mov cx,word[col]
mul cx
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

call matrix

mov word[i],0
mov word[j],0

label1:
mov ebx,arr
call index1
add ebx,dword[index]
mov ax,word[ebx]
mov word[sum],ax
push ebx
call printno
mov eax,4
mov ebx,1
mov ecx,space
mov edx,slen
int 80h
pop ebx
inc word[j]
mov ax,word[col]
cmp word[j],ax
jne label1
inc word[i]
mov ax,word[row]
cmp word[i],ax
je exit
sub word[j],1
jmp label2

label2:
mov ebx,arr
call index1
add ebx,dword[index]
mov ax,word[ebx]
mov word[sum],ax
push ebx
call printno
mov eax,4
mov ebx,1
mov ecx,space
mov edx,slen
int 80h
pop ebx
dec word[j]
cmp word[j],0
jl new
jmp label2
new:
inc word[i]
mov ax,word[row]
cmp word[i],ax
je exit
add word[j],1
jmp label1

exit:
mov eax,1
mov ebx,0
int 80h


index1:
pusha
mov ax,word[col]
mov cx,2
mul cx
mov word[index],ax
mov ax,word[i]
mov cx,word[index]
mul cx
mov word[index],ax
mov ax,word[j]
mov cx,2
mul cx
add word[index],ax
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
cmp word[d1],20h
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

matrix:
pusha
mov word[counter],1
movzx ecx,word[n]
mov ebx,arr
printrow:
push ecx
mov ax,word[ebx]
mov word[sum],ax
push ebx
call printno
mov eax,4
mov ebx,1
mov ecx,space
mov edx,slen
int 80h
pop ebx
add ebx,2
push ebx

mov dx,0
mov ax,word[counter]
mov cx,word[col]
div cx
cmp dx,0
je printnewline
jmp continue
printnewline:
mov eax,4
mov ebx,1
mov ecx,enter
mov edx,elen
int 80h

continue:
add word[counter],1
pop ebx
pop ecx
loop printrow
popa
ret
