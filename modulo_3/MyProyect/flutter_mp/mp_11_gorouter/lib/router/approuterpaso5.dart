// lib/router/app_router_paso5.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mp_11_gorouter/screens/pantalla_metricas_aeropuerto.dart';
import 'package:mp_11_gorouter/screens/scaffoldconnav.dart';
import '../providers/auth_provider.dart';
import '../screens/pantalla_aeropuertos.dart';
import '../screens/pantalla_detalle.dart';
import '../screens/pantalla_ajustes.dart';
import '../screens/pantalla_login.dart';
import '../models/aeropuerto.dart';

// Función que crea el router con acceso al WidgetRef (para el guard)
GoRouter appRouterPaso5(WidgetRef ref) => GoRouter(
  initialLocation: '/aeropuertos',
  debugLogDiagnostics: true,
  redirect: (context, state) {
    final authState = ref.read(authProvider);
    final autenticado = authState is Autenticado;
    final enLogin = state.matchedLocation == '/login';

    // No autenticado y no está en /login → ir al login
    if (!autenticado && !enLogin) return '/login';
    // Autenticado y está en /login → ir a la app
    if (autenticado && enLogin) return '/aeropuertos';
    // Sin redirección
    return null;
  },
  routes: [
    ShellRoute(
      builder: (context, state, child) => ScaffoldConNav(child: child),
      routes: [
        GoRoute(
          path: '/aeropuertos',
          builder: (_, __) => const PantallaAeropuertos(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) => PantallaDetalle(
                id: state.pathParameters['id']!,
                aeropuerto: state.extra as Aeropuerto?,
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/metricas',
          builder: (_, __) => const PantallaMetricasAeropuerto(),
        ),
        GoRoute(path: '/ajustes', builder: (_, __) => const PantallaAjustes()),
      ],
    ),
    GoRoute(path: '/login', builder: (_, __) => const PantallaLogin()),
  ],
);
