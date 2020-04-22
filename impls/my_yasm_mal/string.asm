section .data

        NULL equ 0
        INT2STRINGBUFFERSIZE equ 20

section .text

        ;; Count characters in the string until the NULL character
        ;; rdi <- string start
        ;; returns: character count
global stringLength
stringLength:

        push rcx
        mov rcx, 0

stringLengthLoopback:       
        
        cmp  byte [rdi + rcx], NULL
        je stringLengthDone
        
        inc rcx
        jmp stringLengthLoopback
        
stringLengthDone:
        mov rax, rcx
        
        pop rcx
        ret

        ;; Convert integer to a string
        ;; rdi <- integer (unsigned)
        ;; rsi <- destination adress
        ;; returns string address
        ;; TODO for now this will only do decimal
        ;; TODO Make a create string alternative so caller doesn't have to create a buffer location
global int2string
int2string:
        push rbp
        mov rbp, rsp
        sub rsp, INT2STRINGBUFFERSIZE ; Will be filled up backwards, then copied away
        sub rsp, 1              ; Add room for the null character to be added
        push rdx
        push rcx
        push r12
        push r13
        
        mov rcx, 1
        mov r12, 10

        ;; Add the null terminator
        lea r13, byte [rbp -1]
        mov byte [r13], NULL

        ;; Initial number
        mov rax, rdi
        
int2stringLoopback:     
        inc rcx
        dec r13
        
        xor rdx, rdx
        div r12

        ;; Add the new character
        add dl, 48              ; Conver to the ascii character
        mov byte [r13], dl

        ;; Check if too many digits have been taken
        cmp rcx, INT2STRINGBUFFERSIZE
        ja int2stringDone

        ;; Check if the digit is exhausted
        cmp rax, 0
        jne int2stringLoopback
        
int2stringDone:
        ;; Copy the string to destination
        mov r12, rdi            ;Preserve the register around the funcall
        
        mov rdi, r13
        call stringCopy
        
        mov rdi, r12

        ;; Returning whatever stringCopy returns

        pop r13
        pop r12
        pop rcx
        pop rdx
        mov rsp, rbp
        pop rbp
        ret

        ;; Copy null terminated string
        ;; rdi <- source
        ;; rsi <- destination
        ;; returns length of string copied
global stringCopy
stringCopy:
        push rcx
        push rdi
        push rsi
        push r13
        
stringCopyLoopback:

        ;; Check for end of the string
        cmp byte [rdi + rax], NULL
        je stringCopyDone

        mov r13b, byte [rdi + rax]
        mov byte [rsi + rax], r13b

        inc rax
        jmp stringCopyLoopback
        

stringCopyDone:

        ;; Move the last remaining byte
        mov byte [rsi + rax], NULL

        pop r13
        pop rsi
        pop rdi
        pop rcx
        ret
