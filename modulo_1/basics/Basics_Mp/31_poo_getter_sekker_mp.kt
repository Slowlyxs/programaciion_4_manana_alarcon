class TemperaturaAeropuerto(celsius:Double) {

    var celsius:Double = celsius
        set(value) {
            require(value >= -50.0) { "Temperatura invalida en aeropuerto" }
            field = value
        }

    val fahrenheit:Double
        get() = celsius * 9.0 / 5.0 + 32.0

    val kelvin:Double
        get() = celsius + 273.15

    val descripcion:String
        get() = when {
            celsius < 0  -> "Clima extremo"
            celsius < 15 -> "Frio"
            celsius < 25 -> "Templado"
            celsius < 35 -> "Caluroso"
            else         -> "Muy caluroso"
        }
}

fun main() {
    println("EJERCICIO AEREOPUERTO")
    
    val temp = TemperaturaAeropuerto(20.0)
    
    println("${temp.celsius}°C = ${temp.fahrenheit}°F = ${temp.kelvin}K")
    println(temp.descripcion)
    
    temp.celsius = -5.0
    
    println("${temp.celsius}°C -> ${temp.descripcion}")
}