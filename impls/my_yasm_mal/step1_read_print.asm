section .data

        LF   equ 10
        NULL equ 0

        SYS_READ  equ 0
        SYS_WRITE equ 1
        SYS_EXIT  equ 60
        SYS_BRK   equ 12
        
        STDIN  equ 0
        STDOUT equ 1
        STDERR equ 2
        
        EXIT_SUCCESS equ 0

        BUFFERSIZE equ 100
        
        prompt    db "user> ", NULL
        promptLen equ $-prompt-1 ;$ evaluates to the position of the current command

        errorMsg db "Error on read: ", NULL
        errorMsgLen equ $-prompt-1

section .bss
        
        buffer resb BUFFERSIZE                   ;100 character buffer for the user input
        
section .text

global _start
_start:

        ;; Print the prompt
        mov rax, SYS_WRITE
        mov rdi, STDOUT
        lea rsi, byte [prompt]
        mov rdx, promptLen
        syscall

        ;; Get the user input
        lea rdi, byte [buffer]
        mov rsi, BUFFERSIZE
        call readline

        cmp rax, 0
        je step0Done

        ;; TODO Do I have to compare again?
        cmp rax, 0
        jl step0ReadError
        
        ;; call eval
        
        ;; call print
        lea rdi, byte [buffer]
        mov rsi, rax
        call printline

        jmp _start              ; Loop back 

step0ReadError:

        mov rbx, rax            ; Save the error code
        
        mov rax, SYS_WRITE
        mov rdi, STDOUT
        lea rsi, byte [errorMsg]
        mov rdx, errorMsgLen

        ;; TODO, output the error code as well

        ;; Exit with the error code
        mov rax, SYS_EXIT
        mov rdi, rbx
        syscall
        

step0Done:

        mov rax, SYS_EXIT
        mov rdi, EXIT_SUCCESS
        syscall


        
        ;; Stub for full read function
        ;; rdi <- buffer address
        ;; rsi <- size of the buffer in bytes
        ;; returns nb of chars read, or 0 for EOF, <0 if error
global read
read:
        call readline
        ret

        ;; Split a mal string into a list of symbols
        ;; Mostly string operations, will have to rely on
        ;; external functions for all the list stuff
global tokenize
tokenize:
        ;; TODO
        ret 
        
        ;; Read in the characters until the new line
        ;; rdi <- buffer address
        ;; rsi <- size of the buffer in bytes
        ;; returns nb of chars read, or 0 for EOF, <0 if error
global readline
readline:
        push rbp
        mov rbp, rsp
        sub rsp, 1              ; Allocate space for a single character on the stack
        push rbx
        push r12
        push r13
        push r14

        mov rbx, 0              ;This is the character count register
        
        mov r12, rdi            ; Save buffer location
        mov r13, rsi            ; Save buffer size
        mov r14, 0              ; Will contain the character read 

getSingleCharacter:
        ;; Get single character from stdin
        mov rax, SYS_READ
        mov rdi, STDIN
        lea rsi, byte [rbp - 1] ; The allocated byte buffer on stack
        mov rdx, 1
        syscall

        ;; Check for an error
        ;; If 0 then it's the end of the file, EOF
        cmp rax, 0
        jle readlineGotError

        ;; Get the value read
        mov r14b, byte [rbp -1]

        ;; Check if newline character
        cmp r14b, LF
        je readlineGotEndChar

        ;; Check that the buffer is not overflown
        ;; If it is then we just keep looping until there's an LF
        cmp rbx, r13
        jae getSingleCharacter
        
        ;; All good so we'll write the char in the buffer
        inc rbx                 ; One more character has been read
        mov byte [r12], r14b

        ;; Go the next memory location in the buffer
        inc r12
        jmp getSingleCharacter
        
readlineGotEndChar:
        mov rax, rbx
        jmp readlineDone

readlineGotError:
        ;; TODO Just print that there was an error and return negative
        ;; For the moment this just returns the error that was received
        jmp readlineDone
        
readlineDone:
        pop r14
        pop r13
        pop r12
        pop rbx
        mov rsp, rbp            ; Deallocate any remaining space
        pop rbp
        ret
        

        ;; For the moment this will only return the string that was read 
global eval
eval:

        ;; Print a NULL terminated string to the console
        ;; This should be printing the string representation of the object
global print
print:
        call printline
        ret

