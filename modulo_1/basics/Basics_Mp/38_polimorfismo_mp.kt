interface Reservable{
    fun procesar(asiento:String):Boolean
    val nombre:String
}

class VueloNacional(val codigo:String):Reservable{
    override val nombre = "Vuelo Nacional"
    override fun procesar(asiento:String):Boolean{
        println("Reservando asiento $asiento en vuelo $codigo")
        return true
    }
}

class VueloInternacional(val codigo:String):Reservable{
    override val nombre = "Vuelo Internacional"
    override fun procesar(asiento:String):Boolean{
        println("Procesando reserva internacional asiento $asiento en vuelo $codigo")
        return true
    }
}

class SalaVIP:Reservable{
    override val nombre = "Sala VIP"
    override fun procesar(asiento:String):Boolean{
        println("Acceso autorizado asiento $asiento")
        return true
    }
}

fun reservar(asiento:String,reserva:Reservable){
    println("Procesando reserva con ${reserva.nombre}...")
    val exito = reserva.procesar(asiento)
    println(if(exito) "Reserva exitosa" else "Reserva fallida")
}

fun main() {
    println("EJERCICIO AEREOPUERTO")
    val reservas:List<Reservable> = listOf(
        VueloNacional("UIO101"),
        VueloInternacional("MAD500"),
        SalaVIP()
    )
    reservas.forEach { reservar("A12",it) }
}