fun main() {
    println("Ejercicio de aeropuertos")
    println("Utilidades list")
    println("map")
    
    val vuelos = listOf(1,2,3,4,5)
    println(vuelos)
    
    val pasajeros = vuelos.map { it * 50 }
    println(pasajeros)
    
    val vuelosTexto = vuelos.map { "Vuelo$it" }
    println(vuelosTexto)
    
    println("filter")
    
    val pares = vuelos.filter { it % 2 == 0 }
    println(pares)
    
    val mayores5 = vuelos.filter { it > 5 }
    println(mayores5)
    
    val paresYMayores5 = vuelos.filter { it % 2 == 0 && it > 5 }
    println(paresYMayores5)
    
    val impares = vuelos.filterNot { it % 2 == 0 }
    println(impares)
    
    val mezcla:List<Any> = listOf(1,"Quito",2,"Guayaquil",true,42)
    
    val soloStrings = mezcla.filterIsInstance<String>()
    println(soloStrings)
    
    println("reduce")
    
    val vuelosReduce = listOf(1,2,3,4,5)
    
    val suma = vuelosReduce.reduce {acc,n -> acc + n}
    println(suma)
    
    val producto = vuelosReduce.reduce {acc,n -> acc * n}
    println(producto)
    
    println("fold")
    
    val sumaFold = vuelosReduce.fold(100) {acc,n -> acc + n}
    println(sumaFold)
    
    val productoFold = vuelosReduce.fold(100) {acc,n -> acc * n}
    println(productoFold)
    
    println("Ordenacion")
    
    println("Ascendente: ${vuelos.sorted()}")
    println("Descendente: ${vuelos.sortedDescending()}")
    println("Sorted by: ${vuelos.sortedBy{-it}}")
    
    println("Agregacion")
    
    println("Sumar: ${vuelos.sum()}")
    println("Promedio: ${vuelos.average()}")
    println("Minimo: ${vuelos.min()}")
    println("Maximo: ${vuelos.max()}")
    println("Contar: ${vuelos.count{it > 4}}")
    
    println("Busqueda")
    
    println("Buscar: ${vuelos.find{it > 4}}")
    println("Buscar ultimo: ${vuelos.findLast{it > 4}}")
    println("Buscar any: ${vuelos.any{it > 4}}")
    println("Buscar all: ${vuelos.all{it > 0}}")
    println("Buscar none: ${vuelos.none{it > 10}}")
}