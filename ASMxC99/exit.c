#include <unistd.h> // standard unix library (posix)
#include <sys/syscall.h>

int main()
{ // binary entry point

    // equivalent to the exit system call
    _exit(0); 

    // another way to achieve the same result using the syscall interface
    syscall(SYS_exit_group, 0); 
}
