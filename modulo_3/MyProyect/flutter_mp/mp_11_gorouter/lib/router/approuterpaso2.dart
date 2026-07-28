// lib/router/app_router_paso2.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/pantalla_inicio.dart';
import '../screens/pantalla_aeropuertos.dart';
import '../screens/pantalla_detalle.dart';
import '../models/aeropuerto.dart';

final appRouterPaso2 = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path:    '/',
      builder: (context, state) => const PantallaInicio(),
    ),
    GoRoute(
      path:    '/aeropuertos',
      builder: (context, state) => const PantallaAeropuertos(),
      routes: [
        // Ruta hija: /aeropuertos/:id
        GoRoute(
          path:    ':id',   // relativa — ruta completa: /aeropuertos/:id
          builder: (context, state) {
            final id       = state.pathParameters['id']!;
            final aeropuerto = state.extra as Aeropuerto?;
            return PantallaDetalle(id: id, aeropuerto: aeropuerto);
          },
        ),
        // Ruta hija: /aeropuertos/:id/reportes
        GoRoute(
          path:    ':id/reportes',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return Scaffold(
              appBar: AppBar(title: Text('Reportes de $id')),
              body:   Center(child: Text('Reportes del aeropuerto $id')),
            );
          },
        ),
      ],
    ),
  ],
);