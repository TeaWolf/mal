
section .data

        LF   equ 10
        NULL equ 0
        
        SYS_BRK equ 12

        BRK_PAGESIZE equ 200
        
        endImageAddress dq 0
        highestUsedAddress dq 0

        ;; Data structure to track allocated memory
        ;; allocate at then end of the image via brk
        ;; Use more calls to brk when there's a need for space
        ;; Max adress is always tracked
        ;; Max address needs to be initialized and first
        
section .text

global initMemoryAllocator
initMemoryAllocator:
        ;; TODO set the highest used Address and create tracking struct

        call getHighestAddress
        mov qword [endImageAddress], rax
        mov qword [highestUsedAddress], rax
        ret
        

global alocateBytes
alocateByts:
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
