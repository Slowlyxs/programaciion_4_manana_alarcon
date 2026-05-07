package com.ute.compose.ui.material3

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.AttachMoney
import androidx.compose.material.icons.filled.Person
import androidx.compose.material.icons.filled.ShoppingCart
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

        SumaNumeros()
    }
}

@Composable
private fun SumaNumeros() {

    // Variables
    var nombreProducto by remember { mutableStateOf("") }

    var cantidadComprada by remember { mutableStateOf("") }

    var precioUnitario by remember { mutableStateOf("") }

    var subtotal by remember { mutableStateOf("") }

    var descuentoAplicado by remember { mutableStateOf("") }

    var totalPagar by remember { mutableStateOf("") }

    Column(
        verticalArrangement = Arrangement.spacedBy(12.dp)
    ) {

        Text(
            "Formulario de Compra",
            style = MaterialTheme.typography.labelLarge,
            color = MaterialTheme.colorScheme.primary
        )

        // Nombre del producto
        OutlinedTextField(
            value = nombreProducto,
            onValueChange = { nombreProducto = it },
            label = { Text("Nombre del producto") },
            leadingIcon = {
                Icon(Icons.Default.ShoppingCart, null)
            },
            keyboardOptions = KeyboardOptions(
                imeAction = ImeAction.Next
            ),
            singleLine = true,
            modifier = Modifier.fillMaxWidth()
        )

        // Cantidad comprada
        OutlinedTextField(
            value = cantidadComprada,
            onValueChange = { cantidadComprada = it },
            label = { Text("Cantidad comprada") },
            leadingIcon = {
                Icon(Icons.Default.Person, null)
            },
            keyboardOptions = KeyboardOptions(
                keyboardType = KeyboardType.Number,
                imeAction = ImeAction.Next
            ),
            singleLine = true,
            modifier = Modifier.fillMaxWidth()
        )

        // Precio unitario
        OutlinedTextField(
            value = precioUnitario,
            onValueChange = { precioUnitario = it },
            label = { Text("Precio unitario") },
            leadingIcon = {
                Icon(Icons.Default.AttachMoney, null)
            },
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

                val cantidad =
                    cantidadComprada.toDoubleOrNull() ?: 0.0

                val precio =
                    precioUnitario.toDoubleOrNull() ?: 0.0

                val subtotalDouble =
                    cantidad * precio

                val porcentaje =
                    when {
                        subtotalDouble > 50 -> 0.10
                        subtotalDouble > 20 -> 0.05
                        else -> 0.0
                    }
                val descuentoDouble =
                    subtotalDouble * porcentaje
                val totalDouble =
                    subtotalDouble - descuentoDouble
                subtotal = subtotalDouble.toString()
                descuentoAplicado =
                    descuentoDouble.toString()
                totalPagar =
                    totalDouble.toString()
            },
            modifier = Modifier.fillMaxWidth()
        ) {
            Text("Calcular")
        }
        // Resultados
        Text(
            text = "Nombre del producto: $nombreProducto"
        )
        Text(
            text = "Subtotal: $subtotal"
        )
        Text(
            text = "Descuento aplicado: $descuentoAplicado"
        )
        Text(
            text = "Total a pagar: $totalPagar"
        )
    }
}

@Preview(showBackground = true)
@Composable
fun Ejercicoenclase01Preview() {

    MaterialTheme {

        Ejercicoenclase01()
    }
}