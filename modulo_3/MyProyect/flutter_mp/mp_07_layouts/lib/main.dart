import 'package:flutter/material.dart';

import 'widgets/avatar_badge.dart';
import 'widgets/fila_estado.dart';
import 'widgets/tarjeta_log.dart';

void main() {
  runApp(const Mp07AeropuertosApp());
}

class Mp07AeropuertosApp extends StatelessWidget {
  const Mp07AeropuertosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MP 07 - Layouts aeroportuarios',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        cardTheme: const CardThemeData(
          elevation: 0,
          margin: EdgeInsets.zero,
        ),
      ),
      home: const MenuLayoutsAeropuerto(),
    );
  }
}

class MenuLayoutsAeropuerto extends StatelessWidget {
  const MenuLayoutsAeropuerto({super.key});

  @override
  Widget build(BuildContext context) {
    final ejemplos = <_EjemploLayout>[
      const _EjemploLayout(
        titulo: 'Container',
        descripcion: 'Tarjeta de identificación de un aeropuerto.',
        icono: Icons.crop_square_rounded,
        pagina: PantallaContainerAeropuerto(),
      ),
      const _EjemploLayout(
        titulo: 'Column',
        descripcion: 'Registro vertical de eventos operacionales.',
        icono: Icons.view_agenda_outlined,
        pagina: PantallaEventosOperacionales(),
      ),
      const _EjemploLayout(
        titulo: 'Row y Expanded',
        descripcion: 'Estado de aeropuertos distribuido en filas.',
        icono: Icons.view_stream_outlined,
        pagina: PantallaEstadoAeropuertos(),
      ),
      const _EjemploLayout(
        titulo: 'Stack y Positioned',
        descripcion: 'Badges superpuestos para terminales y alertas.',
        icono: Icons.layers_outlined,
        pagina: PantallaBadgesAeropuertos(),
      ),
      const _EjemploLayout(
        titulo: 'Padding, Align y Wrap',
        descripcion: 'Distribución adaptable de servicios aeroportuarios.',
        icono: Icons.dashboard_customize_outlined,
        pagina: PantallaLaboratorioLayouts(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('MP 07 · Layouts aeroportuarios'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.local_airport),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final columnas = constraints.maxWidth >= 1050
              ? 3
              : constraints.maxWidth >= 650
                  ? 2
                  : 1;

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _CabeceraModulo(anchoDisponible: constraints.maxWidth),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columnas,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: columnas == 1 ? 2.7 : 1.55,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final ejemplo = ejemplos[index];
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => ejemplo.pagina),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    ejemplo.icono,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  ejemplo.titulo,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  ejemplo.descripcion,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: ejemplos.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CabeceraModulo extends StatelessWidget {
  final double anchoDisponible;

  const _CabeceraModulo({required this.anchoDisponible});

  @override
  Widget build(BuildContext context) {
    final esPantallaGrande = anchoDisponible >= 700;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF263C96), Color(0xFF536DFE)],
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: esPantallaGrande
            ? Row(
                children: [
                  const Icon(Icons.flight_takeoff, color: Colors.white, size: 54),
                  const SizedBox(width: 20),
                  Expanded(child: _TextoCabecera()),
                ],
              )
            : const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.flight_takeoff, color: Colors.white, size: 54),
                  SizedBox(height: 16),
                  _TextoCabecera(),
                ],
              ),
      ),
    );
  }
}


class _TextoCabecera extends StatelessWidget {
  const _TextoCabecera();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Centro de diseño operacional',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Practica Container, Row, Column, Expanded, Stack, Padding, Align y Wrap con ejemplos de gestión aeroportuaria.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
        ),
      ],
    );
  }
}

class _EjemploLayout {
  final String titulo;
  final String descripcion;
  final IconData icono;
  final Widget pagina;

  const _EjemploLayout({
    required this.titulo,
    required this.descripcion,
    required this.icono,
    required this.pagina,
  });
}

class PantallaContainerAeropuerto extends StatelessWidget {
  const PantallaContainerAeropuerto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Container · Aeropuerto')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: 420,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.indigo.shade100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 22,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade50,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.local_airport,
                        color: Colors.indigo,
                        size: 34,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mariscal Sucre',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Quito · Código UIO'),
                        ],
                      ),
                    ),
                    const Chip(label: Text('Operativo')),
                  ],
                ),
                const SizedBox(height: 22),
                const Divider(),
                const SizedBox(height: 14),
                const Wrap(
                  spacing: 24,
                  runSpacing: 16,
                  children: [
                    _DatoAeropuerto(
                      icono: Icons.flight,
                      valor: '86',
                      etiqueta: 'Vuelos hoy',
                    ),
                    _DatoAeropuerto(
                      icono: Icons.door_front_door_outlined,
                      valor: '12',
                      etiqueta: 'Puertas',
                    ),
                    _DatoAeropuerto(
                      icono: Icons.airlines,
                      valor: '18',
                      etiqueta: 'Aerolíneas',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DatoAeropuerto extends StatelessWidget {
  final IconData icono;
  final String valor;
  final String etiqueta;

  const _DatoAeropuerto({
    required this.icono,
    required this.valor,
    required this.etiqueta,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icono, color: Colors.indigo),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              valor,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(etiqueta, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ],
    );
  }
}

class PantallaEventosOperacionales extends StatelessWidget {
  const PantallaEventosOperacionales({super.key});

  @override
  Widget build(BuildContext context) {
    final ahora = DateTime.now();

    return Scaffold(
      appBar: AppBar(title: const Text('Column · Eventos operacionales')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: [
          TarjetaLog(
            nivel: 'ERROR',
            componente: 'Pista 18',
            mensaje: 'Inspección requerida por objeto detectado en pista.',
            timestamp: ahora,
          ),
          TarjetaLog(
            nivel: 'WARN',
            componente: 'Vuelo AV1632',
            mensaje: 'Salida retrasada 25 minutos por condiciones climáticas.',
            timestamp: ahora.subtract(const Duration(minutes: 4)),
          ),
          TarjetaLog(
            nivel: 'INFO',
            componente: 'Puerta A6',
            mensaje: 'Embarque completado y puerta liberada.',
            timestamp: ahora.subtract(const Duration(minutes: 9)),
          ),
          TarjetaLog(
            nivel: 'DEBUG',
            componente: 'Radar norte',
            mensaje: 'Sincronización de datos completada correctamente.',
            timestamp: ahora.subtract(const Duration(minutes: 12)),
          ),
        ],
      ),
    );
  }
}

class PantallaEstadoAeropuertos extends StatelessWidget {
  const PantallaEstadoAeropuertos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Row · Estado de aeropuertos')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: const [
          FilaEstado(
            nombre: 'Mariscal Sucre (UIO)',
            detalle: 'Quito · 86 vuelos programados',
            activo: true,
          ),
          Divider(height: 1),
          FilaEstado(
            nombre: 'José Joaquín de Olmedo (GYE)',
            detalle: 'Guayaquil · 74 vuelos programados',
            activo: true,
          ),
          Divider(height: 1),
          FilaEstado(
            nombre: 'Mariscal Lamar (CUE)',
            detalle: 'Cuenca · Operación suspendida temporalmente',
            activo: false,
          ),
          Divider(height: 1),
          FilaEstado(
            nombre: 'Eloy Alfaro (MEC)',
            detalle: 'Manta · 18 vuelos programados',
            activo: true,
          ),
        ],
      ),
    );
  }
}

class PantallaBadgesAeropuertos extends StatelessWidget {
  const PantallaBadgesAeropuertos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stack · Terminales y alertas')),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(28),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AvatarBadge(nombre: 'UIO', alertas: 2, activo: true),
              SizedBox(width: 30),
              AvatarBadge(nombre: 'GYE', alertas: 0, activo: true),
              SizedBox(width: 30),
              AvatarBadge(nombre: 'CUE', alertas: 1, activo: false),
              SizedBox(width: 30),
              AvatarBadge(nombre: 'MEC', alertas: 11, activo: true),
            ],
          ),
        ),
      ),
    );
  }
}

class PantallaLaboratorioLayouts extends StatelessWidget {
  const PantallaLaboratorioLayouts({super.key});

  @override
  Widget build(BuildContext context) {
    const servicios = [
      ('Pista activa', Icons.flight_takeoff),
      ('Seguridad operacional', Icons.health_and_safety_outlined),
      ('Control de tráfico', Icons.radar),
      ('Torre de control', Icons.cell_tower),
      ('Sala de embarque', Icons.airline_seat_recline_normal),
      ('Migración', Icons.badge_outlined),
      ('Equipaje', Icons.luggage_outlined),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Padding, Align y Wrap')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.schedule, color: Colors.indigo),
                      const SizedBox(width: 10),
                      Text(
                        'Próxima operación',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Spacer(),
                      const Chip(label: Text('A tiempo')),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Vuelo EQ 203 · Quito → Guayaquil',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  const Text('Salida 18:45 · Puerta A4 · Pista 18'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Servicios disponibles',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: servicios
                        .map(
                          (servicio) => Chip(
                            avatar: Icon(servicio.$2, size: 18),
                            label: Text(servicio.$1),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Última actualización: hace 2 minutos',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
