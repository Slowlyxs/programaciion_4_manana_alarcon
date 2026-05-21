fun main() {
    println("Ejercicio de aeropuertos")
    println("Controles de Flujo CICLOS REPETITIVOS CICLO -FOR")
    println("For con rango")
    
    for (i in 1..10) {
        println("Vuelo $i listo para despegar")
    }
    
    println("For con until")
    for (i in 1 until 5)
        print("Puerta$i ")
    
    println()
    
    println("For con pasos")
    for (i in 1..10 step 3) {
        print("Pista$i ")
    }
    
    println()
    
    println("Por descendente")
    for (i in 10 downTo 1) {
        print("Aterrizando$i ")
    }
    
    println()
    
    println("For con listas")
    val vuelos = listOf("Quito","Guayaquil","Cuenca")
    
    for (vuelo in vuelos) {
        println(vuelo)
    }
    
    println("For con listas index valor")
    
    for ((index, valor) in vuelos.withIndex()) {
        println("$index -> $valor")
    }
    
    println("For con break")
    
    for (i in 1..10) {
        if (i in 1..5) {
            break
        }
    }
    
    println("For con continue")
    
    for (i in 1..10) {
        if (i in 1..3) {
            continue
        }
        println("Vuelo $i")
    }
    
    for (i in 1..10) {
        if (i in 1..3) continue
        if (i in 7..10) break
        println("Puerta $i")
    }
    
    val pasajeros = listOf(
        Triple("Carlos",23,"Check-In"),
        Triple("Maria",18,"Embarque"),
        Triple("Jose",30,"Migracion")
    )
    
    for ((posicion, pasajero) in pasajeros.withIndex()) {
        val (nombre, edad, estado) = pasajero
        val acceso = if (edad >= 18) "Permitido" else "Revision"
        println("Fila $posicion - $nombre - Edad: $edad - Estado: $estado - Acceso: $acceso")
    }
}