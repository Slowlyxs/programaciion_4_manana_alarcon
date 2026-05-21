sealed class NotificacionVuelo(val titulo:String,val mensaje:String){
    abstract fun formatear():String

    data class Email(val destinatario:String,val asunto:String,val cuerpo:String)
        : NotificacionVuelo(asunto,cuerpo){
        override fun formatear() =
            "Email -> $destinatario Asunto: $titulo ${mensaje.take(50)}..."
    }

    data class Pantalla(val terminal:String,val aviso:String = "Salida")
        : NotificacionVuelo("Pantalla",aviso){
        override fun formatear() = "Pantalla -> $terminal: $titulo"
    }

    data class Altavoz(val puerta:String,val texto:String)
        : NotificacionVuelo("Altavoz",texto){
        override fun formatear() = "Altavoz -> $puerta: ${texto.take(160)}"
    }

    object Silenciosa : NotificacionVuelo("",""){
        override fun formatear() = "Notificacion silenciosa"
    }
}

interface EnviadorNotificacion{
    val nombre:String
    fun enviar(notificacion:NotificacionVuelo):Boolean
}

class ServicioEmail:EnviadorNotificacion{
    override val nombre = "Email"

    override fun enviar(n:NotificacionVuelo):Boolean{
        if(n !is NotificacionVuelo.Email) return false

        println("[EMAIL] -> ${n.destinatario}")

        return true
    }
}

class ServicioPantalla:EnviadorNotificacion{
    override val nombre = "Pantalla"

    override fun enviar(n:NotificacionVuelo):Boolean{
        if(n !is NotificacionVuelo.Pantalla) return false

        println("[PANTALLA] -> ${n.terminal}")

        return true
    }
}

class Dispatcher(private val servicios:List<EnviadorNotificacion>){

    fun enviar(notificacion:NotificacionVuelo){
        println(notificacion.formatear())

        val exito = servicios.any { it.enviar(notificacion) }

        if(!exito) println("Sin servicio disponible")

        println()
    }
}

fun main() {
    println("EJERCICIO AEREOPUERTO")

    val dispatcher = Dispatcher(listOf(ServicioEmail(),ServicioPantalla()))

    listOf(
        NotificacionVuelo.Email("carlos@test.com","Vuelo confirmado","Su vuelo ha sido confirmado."),
        NotificacionVuelo.Pantalla("Terminal A"),
        NotificacionVuelo.Altavoz("Puerta 5","Pasajeros abordar inmediatamente"),
        NotificacionVuelo.Silenciosa
    ).forEach { dispatcher.enviar(it) }
}