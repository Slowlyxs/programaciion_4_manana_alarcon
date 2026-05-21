enum class EstadoVuelo(val descripcion:String,val esTerminal:Boolean) {
    PROGRAMADO("Esperando abordaje",false),
    EMBARQUE("Pasajeros abordando",false),
    DESPEGADO("Vuelo completado",true),
    RETRASADO("Vuelo retrasado",true),
    CANCELADO("Vuelo cancelado",true);

    fun puedeTransicionarA(siguiente:EstadoVuelo):Boolean = when(this) {
        PROGRAMADO -> siguiente == EMBARQUE || siguiente == CANCELADO
        EMBARQUE -> siguiente == DESPEGADO || siguiente == RETRASADO
        else -> false
    }
}

fun main() {
    println("EJERCICIO AEREOPUERTO")
    val estado = EstadoVuelo.EMBARQUE
    println(estado.descripcion)
    println(estado.esTerminal)
    val icono = when(estado) {
        EstadoVuelo.PROGRAMADO -> "PROGRAMADO"
        EstadoVuelo.EMBARQUE -> "EMBARQUE"
        EstadoVuelo.DESPEGADO -> "DESPEGADO"
        EstadoVuelo.RETRASADO -> "RETRASADO"
        EstadoVuelo.CANCELADO -> "CANCELADO"
    }
    println(icono)
    println(estado.puedeTransicionarA(EstadoVuelo.DESPEGADO))
}