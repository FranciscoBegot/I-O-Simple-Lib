extern my_exit ; importing the safe exit routine shown previously
global main ; main entry point. notifies the linker using the -e main flag

section .data ; data section --> initialized data

    string: db 'Write using the data label',10 ; define byte ending with a newline (10)
    tamanho: equ $ - string ; constant to calculate the string length dynamically

section .text ; execution section

main:

    mov rax,1 ; syscall write (1)
    mov rdi,1 ; file descriptor for stdout (1)

    mov rsi,string ; pointer to the string
    mov rdx,tamanho  ; size of the string
    syscall ; tell the kernel to execute this
    call my_exit ; call our external exit function
