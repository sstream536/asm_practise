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
promot1  BYTE "Please enter a number as a Fahrenheit ",cr,Lf,0
value    BYTE 11 DUP(?)
answer   BYTE "The Temperature is"
va       BYTE 11 DUP(?)
         BYTE cr,Lf,0

;C = (5/9) * (F-32)

.CODE
_start:
       output promot1
       input  value,11
       atod   value
       sub    eax,32   ;eax = F-32
       mov    ebx,eax  ;ebx = F-32

       mov    eax,1    ;eax = eax/edx  5/9

       mul    ebx      ;eax*ebx
        
       dtoa   va,eax
       output answer

        INVOKE  ExitProcess, 0  ; exit with return code 0

PUBLIC _start                   ; make entry point public

END                             ; end of source code




