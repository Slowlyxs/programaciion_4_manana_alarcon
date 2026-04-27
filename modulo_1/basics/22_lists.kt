fun main() {
    println("Listas-inmutable")
    val frutas = listOf("manzanas", "banana", "cereza", "banana", "pera")

    println("Mostrar el elemento indice 0: ${frutas[0]}")
    println("Mostrar el primer elemento: ${frutas.first()}")
    println("Mostrar el ultimo elemento: ${frutas.last()}")

    println("Mostrar el elemento indice 2: ${frutas.get(2)}")
    println("Mostrar indice contenido elemento: ${frutas.indexOf("banana")}")
    println("Verificar existencia de elemento: ${frutas.contains("cereza")}")
    println("Verificar existencia de un elemento: ${"banana" in frutas}")

    println("sublista ${frutas.subList(1,3)}")
    println("tomar primeros 2 elementos: ${frutas.take(2)}")
    println("suprimir tres primeros elementos: ${frutas.drop(3)}")
    println("tomar los ultimos dos elementos: ${frutas.takeLast(2)}")

    for (fruta in frutas) {
        println(fruta)
    }

    println("Listas-Mutables")
    val colores = mutableListOf("blanco", "azul", "amarillo", "rojo")

    println(colores)
    colores.add("verde")
    println(colores)

    colores.add(0, "morado")
    println(colores)

    colores.remove("verde")
    println(colores)

    colores[1] = "gris"
    println(colores)

    println("ArrayDeque")
    val deque = ArrayDeque<Int>()

    println(deque)
    deque.addFirst(1)
    println(deque)

    deque.addLast(2)
    println(deque)

    deque.addLast(0)
    println(deque)

    deque.addFirst()
    println(deque)

    deque.addLast()
    println(deque)
}