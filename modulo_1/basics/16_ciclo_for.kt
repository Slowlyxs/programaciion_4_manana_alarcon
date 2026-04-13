fun main() {
    println("Controles de Flujo CICLOS REPETITIVOS CICLO -FOR")
    println("For con rango")

    for (i in 1..10) {
        println("5 * $i  = ${i * 5}")
    }

    /////////////////////////////////////////////////////////
    println("For con until")
    for (i in 1 until 5)
        print(i)

    println()

    /////////////////////////////////////////////////////////
    println("For con pasos")
    for (i in 1..10 step 3) {
        print(i)
    }

    println()

    /////////////////////////////////////////////////////
    println("Por descendente")
    for (i in 10 downTo 1) {
        print(i)
    }

    println()

    //////////////////////////////////////////////////////////
    println("For con listas")
    val nombres = listOf("Juan", "Maria", "Jose")

    for (nombre in nombres) {
        println(nombre)
    }

    /////////////////////////////////////////////////////////
    println("For con listas index valor")

    for ((index, valor) in nombres.withIndex()) {
        println("$index -> $valor")
    }

    /////////////////////////////////////////////////////////
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
        println("item $i")
    }

    /////////////////////////////////////////////////////////
    for (i in 1..10) {
        if (i in 1..3) continue
        if (i in 7..10) break
        println("item $i")
    }

    /////////////////////////////////////////////////////////
    val pacientes = listOf(
        Triple("Garcia, M", 37.2, 98),
        Triple("Zambrano, L", 39.1, 94),
        Triple("Torres, R", 40.3, 91)
    )

    for ((posicion, paciente) in pacientes.withIndex()) {
        val (nombre, temperatura, spo2) = paciente
        val alertaTemp = if (temperatura >= 38.0) "Fiebre" else "Normal"
        val alertaSpo2 = if (spo2 < 95) "Baja" else "Normal"
        println("Cama $posicion - $nombre - Temp: $temperatura °C ($alertaTemp) - SpO2: $spo2 ($alertaSpo2)")
    }
}