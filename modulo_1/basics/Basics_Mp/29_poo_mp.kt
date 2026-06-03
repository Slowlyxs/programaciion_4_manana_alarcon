class PuntoInmutable(val x: Double, val y: Double)

class Contador(var valor: Int = 0) {
    fun incrementar() { valor++ }
    fun resetear() { valor = 0 }
}

class Temporal(nombre: String) {
    val nombreUpper = nombre.uppercase()
}

fun main() {
    val punto = PuntoInmutable(3.5, 7.2)
    println("Punto: (${punto.x}, ${ punto.y})")

    val contador = Contador()
    contador.incrementar()
    contador.incrementar()
    println("Contador: ${contador.valor}")

    contador.resetear()
    println("Contador reseteado: ${contador.valor}")

    val temp = Temporal("aeropuerto")
    println("Nombre en mayúsculas: ${temp.nombreUpper}")
}