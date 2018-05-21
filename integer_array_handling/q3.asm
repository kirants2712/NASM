section .bss
n: resw 1
quotient: resw 1
sum: resw 1
d1: resw 1
swap1: resw 1
swap2: resw 1
swap3: resw 1
ten: resw 1
i: resw 1
j: resw 1
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

;bubble_sort_start
mov word[i],0
loopi:
mov ax,word[n]
sub ax,1
sub ax,word[i]
mov word[swap1],ax
mov word[j],0
loopj:
call bsort
inc word[j]
mov ax,word[swap1]
cmp ax,word[j]
ja loopj
inc word[i]
mov ax,word[n]
sub ax,1
cmp ax,word[i]
ja loopi
;bubble_sort_end

movzx ecx,word[n]
mov ebx,arr
printarr:
push ecx
push ebx
mov ax,word[ebx]
mov word[sum],ax
call printno
mov eax,4
mov ebx,1
mov ecx,junk
mov edx,lenjunk
int 80h
pop ebx
inc ebx
inc ebx
pop ecx
loop printarr

exit:
mov eax,1
mov ebx,0
int 80h


bsort:
pusha
mov word[swap2],0
mov word[swap3],0
mov ebx,arr
mov ax,word[j]
mov cx,2
mul cx
mov word[swap2],ax
add ebx,dword[swap2];check using eax abx
mov ax,word[ebx]
mov word[swap2],ax
inc ebx
inc ebx
mov ax,word[ebx]
mov word[swap3],ax
mov ax,word[swap2]
movzx ecx,ax
mov ax,word[swap3]
movzx edx,ax
cmp ecx,edx
ja exitbsort
mov ax,word[swap2]
mov word[ebx],ax
dec ebx
dec ebx
mov ax,word[swap3]
mov word[ebx],ax
exitbsort:
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
