// lib/presentation/navigation/app_router.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shop_app/presentation/screens/cart/cart_screen.dart';
import 'package:flutter_shop_app/presentation/screens/catalog/productdetailscreen.dart';
import 'package:flutter_shop_app/presentation/screens/orders/orderdetailscreen.dart';
import 'package:go_router/go_router.dart';
import '../../domain/model/auth_state.dart';
import '../providers/auth_provider.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/catalog/catalog_screen.dart';
import '../screens/catalog/home_screen.dart';
import 'public_shell.dart';

// Nuevos imports agregados
import '../screens/orders/orders_screen.dart';
import '../screens/auth/profile_screen.dart';

class _PlaceholderScreen extends ConsumerWidget {
  final String title;
  const _PlaceholderScreen(this.title);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authProvider.notifier).logout();
              context.go('/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Text(title,
            style: const TextStyle(color: Color(0xFF8888AA), fontSize: 16)),
      ),
    );
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    refreshListenable: _AuthStateListenable(ref),
    redirect: (context, state) {
      final auth = ref.read(authProvider);
      final location = state.matchedLocation;

      if (auth.isChecking) return null;

      final isAuthRoute = location == '/login' || location == '/register';

      if (!auth.isAuthenticated && !isAuthRoute) return '/login';
      if (auth.isAuthenticated && isAuthRoute) {
        return auth.isStaff ? '/admin' : '/';
      }
      if (auth.isAuthenticated &&
          !auth.isStaff &&
          location.startsWith('/admin')) return '/';

      return null;
    },
    routes: [
      // ── Auth ──────────────────────────────────────────────
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),

      // ── Zona pública con BottomNavBar ──────────────────────
      ShellRoute(
        builder: (_, __, child) => PublicShell(child: child),
        routes: [
          GoRoute(path: '/', builder: (_, __) => const HomeScreen()),

          // Catálogo y sub-ruta de detalle de producto
          GoRoute(
            path: '/catalog',
            builder: (_, __) => const CatalogScreen(),
            routes: [
              GoRoute(
                path: ':id', // /catalog/1 → id=1
                builder: (_, state) {
                  final id = int.parse(state.pathParameters['id']!);
                  return ProductDetailScreen(productId: id);
                },
              ),
            ],
          ),

          // Carrito de compras real
          GoRoute(
            path: '/cart',
            builder: (_, __) => const CartScreen(),
          ),

          // Manteniendo el placeholder alternativo de detalle de producto por si se usa en otra sección
          GoRoute(
            path: '/product/:id',
            builder: (_, s) =>
                _PlaceholderScreen('Detalle #${s.pathParameters['id']} — M5'),
          ),

          // Pantallas reales agregadas de Órdenes y Perfil
          GoRoute(
            path: '/orders',
            builder: (_, __) => const OrdersScreen(),
          ),
          GoRoute(
            path: '/orders/:id',
            builder: (_, s) => OrderDetailScreen(
              orderId: int.parse(s.pathParameters['id']!),
            ),
          ),
          GoRoute(
            path: '/profile',
            builder: (_, __) => const ProfileScreen(),
          ),
        ],
      ),

      // ── Admin ─────────────────────────────────────────────
      GoRoute(
          path: '/admin',
          builder: (_, __) => const _PlaceholderScreen('Dashboard — M8')),
      GoRoute(
          path: '/admin/categories',
          builder: (_, __) => const _PlaceholderScreen('Categorías — M9')),
      GoRoute(
          path: '/admin/products',
          builder: (_, __) => const _PlaceholderScreen('Productos — M10')),
      GoRoute(
          path: '/admin/orders',
          builder: (_, __) => const _PlaceholderScreen('Pedidos admin — M11')),
      GoRoute(
          path: '/admin/orders/:id',
          builder: (_, s) => _PlaceholderScreen(
              'Pedido admin #${s.pathParameters['id']} — M11')),
      GoRoute(
          path: '/admin/users',
          builder: (_, __) => const _PlaceholderScreen('Usuarios — M12')),
    ],
  );
});

class _AuthStateListenable extends ChangeNotifier {
  _AuthStateListenable(Ref ref) {
    ref.listen<AuthState>(authProvider, (_, __) => notifyListeners());
  }
}
