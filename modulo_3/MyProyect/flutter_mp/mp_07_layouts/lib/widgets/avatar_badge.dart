import 'package:flutter/material.dart';

class AvatarBadge extends StatelessWidget {
  final String nombre;
  final int alertas;
  final bool activo;

  const AvatarBadge({
    super.key,
    required this.nombre,
    required this.alertas,
    required this.activo,
  });

  @override
  Widget build(BuildContext context) {
    final texto = nombre.trim();
    final limite = texto.length > 3 ? 3 : texto.length;
    final codigo = texto.isEmpty ? '--' : texto.substring(0, limite).toUpperCase();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: activo ? Colors.indigo.shade100 : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Text(
                  codigo,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: activo ? Colors.indigo.shade800 : Colors.grey.shade600,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -2,
              right: -2,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: activo ? Colors.green : Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
              ),
            ),
            if (alertas > 0)
              Positioned(
                top: -7,
                right: -7,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                  child: Text(
                    alertas > 9 ? '9+' : '$alertas',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          activo ? 'Operativo' : 'Suspendido',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: activo ? Colors.green.shade700 : Colors.red.shade700,
          ),
        ),
      ],
    );
  }
}
