fun main() {
    println("Sistema de Aeropuerto - Control de Vuelos")
    println("Ingrese el código del vuelo:")

    val codigo = readLine()?.toIntOrNull() ?: 0

    val vuelo = when (codigo) {
        1 -> "Vuelo nacional - Embarque inmediato (1h)"
        2 -> "Vuelo internacional - Control migratorio (3h)"
        3 -> "Vuelo con escala - Tiempo estimado (5h)"
        4 -> "Vuelo retrasado - Nueva salida (6h)"
        5 -> "Vuelo cancelado - Reprogramación necesaria"
        else -> "Código no válido, verifique su vuelo"
    }

    println("Estado del vuelo: $vuelo")
}