fun main() {
    println("Comparación de vuelos: Económica vs VIP")
    val pasajerosEconomica = 150
    val pasajerosVIP = 20
    println("Mismo numero de pasajeros ${pasajerosEconomica == pasajerosVIP}")
    println("Numero diferente de pasajeros ${pasajerosEconomica != pasajerosVIP}")
    println("Economica tiene menos pasajeros que VIP? ${pasajerosEconomica < pasajerosVIP}")
    println("Economica tiene menos o igual de pasajeros que VIP? ${pasajerosEconomica <= pasajerosVIP}")
    println("Economica tiene mas pasajeros que VIP? ${pasajerosEconomica > pasajerosVIP}")
    println("Economica tiene mas o igual de pasajeros que VIP? ${pasajerosEconomica >= pasajerosVIP}")
}