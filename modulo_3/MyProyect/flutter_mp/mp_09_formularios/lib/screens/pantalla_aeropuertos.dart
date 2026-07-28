import 'package:flutter/material.dart';

import '../models/aeropuerto.dart';
import '../widgets/fila_aeropuerto.dart';
import '../widgets/tarjeta_aeropuerto_grid.dart';

class PantallaAeropuertos extends StatefulWidget {
  const PantallaAeropuertos({super.key});

  @override
  State<PantallaAeropuertos> createState() => _PantallaAeropuertosState();
}

class _PantallaAeropuertosState extends State<PantallaAeropuertos> {
  final _aeropuertos = [
    Aeropuerto(
      id: '1',
      nombre: 'Mariscal Sucre',
      ciudad: 'Quito',
      pistas: 2,
      operador: 'Quiport',
      categoria: 'Internacional',
      internacional: true,
      estado: 'Operativo',
      favorito: true,
    ),
    Aeropuerto(
      id: '2',
      nombre: 'José Joaquín de Olmedo',
      ciudad: 'Guayaquil',
      pistas: 2,
      operador: 'TAGSA',
      categoria: 'Internacional',
      internacional: true,
      estado: 'Operativo',
    ),
    Aeropuerto(
      id: '3',
      nombre: 'Mariscal Lamar',
      ciudad: 'Cuenca',
      pistas: 1,
      operador: 'CORPAC',
      categoria: 'Nacional',
      internacional: false,
      estado: 'Mantenimiento',
    ),
    Aeropuerto(
      id: '4',
      nombre: 'Eloy Alfaro',
      ciudad: 'Manta',
      pistas: 1,
      operador: 'DGAC',
      categoria: 'Nacional',
      internacional: false,
      estado: 'Operativo',
    ),
  ];

  bool _modoGrid = false;

  void _toggleFavorito(int i) {
    setState(() => _aeropuertos[i].favorito = !_aeropuertos[i].favorito);
  }

  void _eliminar(int i) {
    setState(() => _aeropuertos.removeAt(i));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Aeropuertos (${_aeropuertos.length})'),
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
      body: _modoGrid
          ? GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.25,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _aeropuertos.length,
              itemBuilder: (context, i) => TarjetaAeropuertoGrid(
                aeropuerto: _aeropuertos[i],
                onFavorito: () => _toggleFavorito(i),
                onEliminar: () => _eliminar(i),
              ),
            )
          : ListView.separated(
              itemCount: _aeropuertos.length,
              separatorBuilder: (_, __) => const Divider(height: 1, indent: 72),
              itemBuilder: (context, i) => FilaAeropuerto(
                aeropuerto: _aeropuertos[i],
                onFavorito: () => _toggleFavorito(i),
                onEliminar: () => _eliminar(i),
              ),
            ),
    );
  }
}
