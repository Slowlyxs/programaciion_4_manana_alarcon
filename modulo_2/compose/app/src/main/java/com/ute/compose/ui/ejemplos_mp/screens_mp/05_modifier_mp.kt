package com.ute.compose.ui.screns

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
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
fun S05_ModifierScreen() {

    var ultimoClick by remember { mutableStateOf("Seleccione una opción") }

    Column(
        modifier = Modifier.fillMaxSize().padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp)
    ) {

        Text(
            "Gestión de vuelos",
            style = MaterialTheme.typography.titleMedium
        )

        HorizontalDivider()

        Surface(
            color = MaterialTheme.colorScheme.surfaceVariant,
            modifier = Modifier.fillMaxWidth()
        ) {

            Text(
                ultimoClick,
                Modifier.padding(12.dp),
                style = MaterialTheme.typography.bodySmall
            )
        }

        EtiquetaSeccion("1. clip antes de background")

        Box(
            modifier = Modifier
                .size(130.dp)
                .clip(RoundedCornerShape(16.dp))
                .background(MaterialTheme.colorScheme.primaryContainer)
                .border(2.dp, MaterialTheme.colorScheme.primary, RoundedCornerShape(16.dp))
                .padding(12.dp)
                .clickable { ultimoClick = "Panel de vuelos seleccionado" },

            contentAlignment = Alignment.Center
        ) {

            Text(
                "Panel de\nvuelos",
                style = MaterialTheme.typography.labelSmall,
                color = MaterialTheme.colorScheme.onPrimaryContainer
            )
        }

        EtiquetaSeccion("2. background antes de clip")

        Box(
            modifier = Modifier
                .size(130.dp)
                .background(Color(0xFFFFCDD2))
                .clip(RoundedCornerShape(16.dp))
                .padding(12.dp),

            contentAlignment = Alignment.Center
        ) {

            Text(
                "Zona de\nembarque",
                style = MaterialTheme.typography.labelSmall
            )
        }

        EtiquetaSeccion("3. CircleShape + clickable")

        Row(horizontalArrangement = Arrangement.spacedBy(12.dp)) {

            listOf(
                "A" to Color(0xFF1976D2),
                "B" to Color(0xFF388E3C),
                "C" to Color(0xFFF57C00)
            ).forEach { (letra, color) ->

                Box(
                    modifier = Modifier
                        .size(56.dp)
                        .clip(CircleShape)
                        .background(color)
                        .clickable { ultimoClick = "Terminal $letra seleccionada" },

                    contentAlignment = Alignment.Center
                ) {

                    Text(
                        letra,
                        color = Color.White,
                        style = MaterialTheme.typography.titleMedium
                    )
                }
            }
        }

        EtiquetaSeccion("4. fillMaxWidth + padding")

        Text(
            text = "Información del vuelo internacional",
            modifier = Modifier
                .fillMaxWidth()
                .background(Color(0xFFE8F5E9))
                .padding(horizontal = 32.dp, vertical = 8.dp)
        )

        EtiquetaSeccion("5. size fijo vs fillMaxWidth")

        Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {

            Box(
                Modifier
                    .size(60.dp)
                    .background(Color(0xFFBBDEFB)),

                contentAlignment = Alignment.Center
            ) {

                Text("Local")
            }

            Box(
                Modifier
                    .weight(1f)
                    .height(60.dp)
                    .background(Color(0xFFB3E5FC)),

                contentAlignment = Alignment.Center
            ) {

                Text("Internacional")
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
fun S05_Preview() {
    MaterialTheme { S05_ModifierScreen() }
}