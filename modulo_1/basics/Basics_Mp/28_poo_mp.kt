class Vuelo(
    val id:Int,
    val destino:String,
    val precio:Double,
    private val asientos:Int
) {
    val precioFinal:Double
        get() = precio * 1.12

    val disponible:Boolean
        get() = asientos > 0

    override fun toString() = "$destino ($${"%.2f".format(precio)})"
}

fun main() {
    println("Ejercicio de aeropuertos")
    
    val vuelo = Vuelo(1,"Madrid",899.99,25)
    
    println(vuelo.disponible)
    println(vuelo.precioFinal)
    
    println(vuelo)
}