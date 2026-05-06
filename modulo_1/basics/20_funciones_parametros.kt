fun main() {
    println("Funciones")
    println(saludar())
    val suma: Int = sumar(5, 4)
    println(suma)
    println("${restarTipoExpresion(5, 3)}")
    println(restarTipoExpresion(5, 3))
    println(restarTipoInferido(5, 3))
    saludar("Pedro")
}
fun sumar(a: Int, b: Int): Int {
    return a + b
}
fun saludar(): String {
    return "Hola desde una función"
}
// tipo expresión
fun restarTipoExpresion(a: Int, b: Int) = a - b
// tipo inferido
fun restarTipoInferido(a: Int, b: Int) = a - b
fun saludar(nombre: String) {
    println("Hola $nombre")
}
