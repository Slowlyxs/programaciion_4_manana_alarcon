fun main() {
    val nombre = "Peter"
    val apellido = "Parker"
    val edad = 28
    val nombreCompleto = "${nombre.uppercase()} ${apellido.uppercase()}"
    println("Hola $nombre")
    println("Nombre Completo : $nombreCompleto")
    println("Edad : ${edad + 6} años")
    
   //String Multilinea
   val tarjeta = """
       |Nombre: $nombre $apellido
       |Edad: $edad
       |Acceso: ${if(edad>=18) "Permitido" else "Denegado"} 
   """.trimMargin()
   println(tarjeta)
}
    val nombre = "Alejandro"
    val apellido = "Alarcon"
    val edad = 17
    val nombreCompleto = "${nombre.uppercase()} ${apellido.uppercase()}"
    println("Hola $nombre")
    println("Nombre Completo : $nombreCompleto")
    println("Edad : ${edad} años")
    
   //String Multilinea
   val autorizacion = """
       |Nombre: $nombre $apellido
       |Edad: $edad
       |Acceso: ${if(edad>=18) "Usted esta permitido para viajar solo" else "Denegado necesita viajar con un tutor"} 
   """.trimMargin()
   println(autorizacion)