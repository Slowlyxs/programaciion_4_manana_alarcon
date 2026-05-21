fun main() {
    println("Ejercicio de mi aereopuerto")
    println("Controles de flujo")
    println("Condicional If")
    val temperatura_pasajero = readLine()?.toDoubleOrNull() ?: 36.5
    if (temperatura_pasajero >= 38.0) {
        println("Fiebre detectada: Evitar Viajar")
    }
    if (temperatura_pasajero >= 40.0) {
        println("Fiebre alta: Se deniega el viaje por posible riesgo a infección")
    }
    println("Temperatura registrada de pasajero: $temperatura_pasajero grados centigrados")
}