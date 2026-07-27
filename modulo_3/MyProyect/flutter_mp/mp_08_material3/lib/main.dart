import 'package:flutter/material.dart';

import 'screens/pantalla_appbar.dart';
import 'screens/pantalla_dialogs.dart';
import 'screens/pantalla_navegacion.dart';
import 'screens/pantalla_tema.dart';
import 'widgets/catalogo_botones.dart';

void main() => runApp(const AppAeropuertos());

class AppAeropuertos extends StatefulWidget {
  const AppAeropuertos({super.key});

  @override
  State<AppAeropuertos> createState() => _AppAeropuertosState();
}

class _AppAeropuertosState extends State<AppAeropuertos> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MP 08 - Material 3 aeroportuario',
      themeMode: _themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: PantallaUnicaMaterial3(
        themeMode: _themeMode,
        onThemeChanged: (mode) => setState(() => _themeMode = mode),
      ),
    );
  }
}

class PantallaUnicaMaterial3 extends StatelessWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;

  const PantallaUnicaMaterial3({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MP 08 · Material 3 aeroportuario')),
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
                  titulo: '1. ThemeData y Scaffold básico',
                  descripcion: 'AppBar, botones, colores del tema y acción flotante.',
                  child: _ResumenMaterial3(),
                ),
                _Seccion(
                  titulo: '2. ThemeMode dinámico',
                  descripcion: 'Selector de tema claro, oscuro o según el sistema.',
                  child: SizedBox(
                    height: 520,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: PantallaTema(
                        themeMode: themeMode,
                        onToggle: onThemeChanged,
                      ),
                    ),
                  ),
                ),
                const _Seccion(
                  titulo: '3. AppBar y SliverAppBar',
                  descripcion: 'Listado aeroportuario con encabezado flexible y desplazable.',
                  child: SizedBox(
                    height: 620,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      child: PantallaAppBar(),
                    ),
                  ),
                ),
                const _Seccion(
                  titulo: '4. Catálogo de botones Material 3',
                  descripcion: 'Filled, tonal, elevated, outlined, text e icon buttons.',
                  child: SizedBox(
                    height: 920,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      child: CatalogoBotones(),
                    ),
                  ),
                ),
                const _Seccion(
                  titulo: '5. NavigationBar',
                  descripcion: 'Dashboard, aeropuertos, alertas y ajustes en un ejemplo interactivo.',
                  child: SizedBox(
                    height: 590,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      child: PantallaNavegacion(),
                    ),
                  ),
                ),
                const _Seccion(
                  titulo: '6. SnackBar y AlertDialog',
                  descripcion: 'Mensajes de éxito, error, confirmación y formulario modal.',
                  child: SizedBox(
                    height: 470,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      child: PantallaDialogs(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResumenMaterial3 extends StatelessWidget {
  const _ResumenMaterial3();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cs.tertiaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 24,
        runSpacing: 20,
        children: [
          SizedBox(
            width: 620,
            child: Row(
              children: [
                Icon(Icons.flight, size: 72, color: cs.primary),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Aeropuerto Internacional Mariscal Sucre',
                        style: text.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text('UIO · Quito · Internacional', style: text.bodyLarge),
                    ],
                  ),
                ),
              ],
            ),
          ),
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.flight_takeoff),
            label: const Text('Ver operaciones'),
          ),
        ],
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
          Icon(Icons.palette_outlined, size: 48),
          SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Material 3 en una sola pantalla', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Tema, AppBar, botones, navegación, SnackBar y diálogos aplicados a gestión de aeropuertos.'),
              ],
            ),
          ),
        ],
      ),
    );
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
