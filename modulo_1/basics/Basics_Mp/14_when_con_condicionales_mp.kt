fun main() {
    println("Ejercicio de aeropuertos")
    println("Controles de Flujo When con bloque de codigos")
    
    println("Edad del pasajero:")
    val edadPasajero = readLine()?.toIntOrNull() ?: 0
    println("Tiene membresia VIP s/n:")
    val tieneMembresia = readLine()?.trim()?.lowercase() == "s"
    val tipoMembresia = if (tieneMembresia) {
        println("Tipo de membresia BASICA/ORO/PLATINO:")
        readLine()?.trim()?.uppercase() ?: ""
    } else ""
    val costoEquipaje = when {
        !tieneMembresia && edadPasajero < 12 -> 0.0
        !tieneMembresia && edadPasajero >= 60 -> 10.0
        !tieneMembresia -> 35.0
        tipoMembresia == "BASICA" -> 20.0
        tipoMembresia == "ORO" -> 10.0
        tipoMembresia == "PLATINO" -> 0.0
        else -> 25.0
    }
    println("CostoEquipaje: $${"%.2f".format(costoEquipaje)}")
}