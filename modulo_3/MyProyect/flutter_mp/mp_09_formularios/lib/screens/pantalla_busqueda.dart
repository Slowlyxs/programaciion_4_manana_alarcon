import 'package:flutter/material.dart';

import '../models/aeropuerto.dart';
import '../widgets/fila_aeropuerto.dart';
import '../widgets/tarjeta_aeropuerto_grid.dart';

class PantallaBusqueda extends StatefulWidget {
  const PantallaBusqueda({super.key});

  @override
  State<PantallaBusqueda> createState() => _PantallaBusquedaState();
}

class _PantallaBusquedaState extends State<PantallaBusqueda> {
  final _aeropuertos = [
    Aeropuerto(id: '1', nombre: 'Mariscal Sucre', ciudad: 'Quito', pistas: 2, operador: 'Quiport', categoria: 'Internacional', internacional: true, estado: 'Operativo', favorito: true),
    Aeropuerto(id: '2', nombre: 'José Joaquín de Olmedo', ciudad: 'Guayaquil', pistas: 2, operador: 'TAGSA', categoria: 'Internacional', internacional: true, estado: 'Operativo'),
    Aeropuerto(id: '3', nombre: 'Mariscal Lamar', ciudad: 'Cuenca', pistas: 1, operador: 'CORPAC', categoria: 'Nacional', internacional: false, estado: 'Mantenimiento'),
    Aeropuerto(id: '4', nombre: 'Eloy Alfaro', ciudad: 'Manta', pistas: 1, operador: 'DGAC', categoria: 'Nacional', internacional: false, estado: 'Operativo'),
  ];

  String _busqueda = '';
  bool _modoGrid = false;

  List<Aeropuerto> get _filtrados {
    final q = _busqueda.trim().toLowerCase();
    if (q.isEmpty) return _aeropuertos;
    return _aeropuertos.where((a) {
      return a.nombre.toLowerCase().contains(q) ||
          a.ciudad.toLowerCase().contains(q) ||
          a.operador.toLowerCase().contains(q);
    }).toList();
  }

  void _toggleFavorito(Aeropuerto aeropuerto) {
    setState(() => aeropuerto.favorito = !aeropuerto.favorito);
  }

  void _eliminar(Aeropuerto aeropuerto) {
    setState(() => _aeropuertos.removeWhere((a) => a.id == aeropuerto.id));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final filtrados = _filtrados;

    return Scaffold(
      appBar: AppBar(
        title: Text('Búsqueda (${filtrados.length})'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
        actions: [
          IconButton(
            icon: Icon(_modoGrid ? Icons.list : Icons.grid_view),
            onPressed: () => setState(() => _modoGrid = !_modoGrid),
            tooltip: _modoGrid ? 'Vista lista' : 'Vista cuadrícula',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: SearchBar(
              hintText: 'Buscar por nombre, ciudad u operador...',
              leading: const Icon(Icons.search),
              trailing: _busqueda.isNotEmpty
                  ? [
                      IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => setState(() => _busqueda = ''),
                      ),
                    ]
                  : null,
              onChanged: (v) => setState(() => _busqueda = v),
              padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          Expanded(
            child: filtrados.isEmpty
                ? const Center(child: Text('No se encontraron aeropuertos'))
                : _modoGrid
                    ? GridView.builder(
                        padding: const EdgeInsets.all(12),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.25,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: filtrados.length,
                        itemBuilder: (context, i) => TarjetaAeropuertoGrid(
                          aeropuerto: filtrados[i],
                          onFavorito: () => _toggleFavorito(filtrados[i]),
                          onEliminar: () => _eliminar(filtrados[i]),
                        ),
                      )
                    : ListView.separated(
                        itemCount: filtrados.length,
                        separatorBuilder: (_, __) => const Divider(height: 1, indent: 72),
                        itemBuilder: (context, i) => FilaAeropuerto(
                          aeropuerto: filtrados[i],
                          onFavorito: () => _toggleFavorito(filtrados[i]),
                          onEliminar: () => _eliminar(filtrados[i]),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
