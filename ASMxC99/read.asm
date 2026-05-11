global main ; main entry point

section .bss ; section for unallocated data

    buffer: resb 50 ; reserve 50 bytes to allocate the input

section .text
main:

    mov rax,0 ; read syscall (sys_read)
    mov rdi,0 ; file descriptor for stdin

    mov rsi,buffer ; pointer to the buffer
    mov rdx,49 ; read 49 bytes (1 less than buffer size to prevent overflow)

    syscall ; the return value is stored in rax. so the number of bytes read IS in rax

    cmp rax,0 ; check for errors, same logic as used in C
    jle exit ; if rax <= 0 (error or EOF), exit the program
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; PREPARING THE WRITE SYSCALL NOW
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    mov rdi,1 ; file descriptor for stdout
    mov rsi,buffer ; buffer containing the input data
    mov rdx,rax ; use the number of bytes actually read (from rax) as the count
    mov rax,1 ; write syscall (sys_write)

    syscall

exit:
    mov rax,60 ; exit syscall (sys_exit)
    xor rdi,rdi ; status code 0
    syscall



