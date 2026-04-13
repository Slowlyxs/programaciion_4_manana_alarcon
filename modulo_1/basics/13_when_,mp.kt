fun main() {
  println("Controles de Flujo When")
  println("Escriba codigo para el laboratorio")
  val codigo = readLine()?.toIntOrNull()?:0
  val muestra = when(codigo){
    1->"Sangre venosa (4h)"
    2->"Orina(2h)"
    3->"Heces(24h)"
    4->"Hispoado nasofaringeo(6h)"
    5->"Biopsia (72)"
    else -> "Verifique nuevamente la especialidad solicitado"
}
println("Tipo de muestra y tiempo: $muestra")
}