#include <unistd.h> // lib padrao do unix (posix)
#include <sys/syscall.h>
int main()
{ // entrada do binario


    _exit(0); // correspondente da chamada exit
    syscall(SYS_exit_group, 0); // outra forma de fazer o mesmo

}
