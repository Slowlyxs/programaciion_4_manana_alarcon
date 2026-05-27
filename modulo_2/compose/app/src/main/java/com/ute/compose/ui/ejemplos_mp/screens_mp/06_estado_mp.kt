package com.ute.compose.ui.screns

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp

@Composable
fun S06_EstadoScreen() {

    Column(
        modifier = Modifier.fillMaxSize().padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(24.dp)
    ) {

        Text(
            "Gestión de vuelos",
            style = MaterialTheme.typography.titleMedium
        )

        HorizontalDivider()

        DemoContadorS6()

        HorizontalDivider()

        DemoEstadoDerivado()
    }
}

@Composable
private fun DemoContadorS6() {

    var vuelos by remember { mutableStateOf(0) }

    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.spacedBy(8.dp)
    ) {

        EtiquetaSeccion("Contador de vuelos")

        Text(
            text = "$vuelos",
            style = MaterialTheme.typography.displayMedium,
            fontWeight = FontWeight.Bold
        )

        Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {

            Button(onClick = { vuelos-- }) {
                Text("−")
            }

            Button(onClick = { vuelos++ }) {
                Text("+")
            }

            OutlinedButton(onClick = { vuelos = 0 }) {
                Text("Reset")
            }
        }

        Text(
            "Cantidad de vuelos registrados",
            style = MaterialTheme.typography.bodySmall,
            color = MaterialTheme.colorScheme.onSurfaceVariant
        )
    }
}

@Composable
private fun DemoEstadoDerivado() {

    var nivelSeguridad by remember { mutableStateOf(0) }

    val max = 5

    val porcentaje = nivelSeguridad.toFloat() / max

    val estado = when {
        nivelSeguridad == 0 -> "Sin control"
        nivelSeguridad <= 2 -> "Básico"
        nivelSeguridad <= 4 -> "Intermedio"
        else -> "Avanzado"
    }

    Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {

        EtiquetaSeccion("Nivel de seguridad del aeropuerto")

        Text(
            "$estado ($nivelSeguridad/$max)",
            style = MaterialTheme.typography.titleMedium,
            fontWeight = FontWeight.SemiBold
        )

        LinearProgressIndicator(
            progress = { porcentaje },
            modifier = Modifier
                .fillMaxWidth()
                .height(12.dp)
                .clip(RoundedCornerShape(6.dp))
        )

        Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {

            OutlinedButton(
                onClick = { if (nivelSeguridad > 0) nivelSeguridad-- },
                enabled = nivelSeguridad > 0
            ) {

                Text("Reducir")
            }

            Button(
                onClick = { if (nivelSeguridad < max) nivelSeguridad++ },
                enabled = nivelSeguridad < max
            ) {

                Text("Aumentar")
            }
        }

        Text(
            "Control de seguridad: ${"%.0f".format(porcentaje * 100)}%",
            style = MaterialTheme.typography.bodySmall,
            color = MaterialTheme.colorScheme.onSurfaceVariant
        )
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
fun S06_Preview() {
    MaterialTheme { S06_EstadoScreen() }
}