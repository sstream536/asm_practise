; Example assembly language program -- adds two numbers
; Author:  karllen
; Date:    revised 5/2014

.386
.MODEL FLAT

ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD

INCLUDE io.h            ; header file for input/output

cr      EQU     0dh     ; carriage return character
Lf      EQU     0ah     ; line feed

.STACK  4096            ; reserve 4096-byte stack

.DATA
        promot1  BYTE "Enter a number from 0 to 9 to",cr,Lf
                 BYTE "calculate it's cubic number",cr,Lf,0
        promot2  BYTE "The number ",0
        
        value    BYTE 11 DUP(?)
        warning  BYTE "The number is wrong,please enter a new number"
                 BYTE cr,Lf
                 BYTE "from 0 to 9",cr,Lf,0
        answer   BYTE "The number cubic number is"
        cubicnm  BYTE 11 DUP(?)
                 BYTE cr,Lf,0
.CODE
_start:
        output   promot1
        output   promot2
        input    value,11
        atod     value
        doWhiCmp:
                 cmp eax,0
                 jl  endWhiCmp  ;eax < 0 
                 cmp eax,9
                 jg  endWhiCmp  ;eax > 9
                 
                 jmp doRight    ;0<=eax<=9
                 
         
        endWhiCmp:              ;deal the wrong number,to enter new number
                 output warning 
                 input  value,11
                 atod   value
                 jmp    doWhiCmp
                 
        doRight:
                 mov    ebx,eax
                 mul    ebx       ;eax = eax * eax
                 mul    ebx       ;eax = eax * eax *eax  
                 
                 dtoa   cubicnm,eax
                 output answer
        
              INVOKE  ExitProcess, 0  ; exit with return code 0

PUBLIC _start                   ; make entry point public

END                             ; end of source code





