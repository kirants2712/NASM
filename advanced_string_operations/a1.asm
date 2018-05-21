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
i:resw 1
j:resw 1
nn:resw 1
pos:resw 1
max:resw 1
loco:resw 1
count:resw 1
counti:resw 1
d:resw 1

section .data
space:dw " "

slen: equ $-space
enter:dw "",0Ah
elen: equ $-enter

section .text
global _start:
_start:

mov edi,str1
call sread

mov word[max],0;-------------------max=0
mov ax,word[n]
mov word[loco],ax;-----------------loco=n
mov word[s],0;---------------------s=0
mov word[e],0;---------------------e=0

mov word[pos],600;-----------------pos=600
mov dword[dtemp],str1
mov ax,word[n]
mov word[nn],ax;-------------------nn=n
call findcaps

mov ax,word[pos];----------------pos= index of caps
mov word[sum],ax;----------------sum=pos
cmp ax,600
je nocaps

mov word[s],ax;-------------------s=index of caps

forr:

mov ax,word[s]
mov cx,2
mul cx
movzx ecx,ax
mov ebx,str1
add ebx,ecx
add ebx,2
cmp word[ebx],0
je nocaps

mov dword[dtemp],ebx

mov ax,word[n]
mov cx,word[s]
sub ax,cx
sub ax,1
mov word[nn],ax
mov word[pos],600
call findcaps

mov ax,word[pos];----------------pos= index of caps
mov word[sum],ax;----------------sum=pos
;call print
cmp ax,600
je nocaps
mov word[e],ax
mov ebx,str1
call counter

mov ax,word[e]
mov word[s],ax

jmp forr

nocaps:

mov ax,word[max]
call printno
call enterprint
exit:
mov eax,1
mov ebx,0
int 80h


sread:
pusha
CLD
mov word[n],0

sreadarray:
mov eax,3
mov ebx,0
mov ecx,dig
mov edx,1
int 80h
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

findcaps:
pusha

mov ax,word[nn]
movzx ecx,ax
mov esi,dword[dtemp]
CLD
  loo:
       push ecx
       LODSW
       cmp ax,'A'
       jnb cond2A
       jmp next12
       cond2A:
       cmp ax,'Z'
       jna add
       jmp next12
       next12:
       pop ecx
  loop loo
jmp noadd
add:
pop ecx
mov dword[dtemp],ecx
mov ax,word[dtemp]
mov cx,word[n]
sub cx,ax
mov word[pos],cx;-----------pos returns position of capital letter
noadd:
popa
ret

counter:;-----------------------------------
pusha


CLD
mov edi,str2
mov ecx,400

mzero:;----------------initialised string2 to 0
mov ax,0
STOSW
loop mzero




mov word[count],0;-----------count=0



mov ax,word[s]
mov cx,2
mul cx
mov edx,str1
movzx ecx,ax
add edx,ecx
add edx,2






mov ax,word[e]
sub ax,word[s]
cmp ax,2
jl endcounter
sub ax,1
movzx ecx,ax



lo:
push ecx




mov ax,word[edx]


cmp ax,'A'
jnb cond2A12
jmp next1212

cond2A12:
cmp ax,'Z'
jna add12
jmp next1212

next1212:




pusha
mov ax,word[edx]
mov cx,2
mul cx
mov word[sum],ax
popa



mov ax,word[sum]


movzx ecx,ax
mov ebx,str2
add ebx,ecx
mov cx,word[ebx]



cmp cx,0
ja occurred

inc word[count]
mov ax,1

mov word[ebx],ax



occurred:
add12:
add edx,2

pop ecx
loop lo


endcounter:

mov ax,word[count]
cmp ax,word[max]
ja changemax
jmp nomaxchange
changemax:
mov word[max],ax

nomaxchange:
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

printno:
pusha
mov word[counti],0
loop2:
mov dx,0
mov cx,10
div cx
push dx
inc word[counti]
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
dec word[counti]
cmp word[counti],0
je exit3
jmp loop3
exit3:
popa
ret



