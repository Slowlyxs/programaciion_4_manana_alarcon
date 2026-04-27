fun main() {
    println("Utilidades list")
    println("map")

    val numeros = listOf(1, 2, 3, 4, 5)
    println(numeros)

    val cuadrados = numeros.map { it * it }
    println(cuadrados)

    val numerosTexto = numeros.map { "Num$it" }
    println(numerosTexto)

    println("filter")

    val pares = numeros.filter { it % 2 == 0 }
    println(pares)

    val mayores5 = numeros.filter { it > 5 }
    println(mayores5)

    val paresYMayores5 = numeros.filter { it % 2 == 0 && it > 5 }
    println(paresYMayores5)

    val impares = numeros.filterNot { it % 2 == 0 }
    println(impares)

    val mezcla: List<Any> = listOf(1, "hola", 2, "Mundo", true, 42)

    val soloStrings = mezcla.filterIsInstance<String>()
    println(soloStrings)
    
    println("reduce")
    val numerosReduce =listOf(1,2,3,4,5)
    val suma = numerosReduce.reduce {acc, n -> acc + n}
    println(suma)
    val producto = numerosReduce.reduce {acc, n -> acc * n}
    println(producto)
    println("fold")
    val sumaFold = numerosReduce.fold(100) {acc, n -> acc + n}
    println(sumaFold)
    val productoFold = numerosReduce.fold(100) {acc, n -> acc * n}
    println(productoFold)
    
 println("Ordenacion")
 println("Ascendente: ${numeros.sorted()}")
 println("Descendente: ${numeros.sortedDescending()}")
 println("Sorted by: ${numeros.sortedBy{-it}}")
 println("Agregacion")
 println("Sumar: ${numeros.sum()}")
 println("Promedio: ${numeros.average()}")
 println("Minimo: ${numeros.min()}")
 println("Maximo: ${numeros.max()}")
 println("Contar: ${numeros.count{it > 4}}")
 println("Busqueda")
 println("Buscar: ${numeros.find{it > 4}}")
 println("Buscar ultimo: ${numeros.findLast {it > 4}}")
 println("Buscar any: ${numeros.any {it > 4}}")
 println("Buscar all: ${numeros.all {it > 0}}")
 println("Buscar none: ${numeros.none {it > 10}}")

    
}