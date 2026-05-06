package com.ute.compose

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.material3.MaterialTheme
import com.tuapp.compose.ui.*
import com.ute.compose.ui.material3.Paso01_TextFieldScreen
import com.ute.compose.ui.screns.S05_ModifierScreen
import com.ute.compose.ui.screns.S06_EstadoScreen
import com.ute.compose.ui.screns.S07_StateHoistingScreen
import com.ute.compose.ui.screns.S08_BienvenidaScreen

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            MaterialTheme {
                // ◀ BASICOS NATIVOS
                //S01_SaludoScreen()
                //S02_TextScreen()
                //S03_ButtonScreen()
                //S04_LayoutScreen()
                 //S05_ModifierScreen()
                 //S06_EstadoScreen()
                 //S07_StateHoistingScreen()
                //S08_BienvenidaScreen()
                // ◀ Componentes material 3 :
                 Paso01_TextFieldScreen()
                // Paso02_CardScreen()
                // Paso03_LazyColumnScreen()
                // Paso04_ScaffoldScreen()
                // Paso05_NavBarScreen()
                //Paso06_DialogosScreen()   // ← paso activo
            }
        }
    }
}