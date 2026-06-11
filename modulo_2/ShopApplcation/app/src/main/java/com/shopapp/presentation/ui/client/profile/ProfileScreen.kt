// presentation/ui/client/profile/ProfileScreen.kt
package com.shopapp.presentation.ui.client.profile

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.Logout
import androidx.compose.material.icons.filled.Edit
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.shopapp.presentation.viewmodel.ProfileViewModel

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ProfileScreen(
    onEditProfile: () -> Unit       = {},
    onLogout:      () -> Unit       = {},
    viewModel:     ProfileViewModel = hiltViewModel(),
) {
    val state by viewModel.state.collectAsState()
    val snackbarHostState = remember { SnackbarHostState() }

    LaunchedEffect(Unit) {
        viewModel.snackbar.collect { message ->
            snackbarHostState.showSnackbar(message)
        }
    }

    Scaffold(
        topBar        = { TopAppBar(title = { Text("Mi perfil") }) },
        snackbarHost  = { SnackbarHost(snackbarHostState) },
    ) { padding ->
        when {
            state.isLoading -> {
                Box(
                    contentAlignment = Alignment.Center,
                    modifier         = Modifier.fillMaxSize().padding(padding),
                ) { CircularProgressIndicator() }
            }

            state.error != null -> {
                Box(
                    contentAlignment = Alignment.Center,
                    modifier         = Modifier.fillMaxSize().padding(padding),
                ) {
                    Column(horizontalAlignment = Alignment.CenterHorizontally) {
                        Text(state.error ?: "Error", color = MaterialTheme.colorScheme.error)
                        Spacer(Modifier.height(8.dp))
                        Button(onClick = { viewModel.loadProfile() }) { Text("Reintentar") }
                    }
                }
            }

            else -> {
                val profile = state.profile

                Column(
                    horizontalAlignment = Alignment.CenterHorizontally,
                    modifier            = Modifier
                        .fillMaxSize()
                        .padding(padding)
                        .verticalScroll(rememberScrollState())
                        .padding(horizontal = 16.dp),
                ) {
                    Spacer(Modifier.height(24.dp))

                    // ── Avatar ───────────────────────────────────────────────
                    AvatarSection(
                        avatarUrl       = state.avatarUrl,
                        username        = profile?.username ?: "",
                        isUploading     = state.isUploading,
                        onImageSelected = { uri -> viewModel.uploadAvatar(uri) },
                    )

                    Spacer(Modifier.height(12.dp))

                    Text(
                        text       = profile?.username ?: "—",
                        style      = MaterialTheme.typography.titleLarge,
                        fontWeight = FontWeight.Bold,
                    )
                    Text(
                        text  = profile?.email ?: "—",
                        style = MaterialTheme.typography.bodyMedium,
                        color = MaterialTheme.colorScheme.onSurfaceVariant,
                    )

                    Spacer(Modifier.height(4.dp))

                    if (profile?.isStaff == true) {
                        SuggestionChip(onClick = {}, label = { Text("Staff") })
                    }

                    Spacer(Modifier.height(24.dp))
                    HorizontalDivider()
                    Spacer(Modifier.height(16.dp))

                    OutlinedButton(
                        onClick  = onEditProfile,
                        modifier = Modifier.fillMaxWidth(),
                    ) {
                        Icon(Icons.Default.Edit, null, modifier = Modifier.size(18.dp))
                        Spacer(Modifier.width(8.dp))
                        Text("Editar perfil")
                    }

                    Spacer(Modifier.height(8.dp))

                    OutlinedButton(
                        onClick  = onLogout,
                        modifier = Modifier.fillMaxWidth(),
                        colors   = ButtonDefaults.outlinedButtonColors(
                            contentColor = MaterialTheme.colorScheme.error,
                        ),
                    ) {
                        Icon(
                            Icons.AutoMirrored.Filled.Logout,
                            null,
                            modifier = Modifier.size(18.dp),
                        )
                        Spacer(Modifier.width(8.dp))
                        Text("Cerrar sesión")
                    }

                    Spacer(Modifier.height(24.dp))
                }
            }
        }
    }
}