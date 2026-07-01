import 'package:flutter/material.dart';

class Etiqueta extends StatelessWidget {
  final String texto;
  final Color color;
  final double fontSize;
  final bool relleno;
  final IconData? icono;

  const Etiqueta({
    super.key,
    required this.texto,
    required this.color,
    this.fontSize = 13,
    this.relleno = false,
    this.icono,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(4),
        gradient: LinearGradient(
          colors: [
            color.withOpacity(relleno ? 0.25 : 0.10),
            color.withOpacity(relleno ? 0.45 : 0.25),
          ],
        ),
        border: Border(
          bottom: BorderSide(
            color: color,
            width: 2,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icono != null) ...[
            Icon(
              icono,
              size: fontSize,
              color: color,
            ),
            const SizedBox(width: 6),
          ],
          Text(
            texto,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}