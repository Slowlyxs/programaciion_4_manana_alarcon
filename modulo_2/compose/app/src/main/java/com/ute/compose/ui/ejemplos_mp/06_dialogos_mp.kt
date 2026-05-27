package com.ute.compose.ui.material3

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material.icons.outlined.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.window.Dialog
import com.tuapp.aeropuerto.model.Pasajero
import com.tuapp.aeropuerto.model.pasajerosDeMuestra

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun Paso06_DialogosScreen() {

    var pasajeros          by remember { mutableStateOf(pasajerosDeMuestra) }
    var busqueda           by remember { mutableStateOf("") }
    var filtro             by remember { mutableStateOf("Todos") }
    var destinoActual      by remember { mutableStateOf("vuelos") }
    var mostrarNuevo       by remember { mutableStateOf(false) }
    var pasajeroAEliminar  by remember { mutableStateOf<Pasajero?>(null) }
    var mensajeSnack       by remember { mutableStateOf<String?>(null) }

    val snackbarHostState = remember { SnackbarHostState() }

    LaunchedEffect(mensajeSnack) {
        mensajeSnack?.let {
            snackbarHostState.showSnackbar(it)
            mensajeSnack = null
        }
    }

    val pasajerosFiltrados = pasajeros
        .filter { p -> if (filtro == "Favoritos") p.favorito else true }
        .filter { p -> busqueda.isBlank() || p.nombre.contains(busqueda, ignoreCase = true)
                    || p.ruta.contains(busqueda, ignoreCase = true) }

    val destinos = listOf(
        DestinoNav("vuelos",    "Vuelos",   Icons.Filled.Flight,        Icons.Outlined.Flight),
        DestinoNav("favoritos", "Favoritos",Icons.Filled.Favorite,      Icons.Outlined.FavoriteBorder),
        DestinoNav("perfil",    "Perfil",   Icons.Filled.AccountCircle, Icons.Outlined.AccountCircle),
    )

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Vuelos (${pasajeros.size})", fontWeight = FontWeight.Bold) },
                actions = {
                    IconButton(onClick = {
                        filtro = if (filtro == "Favoritos") "Todos" else "Favoritos"
                    }) {
                        Icon(
                            imageVector = if (filtro == "Favoritos")
                                Icons.Default.Favorite else Icons.Default.FavoriteBorder,
                            contentDescription = "Filtrar favoritos",
                            tint = if (filtro == "Favoritos")
                                MaterialTheme.colorScheme.error
                            else
                                MaterialTheme.colorScheme.onPrimaryContainer
                        )
                    }
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
                    val sel = destinoActual == destino.ruta
                    NavigationBarItem(
                        selected = sel,
                        onClick  = { destinoActual = destino.ruta },
                        icon     = { Icon(if (sel) destino.iconoActivo else destino.iconoInactivo, destino.etiqueta) },
                        label    = { Text(destino.etiqueta) }
                    )
                }
            }
        },
        floatingActionButton = {
            if (destinoActual == "vuelos") {
                FloatingActionButton(onClick = { mostrarNuevo = true }) {
                    Icon(Icons.Default.PersonAdd, "Nuevo pasajero")
                }
            }
        },
        snackbarHost = { SnackbarHost(snackbarHostState) }

    ) { paddingValues ->
        when (destinoActual) {
            "vuelos" -> ContenidoVuelos(
                pasajeros  = pasajerosFiltrados,
                busqueda   = busqueda,
                filtro     = filtro,
                onBusqueda = { busqueda = it },
                onFiltro   = { filtro = it },
                onFavorito = { id ->
                    pasajeros = pasajeros.map { p ->
                        if (p.id == id) p.copy(favorito = !p.favorito) else p
                    }
                },
                onLlamar   = { nombre -> mensajeSnack = "📞 Contactando a $nombre..." },
                onEliminar = { pasajero -> pasajeroAEliminar = pasajero },
                modifier   = Modifier.padding(paddingValues)
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

    // ── Diálogo 1: Nuevo pasajero ────────────────────────────────────────────
    if (mostrarNuevo) {
        DialogNuevoPasajero(
            onDismiss = { mostrarNuevo = false },
            onGuardar = { nuevo ->
                pasajeros    = pasajeros + nuevo
                mostrarNuevo = false
                mensajeSnack = "✅ ${nuevo.nombre} agregado"
            }
        )
    }

    // ── Diálogo 2: Confirmar eliminación ─────────────────────────────────────
    pasajeroAEliminar?.let { pasajero ->
        AlertDialog(
            onDismissRequest = { pasajeroAEliminar = null },
            icon    = { Icon(Icons.Default.Warning, null, tint = MaterialTheme.colorScheme.error) },
            title   = { Text("Eliminar pasajero") },
            text    = { Text("¿Seguro que quieres eliminar a ${pasajero.nombre}? Esta acción no se puede deshacer.") },
            confirmButton = {
                Button(
                    onClick = {
                        pasajeros        = pasajeros.filter { it.id != pasajero.id }
                        mensajeSnack     = "🗑 ${pasajero.nombre} eliminado"
                        pasajeroAEliminar = null
                    },
                    colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.error)
                ) { Text("Eliminar") }
            },
            dismissButton = {
                OutlinedButton(onClick = { pasajeroAEliminar = null }) { Text("Cancelar") }
            }
        )
    }
}

// ── Contenido pestaña Vuelos ──────────────────────────────────────────────────
@Composable
private fun ContenidoVuelos(
    pasajeros:  List<Pasajero>,
    busqueda:   String,
    filtro:     String,
    onBusqueda: (String) -> Unit,
    onFiltro:   (String) -> Unit,
    onFavorito: (Int) -> Unit,
    onLlamar:   (String) -> Unit,
    onEliminar: (Pasajero) -> Unit,
    modifier:   Modifier = Modifier
) {
    Column(modifier = modifier.fillMaxSize()) {
        OutlinedTextField(
            value         = busqueda,
            onValueChange = onBusqueda,
            placeholder   = { Text("Buscar pasajero o destino...") },
            leadingIcon   = { Icon(Icons.Default.Search, null) },
            trailingIcon  = {
                if (busqueda.isNotEmpty())
                    IconButton(onClick = { onBusqueda("") }) {
                        Icon(Icons.Default.Clear, "Limpiar")
                    }
            },
            singleLine = true,
            modifier   = Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 8.dp)
        )
        LazyRow(
            horizontalArrangement = Arrangement.spacedBy(8.dp),
            contentPadding        = PaddingValues(horizontal = 16.dp)
        ) {
            items(listOf("Todos", "Favoritos")) { opcion ->
                FilterChip(
                    selected    = filtro == opcion,
                    onClick     = { onFiltro(opcion) },
                    label       = { Text(opcion) },
                    leadingIcon = if (filtro == opcion) {{
                        Icon(Icons.Default.Check, null, Modifier.size(FilterChipDefaults.IconSize))
                    }} else null
                )
            }
        }
        Spacer(Modifier.height(4.dp))
        LazyColumn(
            contentPadding      = PaddingValues(horizontal = 16.dp, vertical = 8.dp),
            verticalArrangement = Arrangement.spacedBy(8.dp)
        ) {
            item {
                Text("${pasajeros.size} pasajero(s)",
                    style    = MaterialTheme.typography.labelSmall,
                    color    = MaterialTheme.colorScheme.onSurfaceVariant,
                    modifier = Modifier.padding(bottom = 4.dp))
            }
            items(pasajeros, key = { it.id }) { pasajero ->
                TarjetaPasajeroCompleta(
                    pasajero   = pasajero,
                    onFavorito = { onFavorito(pasajero.id) },
                    onLlamar   = { onLlamar(pasajero.nombre) },
                    onEliminar = { onEliminar(pasajero) }
                )
            }
            item { Spacer(Modifier.height(100.dp)) }
        }
    }
}

// ── Tarjeta con botón eliminar ────────────────────────────────────────────────
@Composable
private fun TarjetaPasajeroCompleta(
    pasajero:   Pasajero,
    onFavorito: () -> Unit,
    onLlamar:   () -> Unit,
    onEliminar: () -> Unit
) {
    ElevatedCard(modifier = Modifier.fillMaxWidth()) {
        Row(modifier = Modifier.padding(12.dp), verticalAlignment = Alignment.CenterVertically) {
            Box(
                modifier = Modifier.size(48.dp)
                    .clip(androidx.compose.foundation.shape.CircleShape)
                    .background(MaterialTheme.colorScheme.primaryContainer),
                contentAlignment = Alignment.Center
            ) {
                Text(pasajero.nombre.first().uppercase(),
                    style = MaterialTheme.typography.titleMedium,
                    fontWeight = FontWeight.Bold,
                    color = MaterialTheme.colorScheme.onPrimaryContainer)
            }
            Spacer(Modifier.width(12.dp))
            Column(Modifier.weight(1f)) {
                Text(pasajero.nombre, fontWeight = FontWeight.SemiBold,
                    style = MaterialTheme.typography.titleSmall)
                Text("${pasajero.ruta} · ${pasajero.vuelo}",
                    style = MaterialTheme.typography.bodySmall,
                    color = MaterialTheme.colorScheme.onSurfaceVariant)
            }
            IconButton(onClick = onFavorito) {
                Icon(
                    if (pasajero.favorito) Icons.Default.Favorite else Icons.Default.FavoriteBorder,
                    null,
                    tint = if (pasajero.favorito) MaterialTheme.colorScheme.error
                           else MaterialTheme.colorScheme.onSurfaceVariant
                )
            }
            IconButton(onClick = onLlamar) {
                Icon(Icons.Default.Headset, null, tint = MaterialTheme.colorScheme.primary)
            }
            IconButton(onClick = onEliminar) {
                Icon(Icons.Default.Delete, null, tint = MaterialTheme.colorScheme.error)
            }
        }
    }
}

// ── Diálogo formulario nuevo pasajero ────────────────────────────────────────
@Composable
private fun DialogNuevoPasajero(
    onDismiss: () -> Unit,
    onGuardar: (Pasajero) -> Unit
) {
    var nombre by remember { mutableStateOf("") }
    var ruta   by remember { mutableStateOf("") }
    var vuelo  by remember { mutableStateOf("") }

    val valido = nombre.trim().length >= 2
              && ruta.trim().length   >= 3
              && vuelo.trim().length  >= 2

    Dialog(onDismissRequest = onDismiss) {
        Card(modifier = Modifier.fillMaxWidth()) {
            Column(modifier = Modifier.padding(24.dp), verticalArrangement = Arrangement.spacedBy(12.dp)) {
                Text("Nuevo pasajero", style = MaterialTheme.typography.titleLarge, fontWeight = FontWeight.Bold)
                OutlinedTextField(
                    value = nombre, onValueChange = { nombre = it },
                    label = { Text("Nombre completo") },
                    leadingIcon = { Icon(Icons.Default.Person, null) },
                    singleLine = true, modifier = Modifier.fillMaxWidth(),
                    keyboardOptions = KeyboardOptions(imeAction = ImeAction.Next)
                )
                OutlinedTextField(
                    value = ruta, onValueChange = { ruta = it },
                    label = { Text("Ruta (ej. UIO → BOG)") },
                    leadingIcon = { Icon(Icons.Default.FlightTakeoff, null) },
                    singleLine = true, modifier = Modifier.fillMaxWidth(),
                    keyboardOptions = KeyboardOptions(imeAction = ImeAction.Next)
                )
                OutlinedTextField(
                    value = vuelo, onValueChange = { vuelo = it },
                    label = { Text("Número de vuelo") },
                    leadingIcon = { Icon(Icons.Default.ConfirmationNumber, null) },
                    singleLine = true, modifier = Modifier.fillMaxWidth(),
                    keyboardOptions = KeyboardOptions(imeAction = ImeAction.Done)
                )
                Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.End) {
                    TextButton(onClick = onDismiss) { Text("Cancelar") }
                    Spacer(Modifier.width(8.dp))
                    Button(
                        onClick = {
                            onGuardar(Pasajero(
                                id     = System.currentTimeMillis().toInt(),
                                nombre = nombre.trim(),
                                ruta   = ruta.trim(),
                                vuelo  = vuelo.trim()
                            ))
                        },
                        enabled = valido
                    ) { Text("Guardar") }
                }
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun Paso06_Preview() {
    MaterialTheme { Paso06_DialogosScreen() }
}