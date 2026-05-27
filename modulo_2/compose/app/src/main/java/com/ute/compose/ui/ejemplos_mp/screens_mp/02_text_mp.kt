package com.ute.compose.ui.screns

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextDecoration
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun S02_VuelosTextScreen() {
    Column(
        modifier = Modifier.fillMaxSize().padding(24.dp),
        verticalArrangement = Arrangement.spacedBy(12.dp)
    ) {

        Text("Gestión de vuelos", style = MaterialTheme.typography.titleMedium)

        HorizontalDivider()

        EtiquetaSeccion("1. Información básica")
        Text("Vuelo con destino a Quito")

        EtiquetaSeccion("2. Tamaño y estilo")
        Text("Vuelo Internacional", fontSize = 24.sp, fontWeight = FontWeight.Bold)
        Text("Vuelo retrasado", fontSize = 18.sp, fontStyle = FontStyle.Italic)
        Text("Sala de embarque", fontSize = 20.sp, fontWeight = FontWeight.Light)

        EtiquetaSeccion("3. Color y decoración")
        Text("Vuelo confirmado", color = Color(0xFF1976D2))
        Text("Puerta asignada", textDecoration = TextDecoration.Underline)
        Text("Vuelo cancelado", textDecoration = TextDecoration.LineThrough, color = MaterialTheme.colorScheme.onSurfaceVariant)

        EtiquetaSeccion("4. maxLines + TextOverflow")

        Text(
            text = "El vuelo con destino a Guayaquil presenta una demora debido a condiciones climáticas en la pista principal del aeropuerto",
            maxLines = 1,
            overflow = TextOverflow.Ellipsis
        )

        Text(
            text = "Los pasajeros del vuelo internacional deben acercarse a la puerta de embarque treinta minutos antes de la salida programada",
            maxLines = 2,
            overflow = TextOverflow.Ellipsis
        )

        EtiquetaSeccion("5. Tipografía Material 3")
        Text("Panel de vuelos", style = MaterialTheme.typography.headlineMedium)
        Text("Información del aeropuerto", style = MaterialTheme.typography.titleLarge)
        Text("Horario de salida", style = MaterialTheme.typography.bodyLarge)
        Text("Estado del vuelo", style = MaterialTheme.typography.bodySmall)
        Text("Terminal 1", style = MaterialTheme.typography.labelSmall)

        EtiquetaSeccion("6. TextAlign")

        Text(
            text = "Información centrada del aeropuerto",
            textAlign = TextAlign.Center,
            modifier = Modifier.fillMaxWidth()
        )

        Text(
            text = "Hora de embarque",
            textAlign = TextAlign.End,
            modifier = Modifier.fillMaxWidth()
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
fun S02_Preview() {
    MaterialTheme { S02_VuelosTextScreen() }
}