; Example assembly language program -- adds two numbers
; Author:  R. Detmer
; Date:    revised 7/97

.386
.MODEL FLAT

ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD

INCLUDE io.h            ; header file for input/output

cr      EQU     0dh     ; carriage return character
Lf      EQU     0ah     ; line feed

.STACK  4096            ; reserve 4096-byte stack

.DATA    
               ; reserve storage for data
        mm      DWORD  ?
        number  DWORD  ?
        flai    DWORD  ?
        flaj    DWORD  ?
        promot  BYTE  "The programer is to find all prime from 1 to 100 ",cr,Lf,0
        answer  BYTE  "All prime is "
                BYTE  cr,Lf,0 
        crlf    BYTE  cr,Lf,0  
        value   BYTE   11 DUP(?) 

.CODE                           ; start of main program code
_start:
        output promot
        mov    mm,5
        mov    number,2
        mov    ecx,2
        mov    flaj,0        ;计数，统计素数个数
        doWhile:
               mov flai,2
               mov ecx,number
               cmp ecx,100
               jg  endWhile
               doFindWhile:
                   cmp  flai,ecx
                   je   FindPrime
                        mov eax,ecx
                        cdq
                        idiv flai
                        cmp edx,0
                        je  endFindWhile
                           
                        inc flai
                        jmp doFindWhile  
                        
                 FindPrime: 
                        mov eax,flaj
                        cdq
                        idiv mm
                        cmp edx,0
                        jne  PrintNoCrlf      
                        output crlf
                 printNoCrlf:
                        dtoa value,ecx
                        output value
                        inc flaj
                        
           endFindWhile:   
               inc number
               jmp doWhile
        endWhile:
        
        INVOKE  ExitProcess, 0  ; exit with return code 0

PUBLIC _start                   ; make entry point public

END                             ; end of source code



