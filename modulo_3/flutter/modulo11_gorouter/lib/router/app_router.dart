// lib/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modulo11_gorouter/screens/pantalla_inicio.dart';
import 'package:modulo11_gorouter/screens/pantalla_servidores.dart';
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path:    '/',
      builder: (context, state) => const PantallaInicio(),
    ),
    GoRoute(
      path:    '/servidores',
      builder: (context, state) => const PantallaServidores(),
    ),
  ],
);
