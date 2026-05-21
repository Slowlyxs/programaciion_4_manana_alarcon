fun main() {

    println("Ejercicios de mi aeropuerto")
    println("Controles de flujo")
    println("Condicional If - Else")

    println("Tiene vuelo s/n: ")
    val tieneVuelo = readLine()?.trim()?.lowercase() == "s"
    println("Costo Base: ")
    val costoBase = readLine()?.toDoubleOrNull() ?: 0.0
    if (tieneVuelo) {
        val cobertura = costoBase * 0.80
        println("Su seguro de viaje cubre: $${"%.2f".format(cobertura)}")
    } else {
        println("Pago sin seguro: $${"%.2f".format(costoBase)}")
    }
}