fun main() {
    println("map inmutables")
    val capitales = mapOf(
        "Espana" to "Madrid",
        "Francia" to "Paris",
        "Alemania" to "Berlin",
        "Italia" to "Roma"
    )

    println(capitales["Espana"])
    println(capitales["Portugal"])
    println(capitales.getOrDefault("Espana", "Desconocido"))
    println(capitales)

    println(capitales.keys)
    println(capitales.values)
    println(capitales.entries)

    for ((pais, capital) in capitales) {
        println("$pais - $capital")
    }

    println("map mutables")
    val inventario = mutableMapOf(
        "Laptops" to 10,
        "Impresoras" to 4,
        "Teclados" to 12,
        "Mouse" to 8
    )

    inventario["Monitores"] = 5
    println(inventario)

    inventario["Laptops"] = 20
    println(inventario)

    inventario.remove("Mouse")
    println(inventario)

    inventario.getOrPut("Proyector") { 15 }
    println(inventario)

    inventario.getOrPut("Teclados") { 15 }
    println(inventario)
}
