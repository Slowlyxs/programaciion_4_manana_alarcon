fun main() {
    println("Ejercicio de aeropuertos")
    println("Funciones")
    println(mensajeAeropuerto())
    val pasajeros:Int = sumarPasajeros(120,80)
    println(pasajeros)
    println("${restarEquipaje(50,20)}")
    println(restarEquipaje(50,20))
    println(restarAsientos(200,35))
    saludarPasajero("Carlos")
}

fun sumarPasajeros(a:Int,b:Int):Int{
    return a+b
}

fun mensajeAeropuerto():String{
    return "Vuelo listo para despegar"
}

fun restarEquipaje(a:Int,b:Int)=a-b

fun restarAsientos(a:Int,b:Int)=a-b

fun saludarPasajero(nombre:String){
    println("Bienvenido $nombre")
}