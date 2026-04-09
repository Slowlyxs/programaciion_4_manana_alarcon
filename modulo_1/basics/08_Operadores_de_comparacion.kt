fun main() {
    println("Operadores logicos")
    
    val esMayor = true
    val tienePermiso = false
    val estaActivo = true
    
    println("&& - And Logico")
    println("$esMayor && $tienePermiso = ${esMayor && tienePermiso}")
    println("$estaActivo && $esMayor = ${estaActivo && esMayor}")
    
    println("|| - Or Logico")
    println("$esMayor || $tienePermiso = ${esMayor || tienePermiso}")
    println("$estaActivo || $esMayor = ${estaActivo || esMayor}")
    
    println("! - Not")
    println("!$esMayor = ${!esMayor}")
    println("!$estaActivo = ${!estaActivo}")
}