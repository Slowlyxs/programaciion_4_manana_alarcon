data class Vuelo(
    val id:Int,
    val destino:String,
    val precio:Double,
    val categoria:String,
    val activo:Boolean = true
)

fun main() {
    println("EJERCICIO AEREOPUERTO")
    
    val v1 = Vuelo(1,"Madrid",899.99,"Internacional")
    val v2 = Vuelo(1,"Madrid",899.99,"Internacional")
    val v3 = Vuelo(2,"Quito",199.99,"Nacional")
    
    println(v1)
    
    println(v1 == v2)
    println(v1 == v3)
    
    val barato = v1.copy(precio = 599.99)
    val inactivo = v1.copy(activo = false)
    
    println(barato)
    println(inactivo)
    
    val(id,destino,precio) = v1
    
    println("$id: $destino - $$precio")
    
    listOf(v1,v3).forEach { (id2,destino2,precio2) ->
        println("[$id2] $destino2: $$precio2")
    }
}