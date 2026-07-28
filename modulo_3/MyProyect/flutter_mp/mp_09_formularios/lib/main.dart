import 'package:flutter/material.dart';

import 'screens/pantalla_aeropuertos.dart';
import 'screens/pantalla_busqueda.dart';
import 'widgets/formulario_aeropuerto.dart';

void main() => runApp(const Mp09AeropuertosApp());

class Mp09AeropuertosApp extends StatelessWidget {
  const Mp09AeropuertosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MP 09 - Formularios aeroportuarios',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B5E20)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F8F6),
      ),
      home: const PantallaUnicaFormularios(),
    );
  }
}

class PantallaUnicaFormularios extends StatefulWidget {
  const PantallaUnicaFormularios({super.key});

  @override
  State<PantallaUnicaFormularios> createState() => _PantallaUnicaFormulariosState();
}

class _PantallaUnicaFormulariosState extends State<PantallaUnicaFormularios> {
  final _ctrlIata = TextEditingController();
  final _ctrlCiudad = TextEditingController();
  final _ctrlPistas = TextEditingController(text: '2');
  final _focusCiudad = FocusNode();
  final _focusPistas = FocusNode();

  @override
  void dispose() {
    _ctrlIata.dispose();
    _ctrlCiudad.dispose();
    _ctrlPistas.dispose();
    _focusCiudad.dispose();
    _focusPistas.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MP 09 · Formularios aeroportuarios')),
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
                _Seccion(
                  titulo: '1. TextField, controller y FocusNode',
                  descripcion: 'Captura rápida y movimiento del foco entre campos.',
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final vertical = constraints.maxWidth < 760;
                      final campos = [
                        TextField(
                          controller: _ctrlIata,
                          textCapitalization: TextCapitalization.characters,
                          maxLength: 3,
                          decoration: const InputDecoration(
                            labelText: 'Código IATA',
                            hintText: 'UIO',
                            prefixIcon: Icon(Icons.badge_outlined),
                            border: OutlineInputBorder(),
                            counterText: '',
                          ),
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) => _focusCiudad.requestFocus(),
                        ),
                        TextField(
                          controller: _ctrlCiudad,
                          focusNode: _focusCiudad,
                          decoration: const InputDecoration(
                            labelText: 'Ciudad',
                            hintText: 'Quito',
                            prefixIcon: Icon(Icons.location_city_outlined),
                            border: OutlineInputBorder(),
                          ),
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) => _focusPistas.requestFocus(),
                        ),
                        TextField(
                          controller: _ctrlPistas,
                          focusNode: _focusPistas,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Número de pistas',
                            prefixIcon: Icon(Icons.route_outlined),
                            border: OutlineInputBorder(),
                          ),
                          textInputAction: TextInputAction.done,
                        ),
                      ];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (vertical)
                            ...[
                              campos[0],
                              const SizedBox(height: 12),
                              campos[1],
                              const SizedBox(height: 12),
                              campos[2],
                            ]
                          else
                            Row(
                              children: [
                                Expanded(child: campos[0]),
                                const SizedBox(width: 12),
                                Expanded(child: campos[1]),
                                const SizedBox(width: 12),
                                Expanded(child: campos[2]),
                              ],
                            ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 12,
                            runSpacing: 8,
                            children: [
                              FilledButton.icon(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  final iata = _ctrlIata.text.trim().toUpperCase();
                                  final ciudad = _ctrlCiudad.text.trim();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        iata.length == 3 && ciudad.isNotEmpty
                                            ? 'Consulta preparada: $iata · $ciudad · ${_ctrlPistas.text} pista(s)'
                                            : 'Completa el código IATA y la ciudad',
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.search),
                                label: const Text('Consultar'),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  _ctrlIata.clear();
                                  _ctrlCiudad.clear();
                                  _ctrlPistas.text = '2';
                                },
                                child: const Text('Limpiar campos'),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                _Seccion(
                  titulo: '2. Form, TextFormField y validación',
                  descripcion: 'Formulario completo para registrar un aeropuerto.',
                  child: FormularioAeropuerto(
                    onGuardar: (datos) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Aeropuerto guardado: ${datos['codigoIata']} · ${datos['nombre']} · ${datos['ciudad']}',
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ),
                const _Seccion(
                  titulo: '3 y 4. Modelo, ListView y GridView',
                  descripcion: 'Listado editable con favoritos, eliminación y cambio entre lista y cuadrícula.',
                  child: SizedBox(
                    height: 610,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      child: PantallaAeropuertos(),
                    ),
                  ),
                ),
                const _Seccion(
                  titulo: '5. SearchBar y filtrado en tiempo real',
                  descripcion: 'Búsqueda por nombre, ciudad u operador aeroportuario.',
                  child: SizedBox(
                    height: 650,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      child: PantallaBusqueda(),
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
          Icon(Icons.edit_note_outlined, size: 48),
          SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Formularios en una sola pantalla', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Controllers, foco, validaciones, modelos, listas, cuadrículas y búsqueda aplicados a aeropuertos.'),
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
