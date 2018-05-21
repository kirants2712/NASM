section .bss
dig:resw 1
str1:resw 100
str2:resw 400
vow:resw 1
digit: resw 1
sum: resw 1
ten: resw 1
temp: resw 1
n: resw 1
arr:resw 50
s:resw 1
e:resw 1
flag:resw 1
dtemp:resd 1
dtemp2:resd 1
location:resd 1
i:resw 1
j:resw 1
count:resw 1
max:resw 1
min:resw 1
prev:resw 1
start:resw 1
last:resw 1

section .data
space:dw " "
slen: equ $-space
enter:dw "",0Ah
elen: equ $-enter
yes:dw "YES",0Ah
ylen: equ $-yes
no:dw "NO",0Ah
nlen: equ $-no




section .text
global _start:
_start:

mov edi,str1
call sread
;mov esi,str1
;call sprint

mov ax,word[n]
cmp ax,0
je exit
movzx ecx,ax
push ecx
STD

mov esi,str1
mov ax,word[n]
sub ax,1
mov cx,2
mul cx
movzx edx,ax
add esi,edx
mov word[count],0
mov word[max],0
mov word[min],600
pop ecx
for:
push ecx

LODSW

cmp ax,' '
jne skip

mov ax,word[count]
cmp ax,0
je endloop
cmp ax,word[max]
jl nextcc
mov word[max],ax

nextcc:
cmp ax,word[min]
ja nextcc1
mov word[min],ax

nextcc1:
mov word[count],0
jmp endloop

skip:
inc word[count]
endloop:
pop ecx
loop for


mov ax,word[count]
mov word[last],ax
cmp ax,0
je nextcc4
cmp ax,word[max]
jl nextcc3
mov word[max],ax

nextcc3:
cmp ax,word[min]
ja nextcc4
mov word[min],ax

nextcc4:
jmp goaway
ended:
mov word[max],0
mov word[min],0

goaway:

mov ax,word[max]
mov word[sum],ax
call print
call enterprint
mov ax,word[min]
mov word[sum],ax
call print
call enterprint

;---------------------------------------------------------

mov ax,word[n]
movzx ecx,ax
push ecx
STD

mov esi,str1
mov ax,word[n]
sub ax,1
mov cx,2
mul cx
movzx edx,ax
add esi,edx
mov word[count],0
pop ecx

for123:
push ecx

LODSW

cmp ax,' '
jne skip123

mov dword[location],esi
add dword[location],4
mov ax,word[count]
cmp ax,0
je endloop123
cmp ax,word[max]

je printmaximum

retprintmaximum:

mov word[count],0

jmp endloop123

skip123:
inc word[count]

endloop123:
pop ecx
loop for123


mov ax,word[last]
cmp ax,word[max]
jne exitxyz

mov ebx,str1
movzx ecx,ax
loopxyz:
push ecx
mov ax,word[ebx]
mov word[dig],ax
call print1
add ebx,2
pop ecx
loop loopxyz
exitxyz:
call enterprint

;------------------------------------------------------

mov ax,word[n]
movzx ecx,ax
push ecx
STD

mov esi,str1
mov ax,word[n]
sub ax,1
mov cx,2
mul cx
movzx edx,ax
add esi,edx
mov word[count],0
pop ecx

for1234:
push ecx

LODSW

cmp ax,' '
jne skip1234

mov dword[location],esi
add dword[location],4
mov ax,word[count]
cmp ax,0
je endloop1234
cmp ax,word[min]

je printminimum

retprintminimum:

mov word[count],0

jmp endloop1234

skip1234:
inc word[count]

endloop1234:
pop ecx
loop for1234


mov ax,word[last]
cmp ax,word[min]
jne exitxyz1

mov ebx,str1
movzx ecx,ax
loopxyz1:
push ecx
mov ax,word[ebx]
mov word[dig],ax
call print1
add ebx,2
pop ecx
loop loopxyz1
exitxyz1:

call enterprint




exit:
mov eax,1
mov ebx,0
int 80h

printmaximum:
pusha

mov ebx,dword[location]
mov ax,word[max]
movzx ecx,ax

loo123:
push ecx

mov ax,word[ebx]
mov word[dig],ax

call print1

add ebx,2
pop ecx
loop loo123
call spaceprint
popa
jmp retprintmaximum

printminimum:
pusha

mov ebx,dword[location]
mov ax,word[min]
movzx ecx,ax

loo1234:
push ecx

mov ax,word[ebx]
mov word[dig],ax

call print1

add ebx,2
pop ecx
loop loo1234
call spaceprint
popa
jmp retprintminimum

read1:
pusha 
mov eax,3
mov ebx,0
mov ecx,dig
mov edx,1
int 80h 
popa
ret


print1:
pusha 
mov eax,4
mov ebx,1
mov ecx,dig
mov edx,1
int 80h 
popa
ret

sread:
pusha
CLD
mov word[n],0
sreadarray:

call read1
cmp word[dig],0Ah
je endsarrayread

mov ax,word[dig]
STOSW
inc word[n]
jmp sreadarray
endsarrayread:
mov ax,0
mov word[edi],ax
popa
ret



sprint:
pusha
CLD
sprintarray:
LODSW
mov word[dig],ax

cmp word[dig],0
je endsarrayprint

call print1

jmp sprintarray
endsarrayprint:
popa
ret


arrayread:
pusha
movzx ecx,word[n]
mov ebx,arr
 
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
mov ebx,arr

printarray:
push ecx

mov ax,word[ebx]
mov word[sum],ax
push ebx

call print
mov eax,4
mov ebx,1
mov ecx,space
mov edx,slen
int 80h
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

mov eax,4
mov ebx,1
mov ecx,enter
mov edx,elen
int 80h

popa
ret

spaceprint:
pusha 

mov eax,4
mov ebx,1
mov ecx,space
mov edx,slen
int 80h

popa
ret

yesprint:
pusha

mov eax,4
mov ebx,1
mov ecx,yes
mov edx,ylen
int 80h

popa
ret

noprint:
pusha 

mov eax,4
mov ebx,1
mov ecx,no
mov edx,nlen
int 80h

popa
ret


