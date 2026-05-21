fun main() {
    println("Ejercicio de aeropuertos")
    println("Funciones-Parametros por defecto")
    
    println(crearVuelo("Quito",25,"Internacional",true))
    println(crearVuelo("Guayaquil"))
    println(crearVuelo("Cuenca",30))
    println(crearVuelo("Manta",40,"VIP",true))
    
    println(crearVuelo(edad=15,nombre="Loja",activo=false))
}

fun crearVuelo(
    nombre:String,
    edad:Int=18,
    rol:String="Nacional",
    activo:Boolean=true
):String{
    return "Vuelo[$nombre, edad=$edad, rol=$rol, activo=$activo]"
}