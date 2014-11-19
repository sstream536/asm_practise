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
      promotX  BYTE "Please enter a number as X ",0
      promotY  BYTE "Please enter a number as Y ",0
      value    BYTE 11 DUP(?)
      answer   BYTE "The a is"
        rsa    BYTE 11 DUP(?)
               BYTE cr,Lf,0
.CODE
_start:
      output   promotX       ;ebx = x
      input    value,11
      atod     value
      mov      ebx,eax
      
      output   promotY       ;eax = y
      input    value,11
      atod     value
      
      cmp      ebx,0
      jl       lzero         ;ebx < 0
      
      cmp      ebx,0
      jg       oo            ;x>0
      oo: 
           cmp eax,0 
           jl  oneg          ;y<0
      cmp      eax,0         ;ebx>=0
      jge      ltwozero      ;eax>=0
     lzero:
           cmp    eax,0
           jl     ltwzero      ;eax < 0    
     oneg:
           mov     eax,0
           dtoa   rsa,eax
           output answer
           jmp    endCMP      
     ltwzero:
           mov    eax,1
           neg    eax
           dtoa   rsa,eax
           output answer
           jmp    endCMP
     ltwozero:
           mov    eax,1
           dtoa   rsa,eax
           output answer
     endCMP:
      
              INVOKE  ExitProcess, 0  ; exit with return code 0

PUBLIC _start                   ; make entry point public

END                             ; end of source code








