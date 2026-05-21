fun main() {
    println("Ejercicio de aeropuertos")
    println("Listas-inmutable")
    
    val vuelos = listOf("Quito","Guayaquil","Cuenca","Guayaquil","Manta")
    
    println("Mostrar el elemento indice 0: ${vuelos[0]}")
    println("Mostrar el primer elemento: ${vuelos.first()}")
    println("Mostrar el ultimo elemento: ${vuelos.last()}")
    
    println("Mostrar el elemento indice 2: ${vuelos.get(2)}")
    println("Mostrar indice contenido elemento: ${vuelos.indexOf("Guayaquil")}")
    println("Verificar existencia de elemento: ${vuelos.contains("Cuenca")}")
    println("Verificar existencia de un elemento: ${"Guayaquil" in vuelos}")
    
    println("sublista ${vuelos.subList(1,3)}")
    println("tomar primeros 2 elementos: ${vuelos.take(2)}")
    println("suprimir tres primeros elementos: ${vuelos.drop(3)}")
    println("tomar los ultimos dos elementos: ${vuelos.takeLast(2)}")
    
    for(vuelo in vuelos){
        println(vuelo)
    }
    
    println("Listas-Mutables")
    
    val puertas = mutableListOf("A1","A2","A3","A4")
    
    println(puertas)
    
    puertas.add("A5")
    println(puertas)
    
    puertas.add(0,"VIP")
    println(puertas)
    
    puertas.remove("A5")
    println(puertas)
    
    puertas[1]="B1"
    println(puertas)
    
    println("ArrayDeque")
    
    val deque = ArrayDeque<Int>()
    
    println(deque)
    
    deque.addFirst(1)
    println(deque)
    
    deque.addLast(2)
    println(deque)
    
    deque.addLast(3)
    println(deque)
    
    deque.addFirst(0)
    println(deque)
    
    deque.addLast(4)
    println(deque)
}