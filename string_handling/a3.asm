section .bss
string1: resw 50
string2: resw 50
c:resw 1
slen:resw 1
temp:resw 1

section .text
global _start:
_start:

call stringread
call remove
call stringprint2
exit:
mov eax,1
mov ebx,0
int 80h

remove:
pusha 
mov ax,word[slen]
mov word[temp],ax
mov ebx,string1
mov edx,string2
loop2:
cmp word[temp],0
je exit2
mov cx,word[ebx]
add ebx,2
dec word[temp]
cmp cx,'A'
je reduce
cmp cx,'I'
je reduce
mov word[edx],cx
add edx,2
jmp loop2
reduce:
dec word[slen]
jmp loop2
exit2:
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

stringprint2:
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




removespace:
pusha 
mov ax,word[slen]
mov word[temp],ax
mov ebx,string1
mov edx,string2
loopa:
cmp word[temp],0
je exita
mov cx,word[ebx]
dec word[temp]
mov word[edx],cx
add edx,2
cmp cx,' '
je rm
add ebx,2
jmp loopa
rm:
add ebx,2
cmp word[ebx],' '
jne loopa
jmp rm
exita:
popa
ret


;section .bss
;sum:resw 1
;d:resw 1
;count:resw 1


;section .txt
;global _start:
;_start:
;call numread
;call printno

;mov eax,1
;mov ebx,0
;int 80h

;numread:
;pusha
;mov word[sum],0
;loop1:
;mov eax,3
;mov ebx,0
;mov ecx,d
;mov edx,1
;int 80h
;cmp word[d],10
;je exit1
;cmp word[d],20h
;je exit1
;mov ax,word[sum]
;mov cx,10
;mul cx
;sub word[d],30h
;add ax,word[d]
;mov word[sum],ax
;jmp loop1
;exit1:
;popa
;ret
;printno:
;pusha
;mov word[count],0
;mov ax,word[sum]
;loop2:
;mov dx,0
;mov cx,10
;div cx
;push dx
;inc word[count]
;cmp ax,0
;je exit2
;jmp loop2
;exit2:
;loop3:
;mov dx,0
;pop dx
;mov word[d],dx
;add word[d],30h
;mov eax,4
;mov ebx,1
;mov ecx,d
;mov edx,1
;int 80h
;dec word[count]
;cmp word[count],0
;je exit3
;jmp loop3
;exit3:
;popa
;ret
