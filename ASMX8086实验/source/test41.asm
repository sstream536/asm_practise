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
     promot BYTE "Please Enter a number as the max slide ",0
     value  BYTE 40 DUP(?)
     nc     DWORD ?
     na     DWORD ?
     nb     DWORD ?
     n      DWORD ?
     
     answer  BYTE "         A         B         C ",0
     crLf    BYTE cr,Lf,0
     

.CODE                           ; start of main program code
_start:
        mov    ebx,0
        mov    ecx,0
        
        output promot
        input  value,40
        atod   value
        
        mov nc,eax
        mov n, eax
        
        mul nc
        mov nc,eax ;C*C
        output answer
        output crLf
        doFirstWhile:
             inc ebx
             mov ecx,0
             cmp ebx,n
             jge endFirstWhile  ;大于等于n则转移
             
             mov eax,ebx
             mul ebx
             mov na,eax       ;A*A
             doSecondWhile:
                inc ecx
                cmp ecx,n       
                jge endSecondWhile ;大于等于n则转移
                ;执行比较
        
                mov eax,ecx
                mul ecx         ;B*B
                mov nb,eax
                mov edx,nb
               
                add edx,na        ;A*A+B*B
                
                cmp edx,nc
                jne  stanIf        ;不等于则转移
               
                ;output answer
                dtoa value,ebx
                output value
                
                dtoa value,ecx
                output value
                
                dtoa value,n 
                output value
                output crLf
                
                jmp doSecondWhile
             stanIf:
                jmp doSecondWhile
             endSecondWhile:
                jmp doFirstWhile
                
        endFirstWhile:
       
       INVOKE  ExitProcess, 0  ; exit with return code 0

PUBLIC _start                   ; make entry point public

END                             ; end of source code











