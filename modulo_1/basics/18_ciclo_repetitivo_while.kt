// Online Kotlin compiler to run Kotlin program online
// Print "Try programiz.pro" message

fun main() {
  println("Controles de Flujo Iteraciones, Ciclo repetitivos - Ciclo While")
  println("While basico")
  var contador = 1
  while(contador <= 5){
      println(contador)
      contador++;
  }
  println("Do While")
  contador = 1
  do{
      println(contador)
      contador++;
    }while(contador <=5)
    
 println("Break continue")
 contador = 1
 while(contador <= 10){
     contador++;
     if(contador==3)continue
     if(contador==7)break
     println(contador)
 }
 var input: String
 while(true){
     println("Escribe 'salir' para terminar:")
     input=readLine()?:""
     if (input=="salir") break
     println("usted ingreso: $input")
 }
 var input1: Int
 while(true){
     println("Escribe un numero 1 .- saludar 2.- sumar 3.-tabla 4.-Salir")
     input1=readLine()?.toIntOrNull()?:0
     val codigo = when(input1){
         1->"Saludar"
         2->"Sumar"
         3->"tabla"
         else -> "Salir"
     }
    println("usted selecciono $codigo")
     if (input1==4)break
 }
 fun main() {
    println("Controles de Flujo Iteraciones, Ciclo repetitivos - Ciclo While")
    println("¿Cuántas mediciones tomar para calcular la frecuencia cardiaca?")

    val medicaciones = readLine()?.toIntOrNull() ?: 0
    var totalPulsaciones = 0

    repeat(medicaciones) { i ->
        println("Medición ${i + 1} (pulsos en 15 seg.)")
        val pulsos = readLine()?.toIntOrNull() ?: 0
        totalPulsaciones += pulsos * 4 // convertir a 60 segundos
    }

    val promedio = if (medicaciones > 0) totalPulsaciones / medicaciones else 0

    println("Frecuencia cardiaca promedio: $promedio lpm")

    val clasificacion = when {
        promedio < 60 -> "Bradicardia"
        promedio <= 100 -> "Normal"
        else -> "Taquicardia"
    }

    println("Clasificación: $clasificacion")
}
}