; Example assembly language program -- adds four numbers to calculate theirs average
; Author:  Karllen
; Date:    10/5/2014

.386
.MODEL FLAT

ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD

INCLUDE io.h            ; header file for input/output

cr      EQU     0dh     ; carriage return character
Lf      EQU     0ah     ; line feed

.STACK  4096            ; reserve 4096-byte stack

.DATA
   promot1 BYTE  "Please Enter four numbers to caclute the average",cr,Lf, 0
   promot2 BYTE  "Please Enter a number from 0 to 100! ",0
   promot3 BYTE  "The number isn't from 0 to 100,please Enter a right number ",0 
   value   BYTE  16 DUP(?)
   
   number  DWORD ?
   sum     DWORD ?
 
   answer  BYTE  "The four numbers' average is "
   ave     BYTE  11 DUP(?)
           BYTE  cr,LF,0

.CODE
_start:
   output  promot1
   mov     sum,0
   mov     ebx,0

firstagain:
   output  promot2
   input   value,16
   atod    value
 judge:
   cmp     eax,100        ;num >100 转移重新输入
   jg      doif
   cmp     eax,0          ;num <0   转移重新输入
   jl      doif
   jmp     addSum         ;满足 0<=num<=100
   doif:
   output  promot3
   input   value,16
   atod    value
   jmp     judge
 addSum:
   inc  ebx
   add  sum,eax
   cmp  ebx,4
   jne  firstagain        ;end firstagain  
   mov  eax,sum
   cdq                    ;将sum拓展为64位
   idiv  ebx
   dtoa ave,eax
   output answer

        INVOKE  ExitProcess, 0  ; exit with return code 0

PUBLIC _start                   ; make entry point public

END                             ; end of source code











