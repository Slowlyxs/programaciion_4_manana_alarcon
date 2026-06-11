// presentation/navigation/NavGraph.kt
package com.shopapp.presentation.navigation

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.*
import androidx.navigation.compose.*
import com.shopapp.presentation.components.LoadingScreen
import com.shopapp.presentation.ui.admin.AdminScaffold
import com.shopapp.presentation.ui.admin.categories.CategoriesAdminScreen
import com.shopapp.presentation.ui.admin.dashboard.DashboardScreen
import com.shopapp.presentation.ui.admin.orders.OrderAdminDetailScreen
import com.shopapp.presentation.ui.admin.orders.OrdersAdminScreen
import com.shopapp.presentation.ui.admin.products.ProductsAdminScreen
import com.shopapp.presentation.ui.admin.users.UsersAdminScreen
import com.shopapp.presentation.ui.auth.LoginScreen
import com.shopapp.presentation.ui.auth.RegisterScreen
import com.shopapp.presentation.ui.client.orders.OrderDetailScreen
import com.shopapp.presentation.ui.client.orders.OrdersScreen
import com.shopapp.presentation.ui.client.profile.ProfileScreen
import com.shopapp.presentation.ui.uipublic.cart.CartBottomSheet
import com.shopapp.presentation.ui.uipublic.catalog.CatalogScreen
import com.shopapp.presentation.ui.uipublic.home.HomeScreen
import com.shopapp.presentation.ui.uipublic.product.ProductDetailScreen
import com.shopapp.presentation.viewmodel.AuthViewModel
import com.shopapp.presentation.viewmodel.CartViewModel
import com.shopapp.presentation.viewmodel.OrdersAdminViewModel
import com.shopapp.theme.Surface

@Composable
fun NavGraph(
    authViewModel: AuthViewModel,
    cartViewModel: CartViewModel = hiltViewModel(),
) {
    val navController = rememberNavController()

    val isCheckingSession by authViewModel.isCheckingSession.collectAsState()
    val isAuthenticated   by authViewModel.isAuthenticated.collectAsState()
    val isStaff           by authViewModel.isStaff.collectAsState()
    val currentUser       by authViewModel.currentUser.collectAsState()
    val cartCount         by cartViewModel.totalItems.collectAsState()

    var showCart by remember { mutableStateOf(false) }

    if (isCheckingSession) {
        LoadingScreen("Iniciando ShopApp...")
        return
    }

    val startDestination = when {
        !isAuthenticated -> Screen.Login.route
        isStaff          -> Screen.AdminDashboard.route
        else             -> Screen.Home.route
    }

    val navBackStackEntry by navController.currentBackStackEntryAsState()
    val currentRoute = navBackStackEntry?.destination?.route

    val showBottomBar = currentRoute in listOf(
        Screen.Home.route,
        Screen.Catalog.route,
        Screen.Orders.route,
        Screen.Profile.route,
    )

    Scaffold(
        containerColor = Surface,
        bottomBar = {
            if (showBottomBar) {
                BottomNavBar(
                    navController = navController,
                    cartCount = cartCount,
                    onCartClick = { showCart = true },
                )
            }
        }
    ) { innerPadding ->

        if (showCart) {
            CartBottomSheet(
                cartViewModel = cartViewModel,
                isAuthenticated = isAuthenticated,
                onDismiss = { showCart = false },
                onLoginRequired = {
                    showCart = false
                    navController.navigate(Screen.Login.route)
                },
                onOrderSuccess = {
                    showCart = false
                }
            )
        }

        NavHost(
            navController = navController,
            startDestination = startDestination,
            modifier = Modifier.padding(innerPadding)
        ) {

            // LOGIN
            composable(Screen.Login.route) {
                LoginScreen(
                    viewModel = authViewModel,
                    onLoginSuccess = { staff ->
                        navController.navigate(
                            if (staff) Screen.AdminDashboard.route else Screen.Home.route
                        ) {
                            popUpTo(Screen.Login.route) { inclusive = true }
                        }
                    },
                    onNavigateToRegister = {
                        navController.navigate(Screen.Register.route)
                    }
                )
            }

            // REGISTER
            composable(Screen.Register.route) {
                RegisterScreen(
                    viewModel = authViewModel,
                    onRegisterSuccess = { staff ->
                        navController.navigate(
                            if (staff) Screen.AdminDashboard.route else Screen.Home.route
                        ) {
                            popUpTo(Screen.Login.route) { inclusive = true }
                        }
                    },
                    onNavigateToLogin = { navController.popBackStack() }
                )
            }

            // HOME
            composable(Screen.Home.route) {
                HomeScreen(
                    onProductClick = { id -> navController.navigate("product/$id") },
                    onCatalogClick = { navController.navigate(Screen.Catalog.route) }
                )
            }

            // CATALOG
            composable(Screen.Catalog.route) {
                CatalogScreen(
                    onProductClick = { id -> navController.navigate("product/$id") }
                )
            }

            // PRODUCT DETAIL
            composable(
                "product/{id}",
                arguments = listOf(navArgument("id") { type = NavType.IntType })
            ) { entry ->
                val id = entry.arguments?.getInt("id") ?: return@composable

                ProductDetailScreen(
                    productId = id,
                    onBack = { navController.popBackStack() },
                    cartViewModel = cartViewModel
                )
            }

            // ORDERS CLIENT
            composable(Screen.Orders.route) {
                if (!isAuthenticated) {
                    LaunchedEffect(Unit) {
                        navController.navigate(Screen.Login.route)
                    }
                } else {
                    OrdersScreen(
                        onOrderClick = { id -> navController.navigate("orders/$id") }
                    )
                }
            }

            // ORDER DETAIL CLIENT
            composable(
                "orders/{id}",
                arguments = listOf(navArgument("id") { type = NavType.IntType })
            ) { entry ->
                val id = entry.arguments?.getInt("id") ?: return@composable

                OrderDetailScreen(
                    orderId = id,
                    onBack = { navController.popBackStack() }
                )
            }

            // PROFILE (FIX: SOLO UNA VERSION)
            composable(Screen.Profile.route) {
                if (!isAuthenticated) {
                    LaunchedEffect(Unit) {
                        navController.navigate(Screen.Login.route)
                    }
                } else {
                    ProfileScreen(
                        onLogout = {
                            authViewModel.logout()
                            navController.navigate(Screen.Login.route) {
                                popUpTo(0) { inclusive = true }
                            }
                        }
                    )
                }
            }

            // ADMIN DASHBOARD
            composable(Screen.AdminDashboard.route) {
                if (!isStaff) {
                    LaunchedEffect(Unit) {
                        navController.navigate(Screen.Home.route)
                    }
                    return@composable
                }

                AdminScaffold(
                    currentRoute = Screen.AdminDashboard.route,
                    user = currentUser,
                    title = "Dashboard",
                    onNavClick = { navController.navigate(it) },
                    onStoreClick = { navController.navigate(Screen.Home.route) },
                    onLogout = {
                        authViewModel.logout()
                        navController.navigate(Screen.Login.route) {
                            popUpTo(0) { inclusive = true }
                        }
                    }
                ) { padding ->
                    Box(Modifier.padding(padding)) {
                        DashboardScreen(onNavigate = { navController.navigate(it) })
                    }
                }
            }

            // ADMIN CATEGORIES
            composable("admin/categories") {
                AdminScaffold(
                    currentRoute = "admin/categories",
                    user = currentUser,
                    title = "Categorías",
                    onNavClick = { navController.navigate(it) },
                    onStoreClick = { navController.navigate(Screen.Home.route) },
                    onLogout = { authViewModel.logout() }
                ) { padding ->
                    Box(Modifier.padding(padding)) {
                        CategoriesAdminScreen()
                    }
                }
            }

            // ADMIN PRODUCTS
            composable("admin/products") {
                AdminScaffold(
                    currentRoute = "admin/products",
                    user = currentUser,
                    title = "Productos",
                    onNavClick = { navController.navigate(it) },
                    onStoreClick = { navController.navigate(Screen.Home.route) },
                    onLogout = { authViewModel.logout() }
                ) { padding ->
                    Box(Modifier.padding(padding)) {
                        ProductsAdminScreen()
                    }
                }
            }

            // ADMIN USERS
            composable("admin/users") {
                AdminScaffold(
                    currentRoute = "admin/users",
                    user = currentUser,
                    title = "Usuarios",
                    onNavClick = { navController.navigate(it) },
                    onStoreClick = { navController.navigate(Screen.Home.route) },
                    onLogout = { authViewModel.logout() }
                ) { padding ->
                    Box(Modifier.padding(padding)) {
                        UsersAdminScreen()
                    }
                }
            }

            // ADMIN ORDERS
            composable("admin/orders") {
                val vm: OrdersAdminViewModel = hiltViewModel()

                AdminScaffold(
                    currentRoute = "admin/orders",
                    user = currentUser,
                    title = "Pedidos",
                    onNavClick = { navController.navigate(it) },
                    onStoreClick = { navController.navigate(Screen.Home.route) },
                    onLogout = { authViewModel.logout() }
                ) { padding ->
                    Box(Modifier.padding(padding)) {
                        OrdersAdminScreen(
                            viewModel = vm,
                            onOrderDetail = { id ->
                                navController.navigate("admin/orders/$id")
                            }
                        )
                    }
                }
            }

            // ADMIN ORDER DETAIL
            composable(
                "admin/orders/{id}",
                arguments = listOf(navArgument("id") { type = NavType.IntType })
            ) { entry ->
                val id = entry.arguments?.getInt("id") ?: return@composable
                val vm: OrdersAdminViewModel = hiltViewModel()

                AdminScaffold(
                    currentRoute = "admin/orders",
                    user = currentUser,
                    title = "Pedido #$id",
                    onNavClick = { navController.navigate(it) },
                    onStoreClick = { navController.navigate(Screen.Home.route) },
                    onLogout = { authViewModel.logout() }
                ) { padding ->
                    Box(Modifier.padding(padding)) {
                        OrderAdminDetailScreen(
                            orderId = id,
                            onBack = { navController.popBackStack() },
                            onStatusChange = vm::changeStatus
                        )
                    }
                }
            }
        }
    }
}