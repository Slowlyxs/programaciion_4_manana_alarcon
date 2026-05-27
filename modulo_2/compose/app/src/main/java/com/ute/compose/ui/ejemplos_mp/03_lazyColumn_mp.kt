package com.ute.compose.ui.material3

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.tuapp.aeropuerto.model.Pasajero
import com.tuapp.aeropuerto.model.pasajerosDeMuestra

@Composable
fun Paso03_LazyColumnScreen() {

    var pasajeros by remember { mutableStateOf(pasajerosDeMuestra) }
    var busqueda  by remember { mutableStateOf("") }
    var filtro    by remember { mutableStateOf("Todos") }

    // Lista derivada — se recalcula en cada recomposición
    val pasajerosFiltrados = pasajeros
        .filter { p ->
            when (filtro) {
                "Favoritos" -> p.favorito
                "Abordando" -> p.estado == "Abordando"
                "Demorado"  -> p.estado == "Demorado"
                else        -> true
            }
        }
        .filter { p ->
            busqueda.isBlank() ||
                p.nombre.contains(busqueda, ignoreCase = true) ||
                p.ruta.contains(busqueda, ignoreCase = true)
        }

    Column(modifier = Modifier.fillMaxSize()) {

        Text(
            "Paso 3 · LazyColumn + LazyRow",
            style    = MaterialTheme.typography.titleMedium,
            modifier = Modifier.padding(16.dp)
        )

        // ── Buscador ──────────────────────────────────────────────────────
        OutlinedTextField(
            value         = busqueda,
            onValueChange = { busqueda = it },
            placeholder   = { Text("Buscar pasajero o destino...") },
            leadingIcon   = { Icon(Icons.Default.Search, contentDescription = null) },
            trailingIcon  = {
                if (busqueda.isNotEmpty())
                    IconButton(onClick = { busqueda = "" }) {
                        Icon(Icons.Default.Clear, contentDescription = "Limpiar")
                    }
            },
            singleLine = true,
            modifier   = Modifier
                .fillMaxWidth()
                .padding(horizontal = 16.dp)
        )

        Spacer(Modifier.height(8.dp))

        // ── LazyRow: filtros de estado ────────────────────────────────────
        LazyRow(
            horizontalArrangement = Arrangement.spacedBy(8.dp),
            contentPadding        = PaddingValues(horizontal = 16.dp)
        ) {
            items(listOf("Todos", "Favoritos", "Abordando", "Demorado")) { opcion ->
                FilterChip(
                    selected = filtro == opcion,
                    onClick  = { filtro = opcion },
                    label    = { Text(opcion) },
                    leadingIcon = if (filtro == opcion) {{
                        Icon(
                            Icons.Default.Check,
                            contentDescription = null,
                            modifier = Modifier.size(FilterChipDefaults.IconSize)
                        )
                    }} else null
                )
            }
        }

        Spacer(Modifier.height(8.dp))

        // ── LazyColumn: lista principal ───────────────────────────────────
        if (pasajerosFiltrados.isEmpty()) {
            Box(
                modifier         = Modifier.fillMaxSize(),
                contentAlignment = Alignment.Center
            ) {
                Column(horizontalAlignment = Alignment.CenterHorizontally) {
                    Icon(
                        Icons.Default.AirplaneTicket,
                        contentDescription = null,
                        modifier = Modifier.size(56.dp),
                        tint     = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                    Spacer(Modifier.height(12.dp))
                    Text(
                        "Sin resultados",
                        style = MaterialTheme.typography.bodyLarge,
                        color = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }
            }
        } else {
            LazyColumn(
                contentPadding      = PaddingValues(horizontal = 16.dp, vertical = 8.dp),
                verticalArrangement = Arrangement.spacedBy(8.dp)
            ) {
                item {
                    Text(
                        "${pasajerosFiltrados.size} pasajero(s)",
                        style    = MaterialTheme.typography.labelSmall,
                        color    = MaterialTheme.colorScheme.onSurfaceVariant,
                        modifier = Modifier.padding(bottom = 4.dp)
                    )
                }

                items(
                    items = pasajerosFiltrados,
                    key   = { it.id }
                ) { pasajero ->
                    TarjetaPasajero(
                        pasajero    = pasajero,
                        onContactar = { /* Paso 6: snackbar */ },
                        onFavorito  = {
                            pasajeros = pasajeros.map { p ->
                                if (p.id == pasajero.id) p.copy(favorito = !p.favorito)
                                else p
                            }
                        }
                    )
                }

                item { Spacer(Modifier.height(16.dp)) }
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun Paso03_Preview() {
    MaterialTheme { Paso03_LazyColumnScreen() }
}