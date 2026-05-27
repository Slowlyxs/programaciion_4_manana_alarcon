package com.ute.compose.ui.screns

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp

@Composable
fun S07_StateHoistingScreen() {

    Column(
        modifier = Modifier.fillMaxSize().padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(20.dp)
    ) {

        Text(
            "Gestión de vuelos",
            style = MaterialTheme.typography.titleMedium
        )

        HorizontalDivider()

        DemoEstadoAtrapado()

        HorizontalDivider()

        DemoEstadoElevado()
    }
}

@Composable
private fun DemoEstadoAtrapado() {

    Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {

        EtiquetaSeccion("Estado atrapado")

        Text(
            "El estado vive dentro del botón y el sistema principal no puede acceder a la información.",
            style = MaterialTheme.typography.bodySmall,
            color = MaterialTheme.colorScheme.onSurfaceVariant
        )

        BotonAtrapado()

        Text(
            "El panel principal no puede mostrar la cantidad de registros.",
            style = MaterialTheme.typography.bodySmall,
            color = MaterialTheme.colorScheme.error
        )
    }
}

@Composable
private fun BotonAtrapado() {

    var vuelos by remember { mutableStateOf(0) }

    Button(onClick = { vuelos++ }) {

        Text("Vuelos registrados: $vuelos")
    }
}

@Composable
private fun DemoEstadoElevado() {

    var terminalSeleccionada by remember { mutableStateOf<String?>(null) }

    var historial by remember { mutableStateOf(listOf<String>()) }

    val terminales = listOf(
        "Terminal Norte",
        "Terminal Sur",
        "Terminal Internacional",
        "Terminal Carga"
    )

    Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {

        EtiquetaSeccion("Estado elevado")

        Text(
            "El componente hijo informa la selección y el padre administra el estado.",
            style = MaterialTheme.typography.bodySmall,
            color = MaterialTheme.colorScheme.onSurfaceVariant
        )

        SelectorOpciones(
            opciones = terminales,
            seleccion = terminalSeleccionada,
            onSeleccion = { opcion ->

                terminalSeleccionada = opcion

                historial = (historial + opcion).takeLast(4)
            }
        )

        terminalSeleccionada?.let { terminal ->

            val color = when {
                "Norte" in terminal -> Color(0xFFBBDEFB)
                "Sur" in terminal -> Color(0xFFC8E6C9)
                "Internacional" in terminal -> Color(0xFFFFF9C4)
                "Carga" in terminal -> Color(0xFFFFCDD2)
                else -> Color.Transparent
            }

            Box(
                modifier = Modifier
                    .fillMaxWidth()
                    .height(48.dp)
                    .clip(RoundedCornerShape(8.dp))
                    .background(color),

                contentAlignment = Alignment.Center
            ) {

                Text(
                    "Seleccionado: $terminal",
                    style = MaterialTheme.typography.labelLarge
                )
            }
        }

        if (historial.isNotEmpty()) {

            Text(
                "Historial: ${historial.joinToString(" → ")}",
                style = MaterialTheme.typography.bodySmall,
                color = MaterialTheme.colorScheme.onSurfaceVariant
            )
        }
    }
}

@Composable
private fun SelectorOpciones(
    opciones: List<String>,
    seleccion: String?,
    onSeleccion: (String) -> Unit
) {

    Column(verticalArrangement = Arrangement.spacedBy(4.dp)) {

        opciones.forEach { opcion ->

            val estaSeleccionado = seleccion == opcion

            Button(
                onClick = { onSeleccion(opcion) },
                modifier = Modifier.fillMaxWidth(),

                colors = if (estaSeleccionado)
                    ButtonDefaults.buttonColors()
                else
                    ButtonDefaults.outlinedButtonColors()
            ) {

                Text(opcion)
            }
        }
    }
}

@Composable
internal fun EtiquetaSeccion(texto: String) {

    Text(
        text = texto,
        style = MaterialTheme.typography.labelMedium,
        color = MaterialTheme.colorScheme.primary
    )
}

@Preview(showBackground = true)
@Composable
fun S07_Preview() {
    MaterialTheme { S07_StateHoistingScreen() }
}