package com.ute.compose.ui.material3

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.FlightTakeoff
import androidx.compose.material.icons.filled.Luggage
import androidx.compose.material.icons.filled.Scale
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp

@Composable
fun Ejercicoenclase01() {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
            .verticalScroll(rememberScrollState()),
        verticalArrangement = Arrangement.spacedBy(24.dp)
    ) {
        Text(
            "Paso 1 · TextField y OutlinedTextField",
            style = MaterialTheme.typography.titleMedium
        )
        HorizontalDivider()
        TarifaEquipaje()
    }
}

@Composable
private fun TarifaEquipaje() {

    var destinoVuelo     by remember { mutableStateOf("") }
    var numeroMaletas    by remember { mutableStateOf("") }
    var pesoPorMaleta    by remember { mutableStateOf("") }
    var subtotal         by remember { mutableStateOf("") }
    var descuentoAplicado by remember { mutableStateOf("") }
    var totalPagar       by remember { mutableStateOf("") }

    Column(verticalArrangement = Arrangement.spacedBy(12.dp)) {

        Text(
            "Registro de Equipaje",
            style = MaterialTheme.typography.labelLarge,
            color = MaterialTheme.colorScheme.primary
        )

        // Destino del vuelo
        OutlinedTextField(
            value = destinoVuelo,
            onValueChange = { destinoVuelo = it },
            label = { Text("Destino del vuelo") },
            leadingIcon = { Icon(Icons.Default.FlightTakeoff, null) },
            keyboardOptions = KeyboardOptions(imeAction = ImeAction.Next),
            singleLine = true,
            modifier = Modifier.fillMaxWidth()
        )

        // Número de maletas
        OutlinedTextField(
            value = numeroMaletas,
            onValueChange = { numeroMaletas = it },
            label = { Text("Número de maletas") },
            leadingIcon = { Icon(Icons.Default.Luggage, null) },
            keyboardOptions = KeyboardOptions(
                keyboardType = KeyboardType.Number,
                imeAction = ImeAction.Next
            ),
            singleLine = true,
            modifier = Modifier.fillMaxWidth()
        )

        // Peso por maleta
        OutlinedTextField(
            value = pesoPorMaleta,
            onValueChange = { pesoPorMaleta = it },
            label = { Text("Peso por maleta (kg)") },
            leadingIcon = { Icon(Icons.Default.Scale, null) },
            keyboardOptions = KeyboardOptions(
                keyboardType = KeyboardType.Number,
                imeAction = ImeAction.Done
            ),
            singleLine = true,
            modifier = Modifier.fillMaxWidth()
        )

        // Botón calcular
        Button(
            onClick = {
                val TARIFA_BASE = 8.50

                val maletas = numeroMaletas.toDoubleOrNull() ?: 0.0
                val peso    = pesoPorMaleta.toDoubleOrNull() ?: 0.0
                val pesoTotal = maletas * peso

                val subtotalDouble = pesoTotal * TARIFA_BASE

                val porcentaje = when {