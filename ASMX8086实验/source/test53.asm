; Example assembly language program -- adds two numbers
; Author:  Karllen
; Date:    revised 05/2014

.386
.MODEL FLAT

ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD

INCLUDE io.h            ; header file for input/output

cr      EQU     0dh     ; carriage return character
Lf      EQU     0ah     ; line feed

.STACK  4096            ; reserve 4096-byte stack
        
.DATA                   ; reserve storage for data
        prompt   BYTE "The program is to find the factorial from 1 to 10",cr,Lf,0
        numInput BYTE "Please enter a number from 1 to 10",cr,Lf,0
        answer   BYTE "The number factorial is"
        value    BYTE 11 DUP(?)
                 BYTE cr,Lf,0

PUBLIC _start         
.CODE 
_start:
                                ; start of main program code
        output prompt 
        
        doInput:
           output numInput
           input  value,11
           atod   value
           cmp    eax,1
           jl     doInput
           cmp    eax,10
           jg     doInput
        push   eax
        call   findFactorial
        add    esp,4
        
        dtoa   value,eax
        output answer 
        
        INVOKE  ExitProcess, 0  ; exit with return code 0
                  ; make entry point public
        
 findFactorial  PROC NEAR32
                  push ebp
                  mov  ebp,esp
                  
                  mov  eax,[ebp+8]
                  mov  ebx,eax
                  cmp  eax,1
                  je   endFindWhile     
                  doFindWhile:
                           dec ebx
                           cmp ebx,1
                           je  endFindWhile
                           mul ebx
                           jmp doFindWhile
                  endFindWhile:          
                  pop  ebp
                  ret
   findFactorial  ENDP
END                             ; end of source code










