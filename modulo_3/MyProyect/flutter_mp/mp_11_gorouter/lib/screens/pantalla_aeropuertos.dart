import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/aeropuerto.dart';

class PantallaAeropuertos extends StatelessWidget {
  const PantallaAeropuertos({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aeropuertos'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
      ),
      body: ListView.builder(
        itemCount: aeropuertosSimulados.length,
        itemBuilder: (context, i) {
          final aeropuerto = aeropuertosSimulados[i];
          return ListTile(
            leading: CircleAvatar(child: Text(aeropuerto.codigoIata)),
            title: Text(aeropuerto.nombre),
            subtitle: Text('${aeropuerto.ciudad} · ${aeropuerto.pistas} pista(s)'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(
              '/aeropuertos/${aeropuerto.id}',
              extra: aeropuerto,
            ),
          );
        },
      ),
    );
  }
}
