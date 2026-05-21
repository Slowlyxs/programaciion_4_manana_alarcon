object ConfiguracionAeropuerto {
    val host:String = "api.aeropuerto.com"
    val puerto:Int = 8080
    
    private val apiKey:String = "api-aeropuerto-123"
    
    fun baseUrl() = "https://$host:$puerto"
    
    fun headers() = mapOf("Authorization" to "Bearer $apiKey")
}

class Pasajero private constructor(val id:Int,val nombre:String) {
    
    companion object {
        private var contadorId = 0
        
        fun crear(nombre:String,email:String):Pasajero? {
            if(nombre.isBlank() || !email.contains("@")) return null
            
            return Pasajero(++contadorId,nombre.trim())
        }
        
        const val ROL_DEFECTO = "Pasajero"
    }
}

fun main() {
    println("EJERCICIO AEREOPUERTO")
    
    println(ConfiguracionAeropuerto.baseUrl())
    
    val p = Pasajero.crear("Carlos","carlos@aeropuerto.com")
    
    println(p)
}