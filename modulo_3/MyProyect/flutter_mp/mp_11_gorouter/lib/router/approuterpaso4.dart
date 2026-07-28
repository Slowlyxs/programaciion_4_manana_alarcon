// lib/router/app_router_paso4.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mp_11_gorouter/screens/pantalla_metricas_aeropuerto.dart';
import 'package:mp_11_gorouter/screens/scaffoldconnav.dart';
import '../screens/pantalla_aeropuertos.dart';
import '../screens/pantalla_detalle.dart';
import '../screens/pantalla_ajustes.dart';
import '../models/aeropuerto.dart';

final appRouterPaso4 = GoRouter(
  initialLocation: '/aeropuertos',
  debugLogDiagnostics: true,
  routes: [
    // ShellRoute — mantiene ScaffoldConNav vivo entre rutas hijas
    ShellRoute(
      builder: (context, state, child) => ScaffoldConNav(child: child),
      routes: [
        GoRoute(
          path: '/aeropuertos',
          builder: (_, __) => const PantallaAeropuertos(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                final aeropuerto = state.extra as Aeropuerto?;
                return PantallaDetalle(id: id, aeropuerto: aeropuerto);
              },
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
  ],
);
