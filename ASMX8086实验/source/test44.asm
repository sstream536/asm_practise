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
      
       flaj     WORD ?
       
       
       promot   BYTE "The program is to print the 9*9 table",cr,Lf,0
       crlf     BYTE cr,Lf,0
       char1    BYTE 1 DUP(?),0
       char2    BYTE 1 DUP(?),0
       me       BYTE  1 DUP(?),0

       mulzs    BYTE 1 DUP(?),0
       brr      BYTE " ",0
       sh       BYTE 1 DUP(?),0
   
      
.CODE                           ; start of main program code
_start:
       mov  mulzs,2Ah
       mov  me,3Dh
       mov  bx,0
       mov  char1,30h
       doFirstWhile:
              inc  bx
              inc  char1
              cmp  bx,9
              jg   endFirstWhile
              mov  flaj,1
              mov  char2,31h
              doSecondWhile:
                   cmp flaj,bx
                   jg  endSecondWhile
                       mov    ax,bx
                       mul    flaj
                       mov    cx,flaj
                       
                       output char1
                       output mulzs
                       output char2
                       output me
                       cmp  ax,10
                       jl   FindOne
                            mov dl,10
                            div dl
                            mov sh,al
                            add sh,'0'
                            output sh
                            mov  sh,ah
                            add  sh,'0'
                            output sh
                            jmp  endTwo
                       
                       FindOne:
                          mov  sh,al
                          add  sh,'0'
                          output sh
                       endTwo:
                          output brr
                       inc    flaj
                       inc    char2
                       jmp    doSecondWhile
              endSecondWhile:
                       output crlf
                       jmp    doFirstWhile  
       endFirstWhile:
        INVOKE  ExitProcess, 0  ; exit with return code 0

PUBLIC _start                   ; make entry point public

END                             ; end of source code







