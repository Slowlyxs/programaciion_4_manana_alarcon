// lib/screens/pantalla_aeropuertos_filtro.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/aeropuerto.dart';

class PantallaAeropuertosFiltro extends StatelessWidget {
  final bool soloInternacionales;
  const PantallaAeropuertosFiltro({super.key, this.soloInternacionales = false});

  @override
  Widget build(BuildContext context) {
    final filtrados = soloInternacionales
        ? aeropuertosSimulados.where((s) => s.internacional).toList()
        : aeropuertosSimulados;

    return Scaffold(
      appBar: AppBar(
        title: Text('Aeropuertos${soloInternacionales ? ' (internacionales)' : ''}'),
        actions: [
          // Toggle de aeropuertos internacionales — cambia la URL con query param
          IconButton(
            icon: Icon(soloInternacionales ? Icons.lock : Icons.lock_open),
            tooltip: soloInternacionales ? 'Ver todos' : 'Solo internacionales',
            onPressed: () => soloInternacionales
                ? context.go('/aeropuertos')
                : context.go('/aeropuertos?internacionales=true'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filtrados.length,
        itemBuilder: (context, i) {
          final s = filtrados[i];
          return ListTile(
            leading: Icon(Icons.local_airport, color: s.internacional ? Colors.green : Colors.grey),
            title: Text(s.nombre),
            subtitle: Text(s.ciudad),
            onTap: () => context.push(
              '/aeropuertos/${s.id}',
              extra: s, // pasa el objeto completo
            ),
          );
        },
      ),
    );
  }
}
