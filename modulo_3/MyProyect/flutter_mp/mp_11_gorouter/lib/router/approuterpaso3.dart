// lib/router/app_router_paso3.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mp_11_gorouter/screens/pantalla_aeropuertos_filtro.dart';
import '../screens/pantalla_inicio.dart';

import '../screens/pantalla_detalle.dart';
import '../models/aeropuerto.dart';

final appRouterPaso3 = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const PantallaInicio()),
    GoRoute(
      path: '/aeropuertos',
      builder: (context, state) {
        // Query parameters — /aeropuertos?internacionales=true
        final soloInternacionales = state.uri.queryParameters['internacionales'] == 'true';
        return PantallaAeropuertosFiltro(soloInternacionales: soloInternacionales);
      },
    ),
    GoRoute(
      path: '/aeropuertos/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final aeropuerto = state.extra as Aeropuerto?;
        return PantallaDetalle(id: id, aeropuerto: aeropuerto);
      },
    ),
  ],
);
