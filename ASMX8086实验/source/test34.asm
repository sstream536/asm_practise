; Example assembly language program -- 
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
      promot      BYTE "Enter a char of letter ",cr,Lf,0
      warning     BYTE "The char isn't a letter,enter again ",0
      
      answerLtoU  BYTE "The char is a lowercase,it's uppercase is "
                  BYTE cr,Lf,0
      answerUtoL  BYTE "The char is a uppercase,it's lowercase is "
                  BYTE cr,Lf,0
      char        BYTE 1 DUP(?)
.CODE
_start:
      output   promot
      input char,1
      doGo:
        mov bl,char
        input char,1
        cmp char,0dh
        je  doWhCMP     ;cr deal the cr
      jmp doGo
      doWhCMP:
              
             cmp bl,41h
             jl  inputAgain   ;the char < A,end and input again
             cmp bl,5Ah
             jle endUppertoL ;the char <= Z,so to judge it is or not lowercase
                             ;the char is a uppercase
       cmpLower:
             cmp bl,61h     ;the char < a,end and input again
             jl  inputAgain
             cmp bl,7Ah     ;the char > z.end and input agian
             jg  inputAgain
             jmp endLowertoU ;the char is a lowercase
                   
       inputAgain:
             output warning 
             input  char,1
             mov    bl,char
             jmp    doGo
       endUppertoL:
             mov    al,bl
             add    al,32
             mov    char,al
             output answerUtoL
             output char
             jmp    endMain
       endLowertoU:
             mov    al,bl
             sub    al,32
             mov    char,al
             output answerLtoU
             output char
       endMain:
                       
              INVOKE  ExitProcess, 0  ; exit with return code 0

PUBLIC _start                   ; make entry point public

END                             ; end of source code










