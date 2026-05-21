class Pista(val ancho:Double,val largo:Double) {

    val area:Double
        get() = ancho * largo

    val perimetro:Double
        get() = 2 * (ancho + largo)

    constructor(lado:Double) : this(lado,lado)

    constructor(ancho:Int,largo:Int) : this(ancho.toDouble(),largo.toDouble())

    override fun toString() = "Pista(${ancho}x${largo}) | area=${area}"
}

fun main() {
    println("EJERCICIO AEREOPUERTO")
    
    val p1 = Pista(5.0,3.0)
    val p2 = Pista(4.0)
    val p3 = Pista(6,2)
    
    println(p1)
    println(p2)
    println(p3)
}