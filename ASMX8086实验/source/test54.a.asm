; Example assembly language program --
; Author: Karllne
; Date:    revised 05/2014

.386
.MODEL FLAT

ExitProcess PROTO NEAR32 stdcall, dwExitCode:DWORD

INCLUDE io.h            ; header file for input/output

cr      EQU     0dh     ; carriage return character
Lf      EQU     0ah     ; line feed

.STACK  4096            ; reserve 4096-byte stack
        
       
        
.DATA                   ; reserve storage for data

        prompt  BYTE  "Please enter a number",cr,Lf,0
        fl      DWORD ?
        value   BYTE 11 DUP(?),0
        char    BYTE 1 DUP(?)
        
PUBLIC _start        
.CODE                           ; start of main program code
_start:
        output prompt
        input  value,11
        atod   value
        push eax
        call byteInput
        add  esp,4
        
        INVOKE  ExitProcess, 0  ; exit with return code 0
 
byteInput PROC NEAR32
          push ebp
          mov  ebp,esp
          
          mov  fl,0
          mov  ebx,10
          mov  eax,[ebp+8]
          doWh:
              cdq
              idiv ebx
              push edx
              inc fl
              cmp eax,0
              je  enddoWh
              
             
              jmp doWh
          enddoWh: 
          
          doPrint:
                 
                 cmp fl,0
                 je  enddoPrint
                 dec fl
                 pop edx 
                 mov char,dl
                 add char,'0'
                 output char
                 jmp doPrint
          enddoPrint:
          pop ebp
          ret
          
byteInput ENDP

END                             ; end of source code





