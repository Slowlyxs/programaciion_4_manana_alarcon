fun main() {
    println("Ejercicio de aeropuertos")
    println("set inmutables")
    
    val vuelos = setOf("Quito","Guayaquil","Cuenca","Manta","Quito","Cuenca")
    
    println("vuelos set: ${vuelos}")
    
    println("Operaciones de conjuntos")
    
    val nacionales = setOf("Quito","Cuenca","Loja","Manta")
    val internacionales = setOf("Miami","Madrid","Loja","Panama")
    
    println("nacionales set: ${nacionales}")
    println("internacionales set: ${internacionales}")
    
    println("union : ${nacionales union internacionales}")
    println("interseccion: ${nacionales intersect internacionales}")
    println("subsraccion: ${nacionales subtract internacionales}")
    
    println("nacionales set: ${nacionales}")
    println("internacionales set: ${internacionales}")
    
    println("set mutables")
    
    val puertas = mutableSetOf("A1","A2","VIP")
    
    println(puertas)
    
    puertas.add("A1")
    println(puertas)
    
    puertas.add("A2")
    println(puertas)
    
    puertas.add("B1")
    println(puertas)
    
    println("verificar si elementos existe ${"A1" in puertas}")
    println("verificar si elementos existe ${"VIP" in puertas}")
}