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
      
       promot  BYTE  "The program is to print Ascii from 10h to 100h",cr,Lf,0
       line    DWORD  ?
       row     DWORD  ?
       ccf     BYTE   " ",0
       crlf    BYTE   cr,Lf,0
       char    BYTE   1 DUP(?)
           
.CODE                           ; start of main program code
_start:
       output  promot
       mov     row,0
       mov     line,0
       mov     char,0Fh
       doFirstWhile:
              inc line
              cmp line,15
              jg  endFirstWhile
              mov row,0
              doSecondWhile:
                     inc row
                     cmp row,16
                     jg  endSecondWhile
                     add char,1
                     output char
                     output ccf
                     jmp  doSecondWhile
              endSecondWhile:
                     output crlf
                     jmp  doFirstWhile
        endFirstWhile:
        
        INVOKE  ExitProcess, 0  ; exit with return code 0

PUBLIC _start                   ; make entry point public

END                             ; end of source code
