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
        promot1_1 BYTE "grade   1 ?  ",0
        promot1_2 BYTE "percent 1 ?  ",0
        promot2_1 BYTE "grade   2 ?  ",0
        promot2_2 BYTE "percent 2 ?  ",0
        promot3_1 BYTE "grade   3 ?  ",0
        promot3_2 BYTE "percent 3 ?  ",0
        
        value     BYTE 11 DUP(?)
        onec      DWORD  ?
        twoc      DWORD  ?
        threec    DWORD  ?

        answer    BYTE "score is: "
        average   BYTE 11 DUP(?)            
                  BYTE cr,Lf,0
.CODE
_start:
        output   promot1_1    ;enter first grade and percent
        input    value,11
        atod     value
        mov      onec,eax
        mov      ebx,eax
        output   promot1_2 
        input    value,11
        atod     value
        mul      ebx          ;calculate first grade*percent
        mov      onec,eax
        
        
        output   promot2_1    ;enter second grade and percent
        input    value,11
        atod     value
        mov      twoc,eax
        mov      ebx,eax
        output   promot2_2
        input    value,11
        atod     value
        mul      ebx          ;calculate second grade*percent
        mov      twoc,eax
        
       
        output   promot3_1    ;enter the third grade and percent
        input    value,11
        atod     value
        mov      threec,eax
        mov      ebx,eax
        output   promot3_2
        input    value,11
        atod     value
        mul      ebx          ;calculate the third grade and percent
        mov      threec,eax
        
        add      eax,onec     ;to calculate sum
        add      eax,twoc
        add      eax,threec
        
        mov      ebx,100
        div      ebx          ;to calculate the average
        
        dtoa     average,eax
        output   answer
        
        INVOKE  ExitProcess, 0  ; exit with return code 0

PUBLIC _start                   ; make entry point public

END                             ; end of source code





