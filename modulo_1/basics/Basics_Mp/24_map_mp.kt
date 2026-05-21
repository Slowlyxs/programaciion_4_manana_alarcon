fun main() {
    println("Ejercicio de aeropuertos")
    println("map inmutables")
    
    val vuelos = mapOf(
        "Ecuador" to "Quito",
        "Peru" to "Lima",
        "Colombia" to "Bogota",
        "Chile" to "Santiago"
    )
    
    println(vuelos["Ecuador"])
    println(vuelos["Brasil"])
    println(vuelos.getOrDefault("Ecuador","Desconocido"))
    println(vuelos)
    
    println(vuelos.keys)
    println(vuelos.values)
    println(vuelos.entries)
    
    for((pais,ciudad) in vuelos){
        println("$pais - $ciudad")
    }
    
    println("map mutables")
    
    val pasajeros = mutableMapOf(
        "Quito" to 120,
        "Guayaquil" to 90,
        "Cuenca" to 60,
        "Manta" to 40
    )
    
    pasajeros["Loja"]=30
    println(pasajeros)
    
    pasajeros["Quito"]=150
    println(pasajeros)
    
    pasajeros.remove("Manta")
    println(pasajeros)
    
    pasajeros.getOrPut("Tulcan"){20}
    println(pasajeros)
    
    pasajeros.getOrPut("Cuenca"){50}
    println(pasajeros)
}