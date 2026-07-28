// lib/screens/pantalla_aeropuertos.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mp_10_riverpod/models/aeropuerto.dart';
import 'package:mp_10_riverpod/providers/aeropuertos_provider.dart';


class PantallaAeropuertos extends ConsumerWidget {
  const PantallaAeropuertos({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aeropuertos = ref.watch(aeropuertosProvider);
    final cs         = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title:           Text('Aeropuertos (${aeropuertos.length})'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
      ),
      body: aeropuertos.isEmpty
          ? const Center(child: Text('Sin aeropuertos'))
          : ListView.separated(
              itemCount:        aeropuertos.length,
              separatorBuilder: (_, __) =>
                  const Divider(height: 1, indent: 72),
              itemBuilder: (context, i) {
                final s = aeropuertos[i];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: s.internacional
                        ? Colors.green.shade50
                        : Colors.grey.shade100,
                    child: Icon(Icons.local_airport,
                        color: s.internacional ? Colors.green : Colors.grey),
                  ),
                  title:    Text(s.nombre,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text('${s.ciudad} · ${s.pistas} pista(s)'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          s.favorito ? Icons.star : Icons.star_border,
                          color: s.favorito ? Colors.amber : null,
                        ),
                        onPressed: () => ref
                            .read(aeropuertosProvider.notifier)
                            .toggleFavorito(s.id),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline,
                            color: Colors.red),
                        onPressed: () => ref
                            .read(aeropuertosProvider.notifier)
                            .eliminar(s.id),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          final id = DateTime.now().millisecondsSinceEpoch.toString();
          ref.read(aeropuertosProvider.notifier).agregar(
            Aeropuerto(
              id:     id,
              nombre: 'Nuevo aeropuerto ${aeropuertos.length + 1}',
              ciudad: 'Loja',
              pistas: 1,
              internacional:    true,
            ),
          );
        },
        
        child: const Icon(Icons.add),
      ),
    );
    
  }
  
}