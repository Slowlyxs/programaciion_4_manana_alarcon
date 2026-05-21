fun main() {

    println("Control de vuelos en aeropuerto")

    val vueloInternacional = true
    val tienePasaporte = true
    val tieneEquipaje = false

    // AND lógico
    println("\n&& - AND Logico")
    println("Vuelo internacional y pasaporte:")
    println("$vueloInternacional && $tienePasaporte = ${vueloInternacional && tienePasaporte}")

    println("Vuelo internacional y equipaje:")
    println("$vueloInternacional && $tieneEquipaje = ${vueloInternacional && tieneEquipaje}")

    // OR lógico
    println("\n|| - OR Logico")
    println("Tiene pasaporte o equipaje:")
    println("$tienePasaporte || $tieneEquipaje = ${tienePasaporte || tieneEquipaje}")

    println("Vuelo internacional o equipaje:")
    println("$vueloInternacional || $tieneEquipaje = ${vueloInternacional || tieneEquipaje}")

    // NOT lógico
    println("\n! - NOT Logico")
    println("No tiene equipaje:")
    println("!$tieneEquipaje = ${!tieneEquipaje}")

    println("No es vuelo internacional:")
    println("!$vueloInternacional = ${!vueloInternacional}")
}