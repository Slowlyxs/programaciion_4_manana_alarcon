    open class VehiculoAereo(val nombre:String,val accion:String) {

        open fun ejecutarAccion() = println("$nombre realiza: $accion")
        open fun descripcion() = "Soy $nombre"
        fun encenderMotores() = println("$nombre enciende motores")
    }
    class Avion(nombre:String) : VehiculoAereo(nombre,"Despegando") {
        override fun ejecutarAccion() {
            super.ejecutarAccion()
            println("Preparando pista")
        }
        override fun descripcion() = "${super.descripcion()}, un avion comercial"
    }
    class Helicoptero(nombre:String,val emergencia:Boolean) : VehiculoAereo(nombre,"Volando") {
        override fun descripcion() =
            "${super.descripcion()}, un helicoptero ${if(emergencia) "de emergencia" else "privado"}"
    }

    fun main() {
        println("EJERCICIO AEREOPUERTO")
        val avion = Avion("Boeing737")
        avion.ejecutarAccion()
        val helicoptero = Helicoptero("HeliJet",true)
        println(helicoptero.descripcion())
        avion.encenderMotores()
    }