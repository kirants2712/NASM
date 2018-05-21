section .data
zero:dq 0.000000
two:dq 2.000000
one:dq 1.000000
four:dq 4.000000
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
format7: db "(%lf,%lf )",10,0

section .bss
k:resq 1
n:resd 1
n1:resd 1
b:resq 1
c2:resd 1
i:resd 1
j:resd 1
it:resd 1
ima:resq 1
temp:resq 1
temp1:resq 1
temp2:resq 1
arr:resq 50
fac:resq 1
sign:resq 1
pow:resq 1
val:resq 1
count:resd 1

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

call sfree
fldpi
fmul qword[two]

fld qword[k]
fprem 
fstp qword[k]
call sfree


mov dword[n],1
call sfree
fld1
fstp qword[sign]
fldz
fstp qword[val]
call sfree
;mov dword[count],20
infi:
;cmp dword[count],0
;je endd

;dec dword[count]

fild dword[n]
fstp qword[fac]
call factorial

call power

fld qword[pow]
fdiv qword[fac]
fmul qword[sign]


fld qword[val]
fadd st1
fstp qword[val]
fldz

fcomip st1
je endd 

call sfree
fld qword[sign]
fchs
fstp qword[sign]

add dword[n],2

jmp infi

endd:

push dword[val + 4]
push dword[val]
push format2
call printf


fld qword[k]
fsin
fstp qword[temp]
push dword[temp + 4]
push dword[temp]
push format2
call printf

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


factorial:
call sfree

fld qword[fac]

starti:
fld qword[fac]
fld1
fsubr st1

fld1
fcomip st1
jnb endfac

fst qword[fac]
fmul st2
ffree st2
ffree st1


jmp starti

endfac:

fstp qword[fac]
fstp qword[fac]
fstp qword[fac]



ret

power:
call sfree
fld qword[k]
mov ecx,dword[n]
cmp ecx,1
je endpow

dec ecx
po:
fmul qword[k]

loop po
fstp qword[pow]
ret
endpow:
fstp qword[pow]
ret





