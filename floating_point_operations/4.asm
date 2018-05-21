section .data
two:dq 2.000000
four:dq 4.000000
low:dq 0.000000
msg1: db "Enter number:",0
mlen1:equ $-msg1  
msg2: db "Enter no: of elements :",0
mlen2:equ $-msg2  
msg3: db "Enter K :",0
mlen3:equ $-msg3  
format1: db "%lf",0
format5: db "%d",0
format6: db "%d",10,0
format2: db "%lf",10,0
format3: db "%lf + i*(%lf)",10,0
format4: db "%lf - i*(%lf)",10,0
format7: db "(%lf,%lf )",10,0

section .bss
k:resq 1
n:resd 1
n1:resd 1
b:resq 1
c:resq 1
i:resd 1
j:resd 1
it:resd 1
ima:resq 1
temp:resq 1
temp1:resq 1
temp2:resq 1
arr:resq 50

section .text
global main:
extern scanf
extern printf

main:

mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,mlen3
int 80h

push k
push format1
call scanf

mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,mlen2
int 80h

push n
push format5
call scanf


mov dword[i],0
fori:

mov edx,dword[i]
mov ecx,dword[n]
cmp edx,ecx
jb continue
jmp endfori

continue:


mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,mlen1
int 80h

push temp
push format1
call scanf

fld qword[temp]

mov eax,dword[i]
mov ecx,8
mul ecx

mov ebx,arr
add ebx,eax

fstp qword[ebx]

inc dword[i]
jmp fori

endfori:


mov dword[i],0
mov eax,dword[n]
dec eax
mov dword[n1],eax
fori2:

mov eax,dword[i]
cmp eax,dword[n1]
jb continuei2
jmp endfori2

continuei2:
inc eax
mov dword[j],eax
forj:

ffree st0
ffree st1
mov eax,dword[j]
cmp eax,dword[n]
jb continuej
jmp endforj
continuej:

mov eax,dword[i]
mov ecx,8
mul ecx
mov ebx,arr
add ebx,eax
fld qword[ebx]

mov eax,dword[j]
mov ecx,8
mul ecx
mov edx,arr
add edx,eax
fadd qword[edx]
fsub qword[k]
;fabs


fld qword[low]

fcomi st1
je swap
jmp skip

swap:

call sfree

mov eax,dword[i]
mov ecx,8
mul ecx
mov ebx,arr
add ebx,eax
fld qword[ebx]

mov eax,dword[j]
mov ecx,8
mul ecx
mov edx,arr
add edx,eax
fld qword[edx]

fstp qword[temp1]
fstp qword[temp2]

push dword[temp1 + 4]
push dword[temp1]
push dword[temp2 + 4]
push dword[temp2]
push format7
call printf

skip:

inc dword[j]
jmp forj
endforj:

inc dword[i]
jmp fori2
endfori2:


exit:
mov eax,1
mov ebx,0
int 80h

sfree:
ffree st0
ffree st1
ffree st2
ffree st3
ffree st4
ffree st5
ffree st6
ffree st7
ret





