#include <unistd.h> // unixlib 

int main() {
    char buffer[50]; // buffer pra receber os dados do teclado

    ssize_t entrada = read(0, buffer, sizeof(buffer)-1); // ssize_t --> tipo inteiro com sinal, usado pra representar tamanhos OU erros
                                                         // aqui passamos os dados para a variavel entrada
    if (entrada > 0) // se tudo certo...
        write(1, buffer, entrada); // printe o valor guardado com o tanto digitado em entrada

    _exit(0); // saida segura
}
