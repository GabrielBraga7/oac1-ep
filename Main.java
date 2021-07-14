public class Main{
    public static void main(String[] args){
        //calcular a maior P-ésima potência de X que torne X^P menor ou igual a um dado N.
        double n = 0.33; // 1/4
        if(n <= 0){
            System.out.println("Nao!"); //nenhum número elevado a uma potência pode ser menor ou igual a zero.
        }
        else{
            System.out.println(calculaP(3, n));
        }
    }

    public static int calculaP(double x, double n){
        double res = x;
        if(x > n){
            return calculaPMenorIgualA0(x, n, res);
        }
        else{
            return calculaPMaiorQue0(x, n, res);
        }
    } 
    public static int calculaPMenorIgualA0(double x, double n, double res){
        int p = 1;
        while(res > n){
            res *= (1/x);
            p--;
        }
        return p;
    }
    public static int calculaPMaiorQue0(double x, double n, double res){
        int p = 0;
        while(res <= n){
            res *= x;
            p++;
        }
        return p;
    }
     
}