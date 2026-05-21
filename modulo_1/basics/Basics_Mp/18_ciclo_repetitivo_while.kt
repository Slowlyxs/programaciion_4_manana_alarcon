fun main() {
    println("Ejercicio de aeropuertos")
    println("Controles de Flujo Iteraciones Ciclos repetitivos - Ciclo While")
    
    println("While basico")
    var contador = 1
    
    while(contador <= 5){
        println("Vuelo $contador")
        contador++;
    }
    
    println("Do While")
    contador = 1
    
    do{
        println("Puerta $contador")
        contador++;
    }while(contador <=5)
    
    println("Break continue")
    contador = 1
    
    while(contador <= 10){
        contador++;
        
        if(contador==3)continue
        if(contador==7)break
        
        println("Pasajero $contador")
    }
    
    var input:String
    
    while(true){
        println("Escribe 'salir' para terminar:")
        input=readLine()?:""
        
        if(input=="salir")break
        
        println("Usted ingreso: $input")
    }
    
    var input1:Int
    
    while(true){
        println("Escribe un numero 1.-CheckIn 2.-Equipaje 3.-Vuelos 4.-Salir")
        
        input1=readLine()?.toIntOrNull()?:0
        
        val codigo = when(input1){
            1->"CheckIn"
            2->"Equipaje"
            3->"Vuelos"
            else -> "Salir"
        }
        
        println("Usted selecciono $codigo")
        
        if(input1==4)break
    }
    
    println("¿Cuantos vuelos registrar?")
    
    val vuelos = readLine()?.toIntOrNull() ?: 0
    
    var totalPasajeros = 0
    
    repeat(vuelos) { i ->
        println("Vuelo ${i + 1} cantidad de pasajeros:")
        
        val pasajeros = readLine()?.toIntOrNull() ?: 0
        
        totalPasajeros += pasajeros
    }
    
    val promedio = if(vuelos > 0) totalPasajeros / vuelos else 0
    
    println("Promedio pasajeros: $promedio")
    
    val clasificacion = when {
        promedio < 50 -> "Bajo"
        promedio <= 150 -> "Normal"
        else -> "Alto"
    }
    
    println("Clasificacion: $clasificacion")
}