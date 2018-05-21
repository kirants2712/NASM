section .data
two:dq 2.000000
four:dq 4.000000
msg1: db "Enter A :", 0Ah
mlen1:equ $-msg1  
msg2: db "Enter B :", 0Ah
mlen2:equ $-msg2  
msg3: db "Enter C :", 0Ah
mlen3:equ $-msg3  
format1: db "%lf",0
format2: db "%lf",10,0
format3: db "%lf + i*(%lf)",10,0
format4: db "%lf - i*(%lf)",10,0

section .bss
a:resq 1
b:resq 1
c:resq 1
b2a:resq 1
b2:resq 1
ac4:resq 1
b24ac:resq 1
rb24ac:resq 1
ima:resq 1
temp:resq 1

section .text
global main:
extern scanf
extern printf

main:

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,mlen1
int 80h

push a
push format1
call scanf

mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,mlen2
int 80h


push b
push format1
call scanf

mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,mlen3
int 80h

push c
push format1
call scanf

fld qword[b]
fchs
fdiv qword[two]
fdiv qword[a]
fstp qword[b2a]


fld qword[c]
fmul qword[a]
fmul qword[four]
fstp qword[ac4]

fld qword[b]
fmul qword[b]
fst qword[b2]
fsub qword[ac4]
fstp qword[b24ac]

fld qword[b24ac]
fldz
;st0=b^2-4ac
;st1=0
fcomi st1
jnb imagine


real:
fld qword[b24ac]
fsqrt
fst qword[rb24ac]
fdiv qword[a]
fdiv qword[two]
fstp qword[ima]

fld qword[b2a]
fadd qword[ima]
fstp qword[temp]

push dword[temp + 4]
push dword[temp]
push format2
call printf

fld qword[b2a]
fsub qword[ima]
fstp qword[temp]

push dword[temp + 4]
push dword[temp]
push format2
call printf

jmp exit
imagine:


fld qword[b24ac]
fchs
fsqrt
fdiv qword[two]
fdiv qword[a]
fstp qword[ima]



push dword[ima + 4]
push dword[ima]
push dword[b2a + 4]
push dword[b2a]
push format3
call printf

push dword[ima + 4]
push dword[ima]
push dword[b2a + 4]
push dword[b2a]
push format4
call printf


exit:
mov eax,1
mov ebx,0
int 80h


sfree:

fstp qword[temp]
fstp qword[temp]
fstp qword[temp]
fstp qword[temp]
fstp qword[temp]
fstp qword[temp]
fstp qword[temp]
fstp qword[temp]
fstp qword[temp]

ret


