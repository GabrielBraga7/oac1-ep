#       Programa em linguagem Assembly que, ao receber um numero N
#       e outro numero x (como entrada pelo usuario), calcula o
#       maior grau a que eh possivel elevar x sem que o resultado
#       ultrapasse o valor de N.
########## EP1
.text
.globl main
main:

	subu $sp,$sp,16 #abre espaço na pilha para 2 valores de tipo double

        la $a0, $mensagemEntrada 	#passa a mensagem a ser exibida, no caso, a mensagem de "Digite o valor de x"
        jal printStr                    #chama a função de imprimir texto
        jal readDouble                  #lê o valor double inserido e coloca no registrador $f0
        sdc1 $f0, 12($sp)		#armazena o valor de x na pilha
        
       
        la $a0, $mensagemEntrada2	#passa a mensagem a ser exibida, no caso, a mensagem de "Digite o valor de n"
        jal printStr                    #pede para o usuario inserir
        jal readDouble                  #o valor do numero N.
	sdc1 $f0, 4($sp)                 #armazena o valor de N na pilha
        
        l.d $f16, $zeroDouble   #atribui 0 ao registrador f16.
        l.d $f18, $oneDouble    #atribui 1 ao registrador f18.

        jal calculaP            #executa a funcao calculaP.
        
        la $a0, $sucesso        #confirma o sucesso da operacao.
        jal printStr

        la $a0, ($s0)           #imprime o valor de p obtido na operacao.
        jal printInt

        j exit           

calculaP:

        ldc1 $f14, 4($sp) 	#recupera o valor de 'n' da pilha e armazena em $f14
        ldc1 $f12, 12($sp)	#recupera o valor de 'x' da pilha e armazena em $f12
        
        addu $sp,$sp,16 	#retira espaço ocupado da pilha

	c.le.d $f12, $f16       #verifica se x <= 0. caso verdadeiro,
        bc1t printError         #imprime uma mensagem de erro.

        c.le.d $f14, $f16       #verifica se N <= 0. caso verdadeiro,
        bc1t printError         #imprime uma mensagem de erro.

        c.eq.d $f12, $f18       #verifica se x = 1. caso verdadeiro,
        bc1t printError         #imprime uma mensagem de erro.
        
        add.d $f20, $f16, $f12  #atribui o valor de 'x' ao registrador $f20, que servirá como uma variável auxiliar para ir simulando x^p
        c.lt.d $f12, $f14 	# if(x < n)
        bc1t calculaPXMenorIgualN #desvia para calculaPXMenorIgualN
        j calculaPXMaiorN     #senão, desvia para calculaPXMaiorN


calculaPXMenorIgualN:
       
        c.lt.d $f12, $f18 #if(x < 1)
        bc1t printErroInfinito	#erro, pois se x < 1 e x <= n, o maior 'p' não pode ser determinado, já que quanto maior 'p', menor será 'x'
        
        li $s0, 0 # valor inicial de p
        li $s1, 1 # valor de incremento (1 ou -1)
        add.d $f22, $f16, $f12 #cria parâmetro fator a se multiplicar, com valor = x
        j loopXMenorIgualN



calculaPXMaiorN:
        li $s0, 1 # valor inicial de p
        c.lt.d $f12, $f18 #if(x < 1)
        bc1t setValoresPPositivo #se x < 1, setValoresPNegativo
        j setValoresPNegativo

setValoresPNegativo: 
        li $s1, -1 # valor de incremento (1 ou -1)
        div.d $f22, $f18, $f12 # valor do fator a se multiplicar, com valor = 1/x
        j loopXMaiorN

setValoresPPositivo:
        li $s1, 1 # valor de incremento (1 ou -1)
        add.d $f22, $f16, $f12 #cria parâmetro fator a se multiplicar, com valor = x
        j loopXMaiorN



loopXMaiorN:
        c.le.d $f20,$f14 #se res <= n, ou seja, se res > n der falso, ele retorna 
        bc1t retorna	
        mul.d $f20, $f20, $f22	#vai realizando a potenciação de x e armazenando em $f20
        add $s0, $s0, $s1 #incrementa 'p'
        j loopXMaiorN


loopXMenorIgualN:
        c.lt.d $f14,$f20 #se n < res, ele retorna
        bc1t retorna
        mul.d $f20, $f20, $f22 #vai realizando a potenciação de x e armazenando em $f20
        add $s0, $s0, $s1 #incrementa 'p'
        j loopXMenorIgualN


printInt:
        li $v0,1                       # passa para $v0 o valor 1, indicando para imprimir um inteiro
        j syscallAndReturn

printError:
        la $a0, $erro	#imprime texto, passando para $a0 o texto de erro
        jal printStr
	j exit	#encerra a execução caso ocorra algo de errado

printStr:
        li $v0,4                        # passa para $v0 o valor 4, indicando para imprimir texto
        j syscallAndReturn



readDouble:
        li $v0, 7	#passa para $v0 o valor 7, indicando leitura de double
        j syscallAndReturn



syscallAndReturn: 	#realiza a syscall de acordo com o parâmetro $v0, e retorna para onde parou na execução
        syscall
        j retorna



printErroInfinito:
        la $a0, $erroInfinito	#carrega para $a0 a mensagem de 'p' ser infinito
        jal printStr
        j exit

retorna:
       jr $ra   # retorna



exit:
        li $v0,10  # termina
        syscall

.data
$zeroDouble: .double 0.0
$oneDouble: .double 1.0

$mensagemEntrada:
        .asciiz "\nDigite o valor de x: "

$mensagemEntrada2:
        .asciiz "\nDigite o valor de n: "

$erro:
        .asciiz "\nNão é possível efetuar a operação, já que ou n <= 0, ou x <= 0 ou x = 1"

$erroInfinito:
        .asciiz "\nP é infinito"

$sucesso:
        .asciiz "\nO valor de 'p' obtido foi: "
