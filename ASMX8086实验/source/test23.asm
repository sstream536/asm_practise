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
        promot  BYTE "Please Enter a char ",cr,Lf,0
        answer  BYTE "The three char is "
                BYTE cr,Lf,0
        befchar BYTE 1 DUP(?)
        char    BYTE 1 DUP(?)
      
        aftchar BYTE 1 DUP(?)
.CODE
_start:
        output promot
        doWh:
           input char,1
           cmp   char,0d
           je    endWh     ;只会处理最后一个字符
        endWh:
        mov    al,char
        sub    al,1
        mov    befchar,al   
        
        add    al,1    
        add    al,1
        mov    aftchar,al    
        
        sub    al,1  
        mov    char,al   
        
        
        output answer
        output befchar     ;依次输出befchar char aftchar
      

        INVOKE  ExitProcess, 0  ; exit with return code 0

PUBLIC _start                   ; make entry point public

END                             ; end of source code







