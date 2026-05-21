class Pasajero(val nombre:String,val edad:Int)

class Pasajero2(val nombre:String,val edad:Int){
    fun presentarse() = "Soy $nombre y tengo $edad años"
    fun esMayorDeEdad() = edad >= 18
}

fun main() {
    println("Ejercicio de aeropuertos")
    
    val p = Pasajero("Carlos",28)
    
    println(p.nombre)
    println(p.edad)
    
    val p2 = Pasajero2("Luis",17)
    
    println(p2.presentarse())
    println(p2.esMayorDeEdad())
}