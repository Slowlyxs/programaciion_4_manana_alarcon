// lib/widgets/tarjeta_aeropuerto_grid.dart
import 'package:flutter/material.dart';
import '../models/aeropuerto.dart';

class TarjetaAeropuertoGrid extends StatelessWidget {
  final Aeropuerto  aeropuerto;
  final VoidCallback onFavorito;
  final VoidCallback onEliminar;

  const TarjetaAeropuertoGrid({
    super.key,
    required this.aeropuerto,
    required this.onFavorito,
    required this.onEliminar,
  });

  @override
  Widget build(BuildContext context) {
    final cs   = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fila superior: icono + favorito
            Row(children: [
              Icon(
                Icons.local_airport,
                color: aeropuerto.internacional ? cs.primary : cs.outline,
                size: 18,
              ),
              const Spacer(),
              GestureDetector(
                onTap: onFavorito,
                child: Icon(
                  aeropuerto.favorito ? Icons.star : Icons.star_border,
                  color: aeropuerto.favorito ? Colors.amber : cs.outline,
                  size: 18,
                ),
              ),
            ]),
            const SizedBox(height: 6),

            // Nombre e CIUDAD
            Text(
              aeropuerto.nombre,
              style: text.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              aeropuerto.ciudad,
              style: text.bodySmall?.copyWith(color: cs.onSurfaceVariant),
            ),

            const Spacer(),

            // Fila inferior: INTERNACIONAL + CATEGORIA + eliminar
            Row(children: [
              if (aeropuerto.internacional)
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Icon(Icons.lock, size: 12, color: cs.primary),
                ),
              Expanded(
                child: Text(
                  aeropuerto.categoria,
                  style: text.labelSmall?.copyWith(color: cs.onSurfaceVariant),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: onEliminar,
                child: Icon(Icons.delete_outline, size: 16, color: cs.error),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}