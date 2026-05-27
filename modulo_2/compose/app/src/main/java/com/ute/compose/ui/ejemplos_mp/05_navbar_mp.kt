package com.ute.compose.ui.material3

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material.icons.outlined.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.tuapp.aeropuerto.model.Pasajero
import com.tuapp.aeropuerto.model.pasajerosDeMuestra

data class DestinoNav(
    val ruta:          String,
    val etiqueta:      String,
    val iconoActivo:   ImageVector,
    val iconoInactivo: ImageVector
)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun Paso05_NavBarScreen() {
    var destinoActual by remember { mutableStateOf("vuelos") }
    var pasajeros     by remember { mutableStateOf(pasajerosDeMuestra) }

    val destinos = listOf(
        DestinoNav("vuelos",    "Vuelos",   Icons.Filled.Flight,        Icons.Outlined.Flight),
        DestinoNav("favoritos", "Favoritos",Icons.Filled.Favorite,      Icons.Outlined.FavoriteBorder),
        DestinoNav("perfil",    "Perfil",   Icons.Filled.AccountCircle, Icons.Outlined.AccountCircle),
    )

    Scaffold(
        topBar = {
            TopAppBar(
                title = {
                    val titulo = when (destinoActual) {
                        "favoritos" -> "Favoritos"
                        "perfil"    -> "Mi Perfil"
                        else        -> "Vuelos"
                    }
                    Text(titulo, fontWeight = FontWeight.Bold)
                },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor    = MaterialTheme.colorScheme.primaryContainer,
                    titleContentColor = MaterialTheme.colorScheme.onPrimaryContainer
                )
            )
        },
        bottomBar = {
            NavigationBar {
                destinos.forEach { destino ->
                    val seleccionado = destinoActual == destino.ruta
                    NavigationBarItem(
                        selected = seleccionado,
                        onClick  = { destinoActual = destino.ruta },
                        icon     = {
                            Icon(
                                if (seleccionado) destino.iconoActivo else destino.iconoInactivo,
                                contentDescription = destino.etiqueta
                            )
                        },
                        label = { Text(destino.etiqueta) }
                    )
                }
            }
        },
        floatingActionButton = {
            if (destinoActual == "vuelos") {
                FloatingActionButton(onClick = { /* Paso 6 */ }) {
                    Icon(Icons.Default.PersonAdd, "Nuevo pasajero")
                }
            }
        }
    ) { paddingValues ->
        when (destinoActual) {
            "vuelos"    -> PantallaVuelosContent(
                pasajeros  = pasajeros,
                onFavorito = { id ->
                    pasajeros = pasajeros.map { p ->
                        if (p.id == id) p.copy(favorito = !p.favorito) else p
                    }
                },
                modifier = Modifier.padding(paddingValues)
            )
            "favoritos" -> PantallaFavoritosContent(
                favoritos = pasajeros.filter { it.favorito },
                modifier  = Modifier.padding(paddingValues)
            )
            "perfil"    -> PantallaPerfilContent(
                modifier  = Modifier.padding(paddingValues)
            )
        }
    }
}

@Composable
private fun PantallaVuelosContent(
    pasajeros:  List<Pasajero>,
    onFavorito: (Int) -> Unit,
    modifier:   Modifier = Modifier
) {
    LazyColumn(
        modifier            = modifier,
        contentPadding      = PaddingValues(16.dp),
        verticalArrangement = Arrangement.spacedBy(8.dp)
    ) {
        items(pasajeros, key = { it.id }) { pasajero ->
            TarjetaPasajero(
                pasajero   = pasajero,
                onFavorito = { onFavorito(pasajero.id) }
            )
        }
        item { Spacer(Modifier.height(80.dp)) }
    }
}

@Composable
fun PantallaFavoritosContent(
    favoritos: List<Pasajero>,
    modifier:  Modifier = Modifier
) {
    if (favoritos.isEmpty()) {
        Box(modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
            Column(horizontalAlignment = Alignment.CenterHorizontally) {
                Icon(Icons.Default.FavoriteBorder, null, Modifier.size(56.dp),
                    tint = MaterialTheme.colorScheme.onSurfaceVariant)
                Spacer(Modifier.height(12.dp))
                Text("Sin favoritos aún",
                    color = MaterialTheme.colorScheme.onSurfaceVariant)
                Text("Toca el corazón en un vuelo",
                    style = MaterialTheme.typography.bodySmall,
                    color = MaterialTheme.colorScheme.onSurfaceVariant)
            }
        }
    } else {
        LazyColumn(
            modifier            = modifier,
            contentPadding      = PaddingValues(16.dp),
            verticalArrangement = Arrangement.spacedBy(8.dp)
        ) {
            items(favoritos, key = { it.id }) { pasajero ->
                TarjetaPasajero(pasajero = pasajero)
            }
        }
    }
}

@Composable
fun PantallaPerfilContent(modifier: Modifier = Modifier) {
    Box(modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            Icon(Icons.Default.AccountCircle, null, Modifier.size(80.dp),
                tint = MaterialTheme.colorScheme.primary)
            Spacer(Modifier.height(12.dp))
            Text("Juan Rodríguez", style = MaterialTheme.typography.titleLarge,
                fontWeight = FontWeight.Bold)
            Text("Próximamente...",
                style = MaterialTheme.typography.bodyMedium,
                color = MaterialTheme.colorScheme.onSurfaceVariant)
        }
    }
}

@Preview(showBackground = true)
@Composable
fun Paso05_Preview() {
    MaterialTheme { Paso05_NavBarScreen() }
}