//Programa em linguagem Java que, ao receber um numero N e outro numero x (como entrada pelo usuario),
//calcula o maior grau a que eh possivel elevar x sem que o resultado ultrapasse o valor de N

import java.util.Scanner;

public class Main{
    public static void main(String[] args){
        Scanner sc = new Scanner(System.in);
        double x = getValue("Digite o valor de x:", sc);    //usuario insere o valor de x.
        double n = getValue("Digite o valor de n:", sc);    //usuario insere o valor de N.

        //calcular a maior P-esima potencia de X que torne X^P menor ou igual a um dado N.
        if(n <= 0 || x <= 0 || x == 1){
            System.out.println("Não é possível efetuar a operação, já que ou n <= 0, ou x <= 0 ou 1");
        }
        else{
            int p;
            try{
                p = calculaP(x, n);    //executa a funcao calcula p
                System.out.println("P = " + p);
            }catch(ArithmeticException e){
                System.out.println("P é infinito");
            }

        }
        sc.close();
    }

    public static double getValue(String msg, Scanner sc){    //funcao que retorna o numero double
        System.out.println(msg);                              //inserido pelo usuario.
        return sc.nextDouble();
    }

    public static int calculaP(double x, double n){
        if(x >= n){
            if(x < 1) 
                return calculaPXMaiorN(x, n, 1, 1, x);      //calcula P se x > N e x < 1 (ex: x = 1/2 e N = 1/8).
            else
                return calculaPXMaiorN(x, n, 1, -1, 1/x);   //calcula P se x > N e x >= 1 (ex: x = 2 e N = 1/8).
        }
        else{
            if(x < 1)
                throw new ArithmeticException("P é infinito");   //P aumenta mas x^P diminui, ou seja, x^P sempre será menor do que N (ex: x = 1/4 e N = 1/2)
            else
                return calculaPXMenorIgualN(x, n, 0, 1, x); //calcula P se x <= N e x >= 1 (ex: x = 2 e N = 8).
        }
        
    } 
    public static int calculaPXMaiorN(double x, double n, int p, int incremento, double factor){
        double res = x;         //cria a variavel res, para usa-la no lugar de x.
        while(res > n){         //verifica se res (x^P) continua maior do que N.
            res *= factor;      //multiplica res por x se x < 1, multiplica res por 1/x se x >= 1.
            p += incremento;    //incrementa P se x < 1, decrementa P se x >= 1.
        }
        return p;
    }
    public static int calculaPXMenorIgualN(double x, double n, int p, int incremento, double factor){
        double res = x;         //cria a variavel res, para usa-la no lugar de x.
        while(res <= n){        //verifica se res (x^P) continua menor ou igual a N.
            res *= factor;      //multipica res por x.
            p += incremento;    //incrementa P.
        }
        return p;
    }
}