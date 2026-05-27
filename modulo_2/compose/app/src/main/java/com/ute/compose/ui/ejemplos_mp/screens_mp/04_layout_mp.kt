package com.ute.compose.ui.screns

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp

@Composable
fun S04_LayoutScreen() {

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
            .verticalScroll(rememberScrollState()),
        verticalArrangement = Arrangement.spacedBy(20.dp)
    ) {

        Text(
            "Gestión de vuelos",
            style = MaterialTheme.typography.titleMedium
        )

        HorizontalDivider()

        EtiquetaSeccion("Column — vuelos registrados")

        Column(
            modifier = Modifier
                .fillMaxWidth()
                .background(Color(0xFFE3F2FD))
                .padding(12.dp),
            verticalArrangement = Arrangement.spacedBy(4.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {

            CeldaLayout("Vuelo Quito", Color(0xFF90CAF9))
            CeldaLayout("Vuelo Guayaquil", Color(0xFF64B5F6))
            CeldaLayout("Vuelo Cuenca", Color(0xFF42A5F5))
        }

        EtiquetaSeccion("Row — terminales")

        Row(
            modifier = Modifier
                .fillMaxWidth()
                .background(Color(0xFFF3E5F5))
                .padding(12.dp),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {

            Text("Terminal A")
            Text("Terminal B")
            Text("Terminal C")
        }

        EtiquetaSeccion("Row — puertas de embarque")

        Row(
            modifier = Modifier
                .fillMaxWidth()
                .background(Color(0xFFE8F5E9))
                .padding(12.dp),
            horizontalArrangement = Arrangement.SpaceEvenly
        ) {

            Text("P1")
            Text("P2")
            Text("P3")
            Text("P4")
        }

        EtiquetaSeccion("Row + weight")

        Row(
            Modifier
                .fillMaxWidth()
                .height(50.dp)
        ) {

            Box(
                Modifier
                    .weight(1f)
                    .fillMaxHeight()
                    .background(Color(0xFFEF9A9A)),
                contentAlignment = Alignment.Center
            ) {
                Text("Local")
            }

            Box(
                Modifier
                    .weight(2f)
                    .fillMaxHeight()
                    .background(Color(0xFFE57373)),
                contentAlignment = Alignment.Center
            ) {
                Text("Internacional")
            }

            Box(
                Modifier
                    .weight(1f)
                    .fillMaxHeight()
                    .background(Color(0xFFEF5350)),
                contentAlignment = Alignment.Center
            ) {
                Text("Carga")
            }
        }

        EtiquetaSeccion("Box — panel de información")

        Box(
            modifier = Modifier
                .fillMaxWidth()
                .height(120.dp)
                .background(Color(0xFF1565C0)),
            contentAlignment = Alignment.Center
        ) {

            Box(
                Modifier
                    .size(40.dp)
                    .background(Color(0xFF42A5F5))
                    .align(Alignment.TopStart)
            )

            Box(
                Modifier
                    .size(40.dp)
                    .background(Color(0xFF1976D2))
                    .align(Alignment.BottomEnd)
            )

            Text(
                "Panel principal de vuelos",
                color = Color.White,
                style = MaterialTheme.typography.labelLarge
            )
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

@Composable
private fun CeldaLayout(label: String, color: Color) {

    Box(
        modifier = Modifier
            .fillMaxWidth()
            .height(36.dp)
            .background(color),
        contentAlignment = Alignment.Center
    ) {

        Text(
            label,
            style = MaterialTheme.typography.labelMedium
        )
    }
}

@Preview(showBackground = true)
@Composable
fun S04_Preview() {
    MaterialTheme { S04_LayoutScreen() }
}