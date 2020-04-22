section .data

        NULL equ 0
        
        SYS_EXIT  equ 60
        SYS_BRK   equ 12

        EXIT_SUCCESS equ 0

        spacer  db " : ", NULL
        
        annoucer db "Highest address in memory", NULL
        updates db "Adding more memory with brk", NULL

section .bss

        stringBuffer resb 50
        
section .text

extern printString
extern printNewLine
extern stringLength
extern int2string

extern getHighestAddress

%macro printHighAddress 0
        lea rdi, [annoucer]
        call printString

        lea rdi, [spacer]
        call printString

        call getHighestAddress
        lea rsi, byte [stringBuffer]
        mov rdi, rax
        call int2string

        mov rdi, rsi
        call printString

        call printNewLine

        call getHighestAddress
%endmacro
        
        
global _start
_start:

        printHighAddress
        printHighAddress

        mov rdi, rax
        add rdi, 200            ; Allocate 200 bytes at the end of the image
        mov rax, SYS_BRK
        syscall

        printHighAddress
                
string_testDone:        
        
        mov rax, SYS_EXIT
        mov rdi, EXIT_SUCCESS
        syscall

