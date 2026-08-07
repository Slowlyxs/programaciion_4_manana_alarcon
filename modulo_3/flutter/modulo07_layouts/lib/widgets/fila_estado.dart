import 'package:flutter/material.dart';

class FilaEstado extends StatelessWidget {
  final String nombre;
  final String detalle;
  final bool activo;

  const FilaEstado({
    super.key,
    required this.nombre,
    required this.detalle,
    required this.activo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        //  experimento: cambia esto a spaceBetween si quieres probar
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Ícono de estado (cambiado a circle como pediste)
          Icon(
            Icons.circle,
            color: activo ? Colors.green : Colors.red,
            size: 12,
          ),

          const SizedBox(width: 12),

          //  SIN Expanded (como pediste)
          // Ahora el texto puede desbordarse si es largo
          Column(
            crossAxisAlignment: CrossAxisAlignment.end, // cambiado como pediste
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                nombre,
                style: const TextStyle(fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                detalle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),

          //  Spacer en lugar de Expanded
          const Spacer(),

          // Chip de estado
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: (activo ? Colors.green : Colors.red).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              activo ? 'Activo' : 'Caído',
              style: TextStyle(
                fontSize: 11,
                color: activo ? Colors.green.shade700 : Colors.red.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}