section .data

        NULL equ 0
        
        SYS_EXIT  equ 60

        EXIT_SUCCESS equ 0

        spacer  db " : ", NULL
        
        string1 db "Hey there here's a sentence", NULL
        string2 db "fuck", NULL
        string3 db "Here comes the Corona", NULL

section .bss

        stringBuffer resb 50
        
section .text

extern printString
extern printNewLine
extern stringLength
extern int2string
        
%macro checkString 1
        lea rdi, [%1]
        call stringLength
        mov rbx, rax
        
        call printString

        lea rdi, byte [spacer]
        call printString
        
        lea rsi, byte [stringBuffer]
        mov rdi, rbx
        call int2string

        mov rdi, rsi
        call printString
        
        call printNewLine
%endmacro
        
global _start
_start:

        checkString string1
        checkString string2
        checkString string3
                
string_testDone:        
        
        mov rax, SYS_EXIT
        mov rdi, EXIT_SUCCESS
        syscall

