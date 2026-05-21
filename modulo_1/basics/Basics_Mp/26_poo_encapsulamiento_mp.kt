class ControlVuelo(pasajero:String,equipajeInicial:Double) {

    val pasajero:String = pasajero

    private var equipaje:Double = equipajeInicial

    internal val numeroVuelo:String =
        "AV${(1000..9999).random()}"

    protected open fun calcularPesoExtra():Double = equipaje * 0.05

    fun agregarEquipaje(peso:Double) {
        require(peso > 0) { "El peso debe ser positivo" }
        
        equipaje += peso
        
        println("Equipaje agregado: ${"%.2f".format(peso)}kg | Peso total: ${consultarEquipaje()}")
    }

    fun retirarEquipaje(peso:Double):Boolean {
        require(peso > 0) { "El peso debe ser positivo" }
        
        if(peso > equipaje) {
            println("Peso insuficiente")
            return false
        }
        
        equipaje -= peso
        
        println("Equipaje retirado: ${"%.2f".format(peso)}kg | Peso total: ${consultarEquipaje()}")
        
        return true
    }

    fun consultarEquipaje():String = "${"%.2f".format(equipaje)}kg"
}

fun main() {
    println("Ejercicio de aeropuertos")
    
    val vuelo = ControlVuelo("Carlos Perez",30.0)

    vuelo.agregarEquipaje(10.0)
    vuelo.retirarEquipaje(5.0)
    vuelo.retirarEquipaje(50.0)

    println(vuelo.pasajero)
    println(vuelo.consultarEquipaje())
}