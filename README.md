Hi!
I made this for a small university presentation/project and decided to share it here.
This project demonstrates how basic I/O works at a low level using Linux system calls, comparing implementations in C99 and x86/x86_64 Assembly.

This project also includes a small modular I/O library that wraps:

sys_read
sys_write
sys_exit

The goal is to provide a minimal abstraction layer over raw syscalls while keeping full control over low-level behavior.
