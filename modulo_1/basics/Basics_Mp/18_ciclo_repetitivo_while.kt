fun main() {
    println("Ejercicio de aeropuertos")

    var input: String

    while (true) {
        println("\nEscribe algo o 'salir' para terminar:")
        input = readLine() ?: ""

        if (input.trim().lowercase() == "salir") {
            println("Saliendo del sistema...")
            return
        }

        println("Usted ingreso: $input")
        break
    }

    var input1: Int

    while (true) {
        println("\nMenu Aeropuerto:")
        println("1.- CheckIn")
        println("2.- Equipaje")
        println("3.- Vuelos")
        println("4.- Salir")

        input1 = readLine()?.toIntOrNull() ?: -1

        if (input1 == 4) {
            println("Saliendo del sistema...")
            return
        }

        val opcion = when (input1) {
            1 -> "CheckIn"
            2 -> "Equipaje"
            3 -> "Vuelos"
            else -> "Opción inválida"
        }

        println("Usted selecciono: $opcion")
    }
}