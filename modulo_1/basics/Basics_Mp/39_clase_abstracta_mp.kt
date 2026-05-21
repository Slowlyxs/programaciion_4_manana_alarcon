abstract class ZonaAeropuerto(val nombre:String){
    abstract val area:Double
    abstract val perimetro:Double
    abstract fun descripcion():String

    fun comparar(otra:ZonaAeropuerto):String = when{
        area > otra.area -> "$nombre es mas grande que ${otra.nombre}"
        area < otra.area -> "$nombre es mas pequena que ${otra.nombre}"
        else -> "$nombre y ${otra.nombre} tienen la misma area"
    }

    override fun toString() = "${descripcion()} | Area: ${"%.2f".format(area)}"
}

class Pista(val largo:Double):ZonaAeropuerto("Pista"){
    override val area:Double get() = largo * 50
    override val perimetro:Double get() = 2 * (largo + 50)
    override fun descripcion() = "Pista de largo $largo"
}

class Terminal(val ancho:Double,val alto:Double):ZonaAeropuerto("Terminal"){
    override val area:Double get() = ancho * alto
    override val perimetro:Double get() = 2 * (ancho + alto)
    override fun descripcion() = "Terminal de ${ancho}x${alto}"
}

class Hangar(val lado:Double):ZonaAeropuerto("Hangar"){
    override val area:Double get() = lado * lado
    override val perimetro:Double get() = 4 * lado
    override fun descripcion() = "Hangar de lado $lado"
}

fun main() {
    println("EJERCICIO AEREOPUERTO")
    
    val zonas:List<ZonaAeropuerto> = listOf(
        Pista(100.0),
        Terminal(40.0,20.0),
        Hangar(30.0)
    )

    zonas.forEach { println(it) }

    val mayor = zonas.maxByOrNull { it.area }

    println("Figura mas grande: ${mayor?.nombre}")

    println(zonas[0].comparar(zonas[1]))
}