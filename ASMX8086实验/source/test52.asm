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
       promot   BYTE   "The program is to find primes from 100 to 200",cr,Lf,0
       cmm      BYTE   " ",0
       crlf     BYTE   cr,Lf,0
       number   DWORD  ?
       flai     DWORD  ?
       value    BYTE   11 DUP(?)
 PUBLIC _start                   ; make entry point public      
.CODE                           ; start of main program code
_start:
       output   promot
       mov      number,99
       mov      flai,0
       
       doFirstWhile:
                 inc number
                 cmp number,200
                 jg  endFirstWhile
                 mov   eax,number
                 push  eax
                 call  findPrime
                 add   esp,4
                 ;
                     cmp  eax,0
                     je   endSecond
                     inc  flai
                     dtoa value,number
                     output value
                     output cmm
                        mov eax,flai
                        mov ecx,5
                        cdq
                        idiv ecx
                        cmp  edx,0
                        je   printCrlf
                        
                 endSecond: 
                     jmp doFirstWhile
                 printCrlf:
                        output crlf
                     jmp doFirstWhile
             
       endFirstWhile:
        INVOKE  ExitProcess, 0  ; exit with return code 0


findPrime PROC  NEAR32
              push  ebp
              mov   ebp,esp
              
              mov   ebx,2
              mov   eax,[ebp+8]
              mov   ecx,eax
              docuWhile:
                    cmp ebx,ecx
                    je  found
                    mov eax,ecx
                    cdq
                    idiv ebx
                    cmp  edx,0
                    je   noFound
                    inc  ebx
                    jmp  docuWhile
              found:
                    mov eax,1
                    jmp endcuWhile
              noFound:
                    mov eax,0    
              endcuWhile:
              pop   ebp
              ret
   findPrime ENDP

END                             ; end of source code








