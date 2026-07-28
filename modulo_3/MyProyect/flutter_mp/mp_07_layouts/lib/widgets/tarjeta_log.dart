import 'package:flutter/material.dart';

class TarjetaLog extends StatelessWidget {
  final String nivel;
  final String componente;
  final String mensaje;
  final DateTime timestamp;

  const TarjetaLog({
    super.key,
    required this.nivel,
    required this.componente,
    required this.mensaje,
    required this.timestamp,
  });

  Color get _colorNivel => switch (nivel) {
        'DEBUG' => Colors.grey,
        'INFO' => Colors.blue,
        'WARN' => Colors.orange,
        'ERROR' => Colors.red,
        _ => Colors.grey,
      };

  String get _etiquetaNivel => switch (nivel) {
        'DEBUG' => 'SISTEMA',
        'INFO' => 'INFO',
        'WARN' => 'ALERTA',
        'ERROR' => 'CRÍTICO',
        _ => nivel,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border(
          left: BorderSide(color: _colorNivel, width: 6),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _colorNivel,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  _etiquetaNivel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  componente,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '${timestamp.hour.toString().padLeft(2, '0')}:'
                '${timestamp.minute.toString().padLeft(2, '0')}',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
              ),
            ],
          ),
          const SizedBox(height: 9),
          Text(
            mensaje,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
          ),
        ],
      ),
    );
  }
}
