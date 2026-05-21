class Pasajero(val nombre:String,val correo:String) {
    val nombreNormalizado:String
    val dominioCorreo:String
    
    init {
        require(nombre.isNotBlank()) { "El nombre no puede estar vacio" }
        require(correo.contains("@")) { "Correo invalido: $correo" }
        
        nombreNormalizado = nombre.trim().lowercase()
        dominioCorreo = correo.substringAfter("@")
    }
}

fun main() {
    println("Ejerciios de aereopuertos")
    
    val p = Pasajero(" Carlos Perez ","carlos@aeropuerto.com")
    
    println(p.nombreNormalizado)
    println(p.dominioCorreo)
}