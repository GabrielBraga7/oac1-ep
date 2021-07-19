import java.util.Scanner;

public class Main{
    public static void main(String[] args){
        Scanner sc = new Scanner(System.in);
        double x = getValue("Digite o valor de x:", sc);
        double n = getValue("Digite o valor de n:", sc);
        //calcular a maior P-ésima potência de X que torne X^P menor ou igual a um dado N.
        
        if(n <= 0 || x <= 0 || x == 1){
            System.out.println("Não é possível efetuar a operação, já que ou n <= 0, ou x <= 0 ou x = 1");
        }
        else{
            int p = calculaP(x, n);
            System.out.println(p == Integer.MAX_VALUE ? "Infinito" : p);
        }
        sc.close();
    }

    public static double getValue(String msg, Scanner sc){
        System.out.println(msg);
        return sc.nextDouble();
    }

    public static int calculaP(double x, double n){
        if(x > n){
            if(x < 1)
                return calculaPXMaiorN(x, n, 1, 1, x);
            else
                return calculaPXMaiorN(x, n, 1, -1, 1/x);
        }
        else{
            if(x < 1)
                return Integer.MAX_VALUE;
            else
                return calculaPXMenorIgualN(x, n, 0, 1, x);
        }
        
    } 
    public static int calculaPXMaiorN(double x, double n, int p, int incremento, double factor){
        double res = x;
        while(res > n){
            res *= factor;
            p += incremento;
        }
        return p;
    }
    public static int calculaPXMenorIgualN(double x, double n, int p, int incremento, double factor){
        double res = x;
        while(res <= n){
            res *= factor;
            p += incremento;
        }
        return p;
    }
}