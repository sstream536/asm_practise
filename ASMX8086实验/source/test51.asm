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
     i       DWORD ?
     j       DWORD ?
     temp    DWORD ?
     promot1 BYTE "Please Enter ten numbers to sort from min to max",cr,Lf,0
     array   DWORD 10 DUP(?)
     promot2 BYTE "The numbers that are sorted is",cr,Lf,0
     value   BYTE  11 DUP(?)
             BYTE cr,Lf,0

.CODE

sortArray PROC NEAR32
          push ebp                 ;建立堆栈
          mov  ebp,esp
          
          mov  i,0
          mov edx,10
         ; mov  ebx,[ebp+8]         ;取得数组地址
          sortFirst:
               mov  ebx,[ebp+8] 
               inc i
               cmp i,9
               jg  endsortFirst    ;大于9则跳转，
               
               sub edx,i              ;求edx-i
               mov j,0
               sortSecond:
                    inc j
                    cmp j,edx
                    jg  endsortSecond  ;大于10-i则转移
                    mov eax,[ebx]
                    mov ecx,[ebx+4]
                  
                    cmp eax,ecx  ; cmp [ebx],[ebx+4]
                    jl  endCMP         ;[ebx]<[ebx+4]则转移
                    
                    mov edx,eax
                    mov [ebx],ecx
                    mov [ebx+4],edx
                 
                    
                    ;swap
                endCMP:      
                    add ebx,4
                    mov edx,10
                    jmp sortSecond
            
            endSortSecond:
                    jmp sortFirst
            endsortFirst:

            pop ebp
            ret
            
sortArray   ENDP
                   
_start:
     
     output promot1
     mov    ecx,0
     lea    ebx,array
     
     doFirstWhile:
            inc ecx
            cmp ecx,10
            jg  endFirstWhile   ;大于10则结束
            
            input value,11
            atod  value
            mov   [ebx],eax
            add   ebx,4
            jmp   doFirstWhile
     endFirstWhile:
     
     lea  eax,array
     push eax
     call sortArray
     add  esp,4
     
     output promot2
     mov    ecx,0
     lea    ebx,array
     
     doSecondWhile:
            inc  ecx
            cmp  ecx,10
            jg   endSecondWhile
            dtoa value,[ebx]
            output value
            add  ebx,4
            jmp  doSecondWhile
     
     endSecondWhile:

        INVOKE  ExitProcess, 0  ; exit with return code 0

PUBLIC _start                   ; make entry point public

END                             ; end of source code










