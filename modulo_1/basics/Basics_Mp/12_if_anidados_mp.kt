fun main() {
    println("Ejercicio de aereopuerto")
    println("Controles de flujo")
    println("Condicional If - Anidado")
    
    println("Tiene vuelo internacional? s/n")
    val vueloInternacional = readLine()?.trim()?.lowercase() == "s"
    
    println("Peso del equipaje kg")
    val pesoEquipaje = readLine()?.toIntOrNull() ?: 0
    
    if (vueloInternacional) {
        println("Pasajero internacional")
        
        if (pesoEquipaje < 10) {
            println("Equipaje ligero")
        } else if (pesoEquipaje > 23) {
            println("Equipaje con sobrepeso")
        } else {
            println("Equipaje permitido")
        }

    } else {
        println("Pasajero nacional")
        
        if (pesoEquipaje < 5 || pesoEquipaje > 30) {
            println("Equipaje fuera del rango permitido")
        } else {
            println("Equipaje dentro del rango permitido")
        }
    }
}