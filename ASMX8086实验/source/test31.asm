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
     promot  BYTE "请输入一段字符串，分别统计字母，数字，和其他字符的个数",cr,Lf,0
     value   BYTE 1 DUP(?)
     
     answerLetter BYTE "字母的个数："
           letter BYTE 11 DUP(?)
                  BYTE cr,Lf, 0
     aswerNumber  BYTE "数字的个数："
           number BYTE 11 DUP(?)
                  BYTE cr,Lf, 0
     answerOther  BYTE "其他字符的个数："
           other  BYTE 11 DUP(?)
                  BYTE cr,Lf, 0

.CODE
_start:
     mov eax,0
     mov ebx,0
     mov ecx,0
    
     output promot
     while:
          input value,1
          cmp   value,0dh
          je    endWhile       ;如果回车则结束
          cmp   value,30h      ;30h = 0
          jl    forOther       ;小于30h为字符
          ;下面执行大于等于30h
          cmp   value,3Ah      ;39h = 9
          jl    forNumber      ;小于3Ah为数字
          ;下面执行大于等于3Ah
          cmp   value,41h      ;小于41h为字符
          jl    forOther       ;41h = A
          ;下面执行大于41h
          cmp   value,5Bh      ;小于5Bh为大写字母
          jl    forLetter      ;5Bh = |
          ;下面执行大于5Bh
          cmp   value,61h      ;61h = a
          jl    forOther
          ;下面执行大于61h
          cmp   value,7Bh      ;7Bh = {
          jl    forLetter
          ;下面执行7Bh到结束
          jmp   forOther
       
     forLetter:
               inc eax
               jmp while
     forNumber:
               inc ebx
               jmp while
     forOther:
               inc ecx
               jmp while
    
endWhile:          
     dtoa  letter,eax
     dtoa  number,ebx
     dtoa  other ,ecx
  
     output answerLetter
     output answerNumber
     output answerOther

        INVOKE  ExitProcess, 0  ; exit with return code 0

PUBLIC _start                   ; make entry point public

END                             ; end of source code




