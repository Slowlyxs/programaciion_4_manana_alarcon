import 'package:go_router/go_router.dart';

import '../models/aeropuerto.dart';
import '../screens/pantalla_aeropuertos.dart';
import '../screens/pantalla_detalle.dart';
import '../screens/pantalla_inicio.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const PantallaInicio(),
    ),
    GoRoute(
      path: '/aeropuertos',
      builder: (_, __) => const PantallaAeropuertos(),
    ),
    GoRoute(
      path: '/aeropuertos/:id',
      builder: (_, state) => PantallaDetalle(
        id: state.pathParameters['id']!,
        aeropuerto: state.extra as Aeropuerto?,
      ),
    ),
  ],
);
