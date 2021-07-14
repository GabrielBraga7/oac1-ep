public class Main{
    public static void main(String[] args){
        //calcular a maior P-ésima potência de X que torne X^P menor ou igual a um dado N.
        double n = 9;
        double x = 0.2;
        
        if(n <= 0 || x <= 0){
            System.out.println("Nao!"); //nenhum número elevado a uma potência pode ser menor ou igual a zero.
        }
        else{
            System.out.println(calculaP(x, n));
        }
    }

    public static int calculaP(double x, double n){
        double res = x;
        if(x <= n){
            return calculaPMaiorQue0(x, n, res, x);
        }
        else{
            return calculaPMenorIgualA0(x, n, res);
        }
        
    } 
    public static int calculaPMenorIgualA0(double x, double n, double res){
        int p = 1;
        if(x > 1){
            while(res > n){
                res *= (1/x);
                p--;
            }
        }
        else{
            res = (1/res);
            p = 0;
            while(res < n){
                res *= (1/x);
                p--;
            }
        }
        return p;
    }
    public static int calculaPMaiorQue0(double x, double n, double res, double factorMult){
        int p = 0;
        while(res <= n){
            res *= x;
            p++;
        }
        return p;
    }
     
}