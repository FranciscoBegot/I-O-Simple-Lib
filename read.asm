global main ; main

section .bss ; secao de dados nao alocados

    buffer: resb 50 ; buffer pra alocar a entrada

section .text
main:

    mov rax,0 ; chamada de read
    mov rdi,0 ; fd stdin

    mov rsi,buffer ; ponteiro pra buffer
    mov rdx,49 ; 1 a menos pra evitar estouro

    syscall ; o valor de retorno fica em rax. entao os dados lidos ESTAO em rax

    cmp rax,0 ; evitar errors, mesma logica do C
    jle exit ; se for menor ou igual a 0 (error) sai do programa
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;PREAPRANDO A WRITE SYSCALL AGORA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    mov rdi,1 ; stdout fd
    mov rsi,buffer ; dados inseridos
    mov rdx,rax ; quantidade de dados inseridas
    mov rax,1 ; syscall write

    syscall

exit:
    mov rax,60
    xor rdi,rdi
    syscall




