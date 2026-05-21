fun main() {
    println("Ejercicio de aeropuerto")
    println("Controles de flujo")
    println("Condicional If - Else - Múltiples condiciones")
    
    println("Ingrese peso del equipaje kg: ")
    val pesoEquipaje = readLine()?.toIntOrNull() ?: 0
    
    val clasificacion = if (pesoEquipaje <= 10) {
        "Equipaje Ligero"
    } else if (pesoEquipaje <= 23) {
        "Equipaje Permitido"
    } else if (pesoEquipaje <= 32) {
        "Sobrepeso"
    } else if(pesoEquipaje <= 50){
        "Carga Especial"
    } else{
        "No Permitido"
    }
    
    println("Clasificacion: $clasificacion")
    println("Clasificacion: ${clasificacion.uppercase()}")
}