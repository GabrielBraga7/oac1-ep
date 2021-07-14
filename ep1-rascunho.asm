########## EP1
.text
.globl main
main:
        l.s $f12,$x                       # inicia o total
        l.s $f13,$n
        l.s $f14, $z
        l.s $f17, $o
        c.le.s $f12, $f14
        bc1t printError
        c.le.s $f13, $f14
        bc1t printError
        jal calculaP
        la $a0, ($s0)
        j printInt                # chama o fatorial

calculaP:
        l.s $f15, $x 
        c.le.s $f12,$f13
        bc1t calculaPMaiorQue0

calculaPMenorIgualA0:
        li $s0, 1
        j loopPMenorIgualA0

calculaPMaiorQue0:
        li $s0, 0
        j loopPMaiorQue0

loopPMaiorQue0:
        c.lt.s $f13,$f15
        bc1t retorna
        mul.s $f15, $f15, $f12
        j incrementaP

loopPMenorIgualA0:
        c.le.s $f15,$f13
        bc1t retorna
        div.s $f16, $f17, $f12
        mul.s $f15, $f15, $f16
        j decrementaP

incrementaP:
        addi $s0, $s0, 1
        j loopPMaiorQue0
decrementaP:
        addi $s0, $s0, -1
        j loopPMenorIgualA0

retorna:
       jr $ra                                # retorna

exit:
        li $v0,10                        # termina
        syscall

printError:
        la $a0, $erro
        j printStr

printStr:
        li $v0,4                        # imprime o resultado
        j print

print:
        syscall
        j exit

printInt:
        li $v0,1                       # imprime o resultado
        j print

.data
$z: .float 0.0
$o: .float 1.0
$n: .float 0.25
$x: .float 2.0 
    $erro:
        .asciiz "Não é possível efetuar a operação, já que n <= 0"
     $texto:
        .asciiz "calculaPMaiorQue0"       
    $texto2:
        .asciiz "calculaPMenorIgualA0"     