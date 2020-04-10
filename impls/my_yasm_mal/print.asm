section .data

        LF   equ 10
        NULL equ 0

        SYS_WRITE equ 1

        STDOUT equ 1
        STDERR equ 2
        
section .text
        
extern stringLength

        ;; Prints a null terminated string
global printString
printString:
        push rbp
        mov rbp, rsp
        push rdi

        ;; Get string length
        ;; Then call the printline function
        call stringLength

        mov rsi, rax
        call print

        pop rdi
        mov rsp, rbp
        pop rbp
        ret

        ;; Prints the characters of a non null terminated string, and adds a new line at the end
        ;; rdi <- buffer location
        ;; rsi <- nb of chars
        ;; returns the number of chars printed or an error
global print
print:
   ;; Create the stackframe
        push r12
        push r13

        mov r12, rdi            ; buffer location
        mov r13, rsi            ; Message length

        ;; Print the main message
        mov rax, SYS_WRITE
        mov rdi, STDOUT
        mov rsi, r12
        mov rdx, r13
        syscall

        ;; Check for error
        cmp rax, 0
        jl printError

printDone:  
        ;; Destroy stack frame
        pop r13
        pop r12
        ret

printError:
        ;; Do Nothing on error
        jmp printDone

        
        ;; Prints the characters of a non null terminated string, and adds a new line at the end
        ;; rdi <- buffer location
        ;; rsi <- nb of chars
        ;; returns the number of chars printed or an error
global printline
printline:
        push rbx
        
        call print
        
        ;; Save the number of characters written
        mov rbx, rax

        ;; Add the newline
        call printNewLine

        ;; Check for error
        cmp rax, 0
        jl printlineError

        ;; Add the newline char to the total and return it
        add rax, rbx
        jmp printlineDone

printlineError:
        ;; Do Nothing on error
        jmp printlineDone

printlineDone:  
        ;; Destroy stack frame
        pop rbx
        ret


        ;; Print the newline character to stdout
        ;; Takes no arguments
global printNewLine
printNewLine:
        push rbp
        mov rbp, rsp
        sub rsp, 1              ; allocate a byte to write the new line
        push rdi
        push rsi
        push rdx

        mov byte [rbp - 1], LF

        ;; Add the new line LF
        mov rax, SYS_WRITE
        mov rdi, STDOUT
        lea rsi, byte [rbp -1]
        mov rdx, 1
        syscall

        pop rdx
        pop rsi
        pop rdi
        mov rsp, rbp
        pop rbp
        ret
