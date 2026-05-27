package com.ute.compose.ui.screns

import androidx.compose.foundation.layout.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp

@Composable
fun S03_ButtonScreen() {

    var ultimoClick by remember { mutableStateOf("(ninguno)") }

    Column(
        modifier = Modifier.fillMaxSize().padding(24.dp),
        verticalArrangement = Arrangement.spacedBy(10.dp),
        horizontalAlignment = Alignment.CenterHorizontally
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
                text = "Última acción: $ultimoClick",
                modifier = Modifier.padding(12.dp),
                style = MaterialTheme.typography.bodyMedium
            )
        }

        Spacer(Modifier.height(4.dp))

        Button(
            onClick = { ultimoClick = "Registrar vuelo" },
            modifier = Modifier.fillMaxWidth()
        ) {
            Text("Registrar vuelo")
        }

        Button(
            onClick = { ultimoClick = "Agregar pasajero" },
            modifier = Modifier.fillMaxWidth()
        ) {
            Icon(
                imageVector = Icons.Default.Add,
                contentDescription = null,
                modifier = Modifier.size(18.dp)
            )

            Spacer(Modifier.width(8.dp))

            Text("Agregar pasajero")
        }

        OutlinedButton(
            onClick = { ultimoClick = "Consultar vuelos" },
            modifier = Modifier.fillMaxWidth()
        ) {
            Text("Consultar vuelos")
        }

        TextButton(
            onClick = { ultimoClick = "Ver horarios" },
            modifier = Modifier.fillMaxWidth()
        ) {
            Text("Ver horarios")
        }

        ElevatedButton(
            onClick = { ultimoClick = "Actualizar estado" },
            modifier = Modifier.fillMaxWidth()
        ) {
            Text("Actualizar estado")
        }

        FilledTonalButton(
            onClick = { ultimoClick = "Ver terminales" },
            modifier = Modifier.fillMaxWidth()
        ) {
            Text("Ver terminales")
        }

        Button(
            onClick = { },
            enabled = false,
            modifier = Modifier.fillMaxWidth()
        ) {
            Text("Vuelo no disponible")
        }

        HorizontalDivider()

        EtiquetaSeccion("Acciones rápidas")

        Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {

            IconButton(onClick = { ultimoClick = "Agregar vuelo" }) {
                Icon(Icons.Default.Add, contentDescription = "Agregar")
            }

            IconButton(onClick = { ultimoClick = "Eliminar vuelo" }) {
                Icon(
                    Icons.Default.Delete,
                    contentDescription = "Eliminar",
                    tint = MaterialTheme.colorScheme.error
                )
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
fun S03Preview() {
    MaterialTheme { S03_ButtonScreen() }
}