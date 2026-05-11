global my_exit ; global entry point. must be linked with the -e main option to show the linker the entry point. by default, it uses _start

section .text

my_exit:
    ; this syscall is used to return a success status at the end of a program
    ; it is necessary to prevent segmentation fault errors
    ; with it, we terminate a process in a safe manner

    mov rax,60 ; system call number defined in the linux syscall table
               ; these can be found in arch/x86/entry/syscalls/syscall_64.tbl
    xor rdi,rdi ; exit code 0, meaning everything is correct

    syscall ; the kernel will check rax and map it to the requirements of the exit system call


            ; to confirm the return value, use the command: echo $?
