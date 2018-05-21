section .data
format1: db "%lf", 0
format2: db "%lf", 10
pi:dq 3.141592
q:dq 2.000000
section .bss
float1:resq 1


section .text
global main
extern scanf
extern printf

main:
call scan
fmul qword[q]
fmul qword[pi]
call prinf

exit:
mov eax,1
mov ebx,0
int 80h

scan:
pusha
push ebp
mov ebp,esp
sub esp,8

lea eax,[esp]
push eax
push format1
call scanf
fld qword[ebp - 8]

mov esp,ebp
pop ebp
popa
ret

prinf:
push ebp
mov ebp,esp
sub esp,8

fst qword[ebp - 8]
push format2
call printf
mov esp, ebp
pop ebp

ret
