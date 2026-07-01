import 'package:flutter/material.dart';

class CatalogoBasicos extends StatelessWidget {
  const CatalogoBasicos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widgets básicos'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // ── TEXT BÁSICO ─────────────────────────────────────────────
          Text(
            'nginx-proxy: En línea',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green,
              letterSpacing: 0.5,
              decoration: TextDecoration.combine([
                TextDecoration.underline,
                TextDecoration.lineThrough,
              ]),
            ),
            softWrap: false,
          ),

          const SizedBox(height: 8),

          // ── Alineación y desbordamiento ─────────────────────────────
          const SizedBox(
            width: double.infinity,
            child: Text(
              'api-gateway-produccion-region-us-east → sin respuesta',
              textAlign: TextAlign.justify,
              maxLines: 2,
              overflow: TextOverflow.fade,
            ),
          ),

          const SizedBox(height: 8),

          // ── Text.rich ────────────────────────────────────────────────
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Estado: ',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const TextSpan(
                  text: 'CRÍTICO',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                  text: ' — última revisión hace 5 min',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // ── SelectableText ──────────────────────────────────────────
          const SelectableText(
            '10.0.0.12:5432',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 14,
            ),
          ),

          const Divider(height: 32),

          // ─────────────────────────────────────────────────────────────
          // ICONOS
          // ─────────────────────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(Icons.check_circle, size: 40, color: Colors.green),
              Icon(Icons.cancel, size: 40, color: Colors.red),
              Icon(Icons.warning_amber, size: 40, color: Colors.orange),
              Icon(Icons.dns, size: 40, color: Colors.indigo),
              Icon(Icons.wifi_off, size: 40, color: Colors.grey),
              Icon(Icons.settings_accessibility,
                  size: 40, color: Colors.yellow),
            ],
          ),

          const SizedBox(height: 8),

          const Icon(
            Icons.settings,
            size: 24,
            color: Colors.blueGrey,
            semanticLabel: 'Configuración',
          ),

          const Divider(height: 32),

          // ─────────────────────────────────────────────────────────────
          // BOTONES
          // ─────────────────────────────────────────────────────────────
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('ElevatedButton'),
              ),
              FilledButton(
                onPressed: () {},
                child: const Text('FilledButton'),
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Text('OutlinedButton'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('TextButton'),
              ),
              const ElevatedButton(
                onPressed: null,
                child: Text('Desactivado'),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Reiniciar'),
              ),
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.stop, size: 18),
                label: const Text('Detener'),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings),
                color: Colors.indigo,
                iconSize: 28,
              ),
            ],
          ),

          const SizedBox(height: 12),

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 4,
              minimumSize: const Size(double.infinity, 0),
            ),
            child: const Text(
              'Acción crítica',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          const Divider(height: 32),

          // ─────────────────────────────────────────────────────────────
          // TARJETAS
          // ─────────────────────────────────────────────────────────────
          Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              isThreeLine: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              leading: const Icon(Icons.dns, color: Colors.indigo),
              title: const Text('nginx-proxy'),
              subtitle: const Text('10.0.0.5 · 45ms'),
              trailing: const Icon(Icons.circle,
                  color: Colors.green, size: 12),
              onTap: () {},
            ),
          ),

          Card(
            elevation: 12,
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red.shade100,
                child: const Icon(Icons.cancel,
                    color: Colors.red, size: 20),
              ),
              title: const Text('backup-worker'),
              subtitle: const Text('sin respuesta · 10.0.0.30'),
              trailing: TextButton(
                onPressed: () {},
                child: const Text('Ver'),
              ),
            ),
          ),

          Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 8),
            child: SwitchListTile(
              value: false,
              onChanged: (_) {},
              title: const Text('Modo mantenimiento'),
            ),
          ),

          const Divider(height: 32),

          // ─────────────────────────────────────────────────────────────
          // CHIPS
          // ─────────────────────────────────────────────────────────────
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Chip(
                label: const Text('nginx'),
                padding: const EdgeInsets.all(8),
                deleteIcon: const Icon(Icons.close, size: 16),
                onDeleted: () {},
              ),
              const Chip(
                avatar: Icon(Icons.check,
                    size: 16, color: Colors.white),
                label: Text('TLS 1.3'),
                backgroundColor: Colors.blue,
                labelStyle:
                    TextStyle(color: Colors.white, fontSize: 12),
              ),
              FilterChip(
                label: const Text('HTTP/2'),
                selected: false,
                onSelected: (_) {},
              ),
              InputChip(
                avatar: const Icon(Icons.dns,
                    size: 16, color: Colors.indigo),
                label: const Text('api-gateway'),
                onDeleted: () {},
                selected: true,
              ),
              ActionChip(
                label: const Text('Ver logs'),
                avatar: const Icon(Icons.open_in_new, size: 16),
                onPressed: () {},
              ),
            ],
          ),

          const Divider(height: 32),

          // ─────────────────────────────────────────────────────────────
          // PROGRESS
          // ─────────────────────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(),
              ),
              SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(
                  value: 0.7,
                  color: Colors.green,
                  strokeWidth: 6,
                ),
              ),
              SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(
                  value: 0.3,
                  color: Colors.red,
                  strokeWidth: 3,
                  strokeCap: StrokeCap.round,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          const LinearProgressIndicator(),
          const SizedBox(height: 8),
          const LinearProgressIndicator(
            value: 0.6,
            color: Colors.indigo,
          ),
          const SizedBox(height: 8),
          const LinearProgressIndicator(
            value: 1.0,
            color: Colors.green,
            minHeight: 6,
          ),

          const Divider(height: 32),

          
        ],
      ),
    );
  }
}