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
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.tuapp.aeropuerto.model.pasajerosDeMuestra

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun Paso04_ScaffoldScreen() {

    var pasajeros  by remember { mutableStateOf(pasajerosDeMuestra) }
    var busqueda   by remember { mutableStateOf("") }
    var filtro     by remember { mutableStateOf("Todos") }
    var mostrarFab by remember { mutableStateOf(false) }

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

    Scaffold(
        // ── TopAppBar ──────────────────────────────────────────────────────
        topBar = {
            TopAppBar(
                title = {
                    Text(
                        "Vuelos (${pasajeros.size})",
                        fontWeight = FontWeight.Bold
                    )
                },
                actions = {
                    // Botón favoritos en la barra
                    IconButton(onClick = {
                        filtro = if (filtro == "Favoritos") "Todos" else "Favoritos"
                    }) {
                        Icon(
                            imageVector        = if (filtro == "Favoritos")
                                Icons.Default.Favorite else Icons.Default.FavoriteBorder,
                            contentDescription = "Filtrar favoritos",
                            tint               = if (filtro == "Favoritos")
                                MaterialTheme.colorScheme.error
                            else
                                MaterialTheme.colorScheme.onPrimaryContainer
                        )
                    }
                    // Botón notificaciones
                    IconButton(onClick = { /* Paso 6: notificaciones */ }) {
                        Icon(
                            imageVector        = Icons.Default.Notifications,
                            contentDescription = "Notificaciones de vuelo",
                            tint               = MaterialTheme.colorScheme.onPrimaryContainer
                        )
                    }
                },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor    = MaterialTheme.colorScheme.primaryContainer,
                    titleContentColor = MaterialTheme.colorScheme.onPrimaryContainer
                )
            )
        },

        // ── FAB ────────────────────────────────────────────────────────────
        floatingActionButton = {
            FloatingActionButton(onClick = { mostrarFab = true }) {
                Icon(Icons.Default.PersonAdd, contentDescription = "Nuevo pasajero")
            }
        }

    ) { paddingValues ->
        Column(
            modifier = Modifier
                .padding(paddingValues) // ← CRÍTICO
                .fillMaxSize()
        ) {
            // Buscador
            OutlinedTextField(
                value         = busqueda,
                onValueChange = { busqueda = it },
                placeholder   = { Text("Buscar pasajero o destino...") },
                leadingIcon   = { Icon(Icons.Default.Search, null) },
                trailingIcon  = {
                    if (busqueda.isNotEmpty())
                        IconButton(onClick = { busqueda = "" }) {
                            Icon(Icons.Default.Clear, "Limpiar")
                        }
                },
                singleLine = true,
                modifier   = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = 16.dp, vertical = 8.dp)
            )

            // Chips de filtro
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
                            Icon(Icons.Default.Check, null,
                                Modifier.size(FilterChipDefaults.IconSize))
                        }} else null
                    )
                }
            }

            Spacer(Modifier.height(4.dp))

            // Lista de pasajeros
            LazyColumn(
                contentPadding      = PaddingValues(horizontal = 16.dp, vertical = 8.dp),
                verticalArrangement = Arrangement.spacedBy(8.dp)
            ) {
                item {
                    Text(
                        "${pasajerosFiltrados.size} resultado(s)",
                        style    = MaterialTheme.typography.labelSmall,
                        color    = MaterialTheme.colorScheme.onSurfaceVariant,
                        modifier = Modifier.padding(bottom = 4.dp)
                    )
                }

                items(pasajerosFiltrados, key = { it.id }) { pasajero ->
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

                item { Spacer(Modifier.height(80.dp)) } // espacio para FAB
            }
        }
    }

    // Diálogo del FAB
    if (mostrarFab) {
        AlertDialog(
            onDismissRequest = { mostrarFab = false },
            title   = { Text("Nuevo pasajero") },
            text    = { Text("Esta función se conectará con el formulario de registro en el Paso 6.") },
            confirmButton = {
                TextButton(onClick = { mostrarFab = false }) { Text("OK") }
            }
        )
    }
}

@Preview(showBackground = true)
@Composable
fun Paso04_Preview() {
    MaterialTheme { Paso04_ScaffoldScreen() }
}