// Online Kotlin compiler to run Kotlin program online
// Print "Try programiz.pro" message

fun main() {
  println("Funciones-Parametros por defecto")
  println(crerUsuario("Jhon",25, "admin", true))
  println(crerUsuario(" Luis"))
  println(crerUsuario("Maria", 30))
  println(crerUsuario("Juan", 30, "admin", true))
  
  println(crearUsuario(edad=30, nombre "Yamilet", activo= false))
}
fun crearUsuario(
  nombre: String,
  edad: Int= 18,
  rol: String = "viewer",
  activo: Boolean = true
  ): String{
      return "Usuario[$nombre, edad=$edad, rol=$rol, activo =$activo]"
  }
