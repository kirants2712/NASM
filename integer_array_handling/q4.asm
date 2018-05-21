section .data
junk: dw " "
lenjunk: equ $-junk
newrow: dw "",0Ah
newrowlen: equ $-newrow

section .bss
n: resw 1
pos1: resd 1
pos2: resd 1
sum: resw 1
d1: resw 1
ten: resw 1
temp: resw 1
print: resw 1
quotient: resw 1
arr: resw 50
i: resw 1
j: resw 1
row: resw 1
column: resw 1
swap1: resw 1
swap2: resw 1
counter: resw 1

section .text
global _start:
_start:
;reading n
call numread
mov ax,word[sum]
mov word[row],ax
mov word[column],ax
mov bx,word[row]
mul bx
mov word[n],ax
;reading array
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

mov word[pos1],0
mov word[pos2],0
mov word[i],0
mov ax,word[column]
sub ax,1
mov word[j],ax
movzx ecx,word[column]
loopi:
push ecx
;row major implication
mov ax,word[row]
mov cx,word[i]
mul cx
add ax,word[i]
mov cx,2
mul cx
movzx edx,ax
mov dword[pos1],edx
mov ax,word[row]
mov cx,word[i]
mul cx
add ax,word[j]
mov cx,2
mul cx
movzx edx,ax
mov dword[pos2],edx
call swap
inc word[i]
dec word[j]
pop ecx
loop loopi

call matrix

mov eax,1
mov ebx,0
int 80h


swap:
pusha
mov ebx,arr
add ebx,dword[pos1]
mov cx,word[ebx]
mov word[swap1],cx
mov ebx,arr
add ebx,dword[pos2]
mov ax,word[ebx]
mov word[swap2],ax
mov ebx,arr
add ebx,dword[pos1]
mov ax,word[swap2]
mov word[ebx],ax
mov ebx,arr
add ebx,dword[pos2]
mov ax,word[swap1]
mov word[ebx],ax
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
mov ecx,junk
mov edx,lenjunk
int 80h
pop ebx
add ebx,2
;inc ebx
;inc ebx
push ebx

mov dx,0
mov ax,word[counter]
mov cx,word[row]
div cx
cmp dx,0
je printnewline
jmp continue
printnewline:
mov eax,4
mov ebx,1
mov ecx,newrow
mov edx,newrowlen
int 80h

continue:
add word[counter],1
pop ebx
pop ecx
loop printrow
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