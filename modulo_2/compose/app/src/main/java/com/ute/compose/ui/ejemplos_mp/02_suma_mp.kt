package com.ute.compose.ui.material3

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.tuapp.aeropuerto.model.Pasajero
import com.tuapp.aeropuerto.model.pasajerosDeMuestra

// ── Data class y datos de muestra ────────────────────────────────────────────
data class Pasajero(
    val nombre:   String,
    val vuelo:    String,   // ej. "UIO → BOG"
    val asiento:  String,   // ej. "12A"
    val estado:   String,   // "A tiempo", "Demorado", "Abordando"
    val favorito: Boolean = false
)

val pasajerosDeMuestra = listOf(
    Pasajero("Ana Morales",   "UIO → BOG", "12A", "Abordando",  favorito = true),
    Pasajero("Carlos Peña",   "GYE → LIM", "7C",  "A tiempo"),
    Pasajero("Sofía Vargas",  "UIO → MAD", "24F", "Demorado"),
)

// ── Composable reutilizable ───────────────────────────────────────────────────
@Composable
fun TarjetaPasajero(
    pasajero:   Pasajero,
    onClick:    () -> Unit = {},
    onContactar: () -> Unit = {},
    onFavorito: () -> Unit = {}
) {
    ElevatedCard(
        onClick  = onClick,
        modifier = Modifier.fillMaxWidth()
    ) {
        Row(
            modifier          = Modifier.padding(12.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            // ── Avatar con inicial ─────────────────────────────────────────
            Box(
                modifier         = Modifier
                    .size(52.dp)
                    .clip(CircleShape)
                    .background(MaterialTheme.colorScheme.primaryContainer),
                contentAlignment = Alignment.Center
            ) {
                Text(
                    text       = pasajero.nombre.first().uppercase(),
                    style      = MaterialTheme.typography.titleLarge,
                    fontWeight = FontWeight.Bold,
                    color      = MaterialTheme.colorScheme.onPrimaryContainer
                )
            }

            Spacer(Modifier.width(12.dp))

            // ── Datos del pasajero ─────────────────────────────────────────
            Column(modifier = Modifier.weight(1f)) {
                Text(
                    text       = pasajero.nombre,
                    style      = MaterialTheme.typography.titleSmall,
                    fontWeight = FontWeight.SemiBold
                )
                Text(
                    text  = pasajero.vuelo,
                    style = MaterialTheme.typography.bodySmall,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
                Spacer(Modifier.height(4.dp))
                Row(horizontalArrangement = Arrangement.spacedBy(6.dp)) {
                    // Asiento
                    AssistChip(
                        onClick = {},
                        label   = {
                            Text(
                                "Asiento ${pasajero.asiento}",
                                style = MaterialTheme.typography.labelSmall
                            )
                        }
                    )
                    // Estado del vuelo
                    AssistChip(
                        onClick = {},
                        label   = {
                            Text(
                                pasajero.estado,
                                style = MaterialTheme.typography.labelSmall
                            )
                        }
                    )
                }
            }

            // ── Acciones rápidas ───────────────────────────────────────────
            Column(horizontalAlignment = Alignment.CenterHorizontally) {
                IconButton(onClick = onFavorito) {
                    Icon(
                        imageVector        = if (pasajero.favorito) Icons.Default.Favorite
                                             else Icons.Default.FavoriteBorder,
                        contentDescription = if (pasajero.favorito) "Quitar favorito"
                                             else "Marcar favorito",
                        tint               = if (pasajero.favorito)
                                                 MaterialTheme.colorScheme.error
                                             else
                                                 MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }
                IconButton(onClick = onContactar) {
                    Icon(
                        imageVector        = Icons.Default.Headset,
                        contentDescription = "Contactar",
                        tint               = MaterialTheme.colorScheme.primary
                    )
                }
            }
        }
    }
}

// ── Screen del paso 2 ─────────────────────────────────────────────────────────
@Composable
fun Paso02_CardScreen() {
    Column(
        modifier            = Modifier.fillMaxSize().padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(12.dp)
    ) {
        Text("Paso 2 · Card y ElevatedCard",
            style = MaterialTheme.typography.titleMedium)
        HorizontalDivider()

        Text("ElevatedCard — pasajero interactivo",
            style = MaterialTheme.typography.labelMedium,
            color = MaterialTheme.colorScheme.primary)

        pasajerosDeMuestra.take(3).forEach { pasajero ->
            TarjetaPasajero(
                pasajero    = pasajero,
                onClick     = { /* Paso 6: navegar al detalle */ },
                onContactar = { /* Paso 6: mostrar snackbar */ },
                onFavorito  = { /* Paso 3: toggle en la lista */ }
            )
        }

        HorizontalDivider()
        Text("Comparación de variantes",
            style = MaterialTheme.typography.labelMedium,
            color = MaterialTheme.colorScheme.primary)

        Card(modifier = Modifier.fillMaxWidth()) {
            Text("Card — sin elevación visible", Modifier.padding(16.dp))
        }
        ElevatedCard(modifier = Modifier.fillMaxWidth()) {
            Text("ElevatedCard — con sombra", Modifier.padding(16.dp))
        }
        OutlinedCard(modifier = Modifier.fillMaxWidth()) {
            Text("OutlinedCard — solo borde", Modifier.padding(16.dp))
        }
    }
}

@Preview(showBackground = true)
@Composable
fun Paso02_Preview() {
    MaterialTheme { Paso02_CardScreen() }
}