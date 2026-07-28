import 'package:flutter/material.dart';

import 'screens/pantalla_contexto.dart';
import 'widgets/catalogo_basicos.dart';
import 'widgets/contador_limitado.dart';
import 'widgets/etiqueta.dart';
import 'widgets/indicador.dart';
import 'widgets/reloj.dart';
import 'widgets/servicio_estado.dart';

void main() {
  runApp(const Mp06AeropuertosApp());
}

class Mp06AeropuertosApp extends StatelessWidget {
  const Mp06AeropuertosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MP 06 - Widgets aeroportuarios',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
      ),
      home: const MenuWidgetsAeropuerto(),
    );
  }
}

class MenuWidgetsAeropuerto extends StatelessWidget {
  const MenuWidgetsAeropuerto({super.key});

  @override
  Widget build(BuildContext context) {
    final opciones = <_OpcionModulo>[
      _OpcionModulo(
        titulo: 'Presentación',
        descripcion: 'Ejemplo de StatelessWidget básico.',
        icono: Icons.flight_takeoff,
        pagina: const _PaginaSaludo(),
      ),
      _OpcionModulo(
        titulo: 'Catálogo de widgets',
        descripcion: 'Textos, iconos, botones, tarjetas y chips.',
        icono: Icons.widgets_outlined,
        pagina: const CatalogoBasicos(),
      ),
      _OpcionModulo(
        titulo: 'Estados de vuelos',
        descripcion: 'Widgets reutilizables con parámetros.',
        icono: Icons.label_outline,
        pagina: const _PaginaEtiquetas(),
      ),
      _OpcionModulo(
        titulo: 'Operación aeroportuaria',
        descripcion: 'StatefulWidget y cambio dinámico de estado.',
        icono: Icons.power_settings_new,
        pagina: const _PaginaServicioEstado(),
      ),
      _OpcionModulo(
        titulo: 'Control de capacidad',
        descripcion: 'Contadores limitados para puertas y vuelos.',
        icono: Icons.bar_chart,
        pagina: const _PaginaContadores(),
      ),
      _OpcionModulo(
        titulo: 'Cronómetro de pista',
        descripcion: 'Ciclo de vida y Timer en Flutter.',
        icono: Icons.timer_outlined,
        pagina: const _PaginaReloj(),
      ),
      _OpcionModulo(
        titulo: 'Contexto de pantalla',
        descripcion: 'Theme, MediaQuery y BuildContext.',
        icono: Icons.devices,
        pagina: const PantallaContexto(),
      ),
      _OpcionModulo(
        titulo: 'Panel de indicadores',
        descripcion: 'Composición de widgets aeroportuarios.',
        icono: Icons.dashboard_outlined,
        pagina: const _PaginaIndicadores(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('MP 06 · Gestión de aeropuertos'),
        centerTitle: false,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final columnas = constraints.maxWidth >= 1100
              ? 4
              : constraints.maxWidth >= 700
                  ? 2
                  : 1;

          return GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columnas,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: columnas == 1 ? 2.8 : 1.55,
            ),
            itemCount: opciones.length,
            itemBuilder: (context, index) {
              final opcion = opciones[index];
              return Card(
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => opcion.pagina),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          opcion.icono,
                          size: 34,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          opcion.titulo,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          opcion.descripcion,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _OpcionModulo {
  final String titulo;
  final String descripcion;
  final IconData icono;
  final Widget pagina;

  const _OpcionModulo({
    required this.titulo,
    required this.descripcion,
    required this.icono,
    required this.pagina,
  });
}

class _PaginaSaludo extends StatelessWidget {
  const _PaginaSaludo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('StatelessWidget básico')),
      body: const Center(child: Saludo()),
    );
  }
}

class Saludo extends StatelessWidget {
  const Saludo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.local_airport, size: 76, color: Colors.indigo),
          SizedBox(height: 16),
          Text(
            'CENTRO DE OPERACIONES\nAEROPORTUARIAS',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: Colors.indigo,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'Monitoreo de vuelos, pistas y terminales',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _PaginaEtiquetas extends StatelessWidget {
  const _PaginaEtiquetas();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estados de vuelos')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              Etiqueta(
                texto: 'A tiempo',
                color: Colors.green,
                icono: Icons.check_circle_outline,
              ),
              Etiqueta(
                texto: 'Retrasado',
                color: Colors.orange,
                relleno: true,
                icono: Icons.schedule,
              ),
              Etiqueta(
                texto: 'Cancelado',
                color: Colors.red,
                relleno: true,
                icono: Icons.cancel_outlined,
              ),
              Etiqueta(
                texto: 'Embarcando',
                color: Colors.blue,
                icono: Icons.airline_seat_recline_normal,
              ),
              Etiqueta(
                texto: 'En vuelo',
                color: Colors.indigo,
                fontSize: 15,
                icono: Icons.flight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaginaServicioEstado extends StatelessWidget {
  const _PaginaServicioEstado();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Operación aeroportuaria')),
      body: const Center(
        child: ServicioEstado(nombre: 'Aeropuerto Internacional de Quito'),
      ),
    );
  }
}

class _PaginaContadores extends StatelessWidget {
  const _PaginaContadores();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Control de capacidad')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Wrap(
            spacing: 48,
            runSpacing: 36,
            alignment: WrapAlignment.center,
            children: [
              SizedBox(
                width: 260,
                child: ContadorLimitado(
                  etiqueta: 'Puertas de embarque ocupadas',
                  limite: 6,
                  color: Colors.indigo,
                  onLimite: () => debugPrint('Todas las puertas están ocupadas'),
                ),
              ),
              SizedBox(
                width: 260,
                child: ContadorLimitado(
                  etiqueta: 'Vuelos con demora',
                  limite: 3,
                  color: Colors.orange,
                  onLimite: () => debugPrint('Nivel crítico de demoras'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaginaReloj extends StatelessWidget {
  const _PaginaReloj();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cronómetro de operación en pista')),
      body: const Center(child: Reloj()),
    );
  }
}

class _PaginaIndicadores extends StatelessWidget {
  const _PaginaIndicadores();

  @override
  Widget build(BuildContext context) {
    const indicadores = [
      Indicador(
        label: 'Aeropuertos activos',
        valor: '8',
        color: Colors.green,
        icono: Icons.local_airport,
        subtitulo: 'Red nacional',
      ),
      Indicador(
        label: 'Alertas críticas',
        valor: '2',
        color: Colors.red,
        icono: Icons.warning_amber,
        subtitulo: 'Requieren atención',
      ),
      Indicador(
        label: 'Vuelos programados',
        valor: '142',
        color: Colors.indigo,
        icono: Icons.flight,
        subtitulo: 'Durante el día',
      ),
      Indicador(
        label: 'Operatividad',
        valor: '99.8%',
        color: Colors.teal,
        icono: Icons.monitor_heart_outlined,
        subtitulo: 'Últimos 30 días',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Panel de indicadores')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final columnas = constraints.maxWidth >= 900
              ? 4
              : constraints.maxWidth >= 520
                  ? 2
                  : 1;

          return GridView.builder(
            padding: const EdgeInsets.all(24),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columnas,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: columnas == 1 ? 2.7 : 1.7,
            ),
            itemCount: indicadores.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(child: indicadores[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
