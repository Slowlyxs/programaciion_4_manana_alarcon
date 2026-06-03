fun main() {
    println("Sistema de Aeropuerto - Funciones")

    println(mensajeBienvenida())

    val totalEquipaje = sumarMaletas(5, 4)
    println("Total de maletas: $totalEquipaje")

    println("Diferencia de pasajeros: ${diferenciaPasajeros(120, 80)}")
    println(diferenciaPasajeros(120, 80))
    println(diferenciaInferida(200, 150))

    registrarPasajero("Pedro")
}

fun sumarMaletas(a: Int, b: Int): Int {
    return a + b
}

fun mensajeBienvenida(): String {
    return "Bienvenido al sistema del aeropuerto"
}

fun diferenciaPasajeros(a: Int, b: Int) = a - b

fun diferenciaInferida(a: Int, b: Int) = a - b

fun registrarPasajero(nombre: String) {
    println("Pasajero registrado: $nombre")
}