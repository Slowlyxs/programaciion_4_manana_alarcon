fun main() {
println("Controles de Flujo When")
println("Escriba codigo")
val codigo = readLine()?.toIntOrNull()?:0
val especialidad = when(codigo){
    1->"Medicina General"
    2->"Pediatria"
    3->"Cardiologia"
    4->"Neurologia"
    5->"Dermatologia"
    6->"Ginecologia"
    else -> "Especialidad no registrada en el sistema"
}
println("Especialidad: $especialidad")
}