
section .data

        LF   equ 10
        NULL equ 0
        
        SYS_BRK equ 12
        
        currentBreak dq 0 ; The highest address in memory
                          ; Use this for brk alocation

        highestUsedAddress dq 0
        
section .text

global alocateBits
alocateBits:
        ;; TODO
        ret

global getHighestAddress
getHighestAddress:
        ;; TODO
        push rdi
        
        mov rax, SYS_BRK
        mov rdi, 0
        syscall

        pop rdi
        
        ret
