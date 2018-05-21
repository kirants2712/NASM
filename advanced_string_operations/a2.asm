section .bss
dig:resw 1
str1:resw 100
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

cmp word[n],1
je onep

mov word[i],0 
fori:

mov ax,word[i]
mov cx,word[n]
sub cx,1
cmp ax,cx
je endfori

add ax,1
mov word[j],ax

forj:
mov ax,word[j]
cmp ax,word[n]
je endforj



mov ax,word[i]
mov word[s],ax
mov ax,word[j]
mov word[e],ax
mov ebx,str1
call pallindrome


mov ax,word[flag]
cmp ax,1
je endfori
 
inc word[j]
jmp forj
endforj:



inc word[i]
jmp fori
endfori:
mov ax,word[flag]

cmp ax,1
jne noo
call yesprint

for4:
mov ax,word[i]
mov cx,2
mul cx

movzx ecx,ax
mov ebx,str1
add ebx,ecx
mov ax,word[ebx]
mov word[dig],ax
call print1
mov ax,word[i]
cmp ax,word[j]
je exit
inc word[i]
jmp for4



jmp exit

noo:
call noprint
jmp exit

onep:
call yesprint
mov ebx,str1
mov ax,word[ebx]
mov word[dig],ax
call print1


exit:
mov eax,1
mov ebx,0
int 80h

pallindrome:
pusha

mov word[flag],0


mov dx,0
mov ax,word[e]
sub ax,word[s]
mov cx,2
div cx
add ax,1
add ax,word[s]
mul cx


mov dword[dtemp],ebx
movzx ecx,ax
add dword[dtemp],ecx


mov ax,word[s]
mov cx,2
mul cx
mov edx,ebx
movzx ecx,ax
add edx,ecx
mov dword[dtemp2],edx


mov ax,word[e]
mov cx,2
mul cx
movzx ecx,ax
add ebx,ecx



mov edx,dword[dtemp2]

forpalli:


mov ax,word[ebx]


cmp ax,word[edx]
jne notpalli


cmp edx,dword[dtemp]
je palli

add edx,2
sub ebx,2

jmp forpalli
palli:
mov word[flag],1
notpalli:

popa
ret



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
