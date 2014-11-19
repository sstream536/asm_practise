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
       str1    BYTE 80 DUP(?)
       str2    BYTE 80 DUP(?)
       value   BYTE 11 DUP(?)
       length1 DWORD ?
       length2 DWORD ?  
       
       promot1 BYTE "Please Enter String1",cr,Lf,0
       promot2 BYTE "Please Enter String2",cr,Lf,0
       crlf    BYTE  cr,Lf,0
       
       answerYes BYTE "Match",cr,Lf,0
       answerNo  BYTE "No Match",cr,Lf,0       
PUBLIC _start                   ; make entry point public       
.CODE                          ; start of main program code             
_start:
       output promot1
       input  str1,80
       lea    eax,str1
       push   eax
       call   strlen
       add    esp,4
       mov    length1,eax
       dtoa   value,eax
       output value
       output crlf
       
       output promot2
       input  str2,80
       lea    eax,str2
       push   eax 
       call   strlen   
       add    esp,4  
       mov    length2,eax
       dtoa   value,eax
       output value
       output crlf
       
       mov  edx,length2
       ;;cmp String1 and String2
       cmp    eax,edx        ;如果长度不相等
       jne    endCMP              ;则结束
       ;比较
       lea esi,str1
       lea edi,str2
       mov ecx,length2  ;比较的长度
       repe cmpsb 
       jz   found       ;比较成功则跳转
      
       endCMP:
              output answerNo
              jmp endMatch
       found:
              output answerYes
        ;
       endMatch:
       
        INVOKE  ExitProcess, 0  ; exit with return code 0

strlen      PROC    NEAR32
            push    ebp             
            mov     ebp, esp
                                       
            sub     eax, eax        
            mov     ebx, [ebp+8]    
whileChar:  cmp     BYTE PTR [ebx], 0  
            je      endWhileChar   
            inc     eax           
            inc     ebx            
            jmp     whileChar      
endWhileChar:
            pop     ebp
            ret               
strlen      ENDP
END                             ; end of source code










