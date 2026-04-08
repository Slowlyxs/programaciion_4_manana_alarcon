
fun main() {
   //tipo de datos
   //Numeros enteros
    val numero1: Byte=127
    println("Numero Byte $numero1")
    val numero2: Short= 32_765
    println("Numero Short $numero2")
    val numero3: Int= 12
    println("Numero int $numero3")
    val numero4: Long=12_122-122_122_122
    println("Numero Long $numero4")
    
    
    println("Numeros decimales")
    val numero5: Float= 3.14f
    println("Numero Float $numero5")
    val numero6: Double= 3.14159
    println("Numero Double $numero6") 
    
    //Inferido
    val nombre = "Juana"
    val edad = 45
    
    println("Nombre $nombre")
    println("Tipo inferido nombre: ${nombre::class.simpleName}")
    println("Edad: $edad")
    println("Tipo inferido edad: ${edad::class.simpleName}")
}