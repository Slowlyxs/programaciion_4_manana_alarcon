 fun main() {
    println("Operadores artimeticos")
    val numero1= 10
    val numero2 = 2
    
    println("suma")
    println("$numero1 + $numero2 = ${numero1+numero2}")
    println("resta")
    println("$numero1 - $numero2 = ${numero1-numero2}")
    println("Multiplicacion")
    println("$numero1 * $numero2 = ${numero1*numero2}")
    println("Division")
    println("$numero1 / $numero2 = ${numero1/numero2}")
    println("Modulo")
    println("$numero1 % $numero2 = ${numero1%numero2}")
    
    println("Operadores de Asignacion Compuesta")
    var x= 10
    x+=5
    println("x+=5 $x")
    x-=3
    println("x-=3 $x")
    x*=6
    println("x*=2 $x")
    x/=2
    println("x/2 $x")
    x%=2
    println("x%=2 $x")
    x++
    println("x++ $x")
    x--
    println("x-- $x")
}
