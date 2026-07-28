import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'models/aeropuerto.dart';
import 'screens/pantalla_aeropuertos.dart';
import 'screens/pantalla_aeropuertos_filtro.dart';
import 'screens/pantalla_ajustes.dart';
import 'screens/pantalla_detalle.dart';
import 'screens/pantalla_inicio.dart';
import 'screens/pantalla_login.dart';
import 'screens/pantalla_metricas_aeropuerto.dart';
import 'screens/scaffoldconnav.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, __) => const PantallaUnicaGoRouter()),
    GoRoute(path: '/inicio', builder: (_, __) => const PantallaInicio()),
    GoRoute(
      path: '/aeropuertos',
      builder: (_, state) {
        final soloInternacionales =
            state.uri.queryParameters['internacionales'] == 'true';
        return soloInternacionales
            ? const PantallaAeropuertosFiltro(soloInternacionales: true)
            : const PantallaAeropuertos();
      },
    ),
    GoRoute(
      path: '/aeropuertos-filtro',
      builder: (_, state) => PantallaAeropuertosFiltro(
        soloInternacionales:
            state.uri.queryParameters['internacionales'] == 'true',
      ),
    ),
    GoRoute(
      path: '/aeropuertos/:id',
      builder: (_, state) => PantallaDetalle(
        id: state.pathParameters['id']!,
        aeropuerto: state.extra as Aeropuerto?,
      ),
    ),
    GoRoute(
      path: '/aeropuertos/:id/reportes',
      builder: (_, state) => Scaffold(
        appBar: AppBar(title: Text('Reportes · ${state.pathParameters['id']}')),
        body: const Center(child: Text('Reportes operacionales del aeropuerto')),
      ),
    ),
    GoRoute(path: '/metricas', builder: (_, __) => const PantallaMetricasAeropuerto()),
    GoRoute(path: '/ajustes', builder: (_, __) => const PantallaAjustes()),
    GoRoute(path: '/login', builder: (_, __) => const PantallaLogin()),
  ],
);

void main() => runApp(const ProviderScope(child: AppAeropuertos()));

class AppAeropuertos extends StatelessWidget {
  const AppAeropuertos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MP 11 - GoRouter aeroportuario',
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D47A1)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
      ),
    );
  }
}

class PantallaUnicaGoRouter extends StatelessWidget {
  const PantallaUnicaGoRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MP 11 · GoRouter aeroportuario')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1180),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _Cabecera(),
                const SizedBox(height: 18),
                const _Seccion(
                  titulo: 'Archivos de configuración del router',
                  descripcion: 'Los cinco pasos permanecen en la carpeta router y aquí se resumen juntos.',
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _ConceptoRuta(icono: Icons.route, texto: 'app_router.dart · rutas básicas'),
                      _ConceptoRuta(icono: Icons.tag, texto: 'approuterpaso2.dart · pathParameters'),
                      _ConceptoRuta(icono: Icons.filter_alt, texto: 'approuterpaso3.dart · queryParameters'),
                      _ConceptoRuta(icono: Icons.view_quilt, texto: 'approuterpaso4.dart · ShellRoute'),
                      _ConceptoRuta(icono: Icons.lock, texto: 'approuterpaso5.dart · guard y login'),
                    ],
                  ),
                ),
                const _Seccion(
                  titulo: '1. Rutas básicas: context.go',
                  descripcion: 'Pantalla de inicio con navegación hacia el listado de aeropuertos.',
                  child: SizedBox(
                    height: 390,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      child: PantallaInicio(),
                    ),
                  ),
                ),
                const _Seccion(
                  titulo: '2. Lista y pathParameters',
                  descripcion: 'Cada aeropuerto navega a /aeropuertos/:id y envía el objeto con extra.',
                  child: SizedBox(
                    height: 440,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      child: PantallaAeropuertos(),
                    ),
                  ),
                ),
                _Seccion(
                  titulo: 'Detalle recibido por ruta',
                  descripcion: 'Vista del aeropuerto seleccionado usando el parámetro id.',
                  child: SizedBox(
                    height: 460,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: PantallaDetalle(
                        id: '1',
                        aeropuerto: aeropuertosSimulados.first,
                      ),
                    ),
                  ),
                ),
                const _Seccion(
                  titulo: '3. queryParameters',
                  descripcion: 'Filtro de aeropuertos internacionales mediante ?internacionales=true.',
                  child: SizedBox(
                    height: 440,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      child: PantallaAeropuertosFiltro(soloInternacionales: true),
                    ),
                  ),
                ),
                const _Seccion(
                  titulo: '4. ShellRoute y NavigationBar persistente',
                  descripcion: 'El scaffold conserva la navegación inferior mientras cambia el contenido.',
                  child: SizedBox(
                    height: 360,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      child: ScaffoldConNav(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.local_airport, size: 56),
                              SizedBox(height: 8),
                              Text('Contenido administrado por ShellRoute'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                _Seccion(
                  titulo: 'Pantallas del Shell',
                  descripcion: 'Métricas y ajustes se muestran juntas para revisar todos los archivos del módulo.',
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final vertical = constraints.maxWidth < 720;
                      const metricas = SizedBox(
                        height: 300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(18)),
                          child: PantallaMetricasAeropuerto(),
                        ),
                      );
                      const ajustes = SizedBox(
                        height: 300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(18)),
                          child: PantallaAjustes(),
                        ),
                      );
                      return vertical
                          ? const Column(
                              children: [metricas, SizedBox(height: 12), ajustes],
                            )
                          : const Row(
                              children: [
                                Expanded(child: metricas),
                                SizedBox(width: 12),
                                Expanded(child: ajustes),
                              ],
                            );
                    },
                  ),
                ),
                const _Seccion(
                  titulo: '5. Guard de autenticación con Riverpod',
                  descripcion: 'Formulario de login usado por el redirect del router. Credenciales: admin / admin123.',
                  child: SizedBox(
                    height: 610,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      child: PantallaLogin(),
                    ),
                  ),
                ),
                Wrap(
                  spacing: 12,
                  runSpacing: 10,
                  children: [
                    FilledButton.icon(
                      onPressed: () => context.go('/inicio'),
                      icon: const Icon(Icons.open_in_new),
                      label: const Text('Abrir ejemplo a pantalla completa'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => context.go('/login'),
                      icon: const Icon(Icons.login),
                      label: const Text('Probar ruta /login'),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Cabecera extends StatelessWidget {
  const _Cabecera();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Row(
        children: [
          Icon(Icons.alt_route, size: 48),
          SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('GoRouter en una sola pantalla', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Rutas básicas, parámetros, filtros, ShellRoute y autenticación aplicados a gestión aeroportuaria.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ConceptoRuta extends StatelessWidget {
  final IconData icono;
  final String texto;

  const _ConceptoRuta({required this.icono, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Chip(avatar: Icon(icono, size: 18), label: Text(texto));
  }
}

class _Seccion extends StatelessWidget {
  final String titulo;
  final String descripcion;
  final Widget child;

  const _Seccion({required this.titulo, required this.descripcion, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(titulo, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(descripcion, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
            const Divider(height: 28),
            child,
          ],
        ),
      ),
    );
  }
}
