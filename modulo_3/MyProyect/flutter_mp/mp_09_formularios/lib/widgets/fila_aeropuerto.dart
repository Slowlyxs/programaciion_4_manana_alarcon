// lib/widgets/fila_aeropuerto.dart
import 'package:flutter/material.dart';
import '../models/aeropuerto.dart';

class FilaAeropuerto extends StatelessWidget {
  final Aeropuerto  aeropuerto;
  final VoidCallback onFavorito;
  final VoidCallback onEliminar;

  const FilaAeropuerto({
    super.key,
    required this.aeropuerto,
    required this.onFavorito,
    required this.onEliminar,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ListTile(
      // leading — icono con color según INTERNACIONAL
      leading: CircleAvatar(
        backgroundColor: aeropuerto.internacional
            ? cs.primaryContainer
            : cs.surfaceContainerHighest,
        child: Icon(
          Icons.local_airport,
          color: aeropuerto.internacional ? cs.onPrimaryContainer : cs.onSurfaceVariant,
        ),
      ),
      title: Text(
        aeropuerto.nombre,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        '${aeropuerto.ciudad} · ${aeropuerto.pistas} pista(s) · ${aeropuerto.operador} · ${aeropuerto.estado}',
        style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
      ),
      // trailing — dos acciones compactas
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              aeropuerto.favorito ? Icons.star : Icons.star_border,
              color: aeropuerto.favorito ? Colors.amber : cs.outline,
            ),
            onPressed:     onFavorito,
            visualDensity: VisualDensity.compact,
            tooltip:       aeropuerto.favorito ? 'Quitar favorito' : 'Agregar a favoritos',
          ),
          IconButton(
            icon:          Icon(Icons.delete_outline, color: cs.error),
            onPressed:     onEliminar,
            visualDensity: VisualDensity.compact,
            tooltip:       'Eliminar',
          ),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}