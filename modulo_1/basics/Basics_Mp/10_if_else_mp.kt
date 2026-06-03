fun main() {

    println("Ejercicios de mi aeropuerto")
    println("Controles de flujo")
    println("Condicional If - Else")

    print("¿Tiene vuelo? (s/n): ")
    val tieneVuelo = readLine()?.trim()?.lowercase() == "s"

    print("Costo Base: ")
    val costoBase = readLine()?.toDoubleOrNull()

    if (costoBase == null) {
        println("Error: debes ingresar un número válido.")
        return
    }

    if (tieneVuelo) {
        val cobertura = costoBase * 0.80
        println("Su seguro de viaje cubre: $${"%.2f".format(cobertura)}")
    } else {
        println("Pago sin seguro: $${"%.2f".format(costoBase)}")
    }
}