package com.tuapp.compose.ui

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp

@Composable
fun VueloInfo(destino: String) {
    Text(text = "Vuelo con destino a $destino")
}

@Composable
fun S01_VuelosScreen() {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(24.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {

        Text(
            "Gestión de vuelos",
            style = MaterialTheme.typography.titleMedium
        )

        HorizontalDivider()

        // Mismo composable con distintos vuelos
        VueloInfo("Quito")
        VueloInfo("Guayaquil")
        VueloInfo("Cuenca")

        HorizontalDivider()

        EstadoVuelo(disponible = true)
        EstadoVuelo(disponible = false)
    }
}

@Composable
private fun EstadoVuelo(disponible: Boolean) {

    if (disponible) {
        Text(" Vuelo disponible")
    } else {
        Text(
            "Vuelo no disponible",
            color = MaterialTheme.colorScheme.outline
        )
    }
}

@Preview(showBackground = true)
@Composable
fun PreviewVuelos() {
    MaterialTheme {
        S01_VuelosScreen()
    }
}