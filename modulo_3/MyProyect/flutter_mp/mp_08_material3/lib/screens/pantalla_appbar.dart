import 'package:flutter/material.dart';

class PantallaAppBar extends StatelessWidget {
  const PantallaAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    const aeropuertos = [
      ('UIO', 'Mariscal Sucre', 'Quito · 2 pistas'),
      ('GYE', 'José Joaquín de Olmedo', 'Guayaquil · 2 pistas'),
      ('CUE', 'Mariscal Lamar', 'Cuenca · 1 pista'),
      ('MEC', 'Eloy Alfaro', 'Manta · 1 pista'),
      ('ETR', 'Santa Rosa', 'El Oro · 1 pista'),
      ('GPS', 'Seymour', 'Galápagos · 1 pista'),
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            title: const Text('Aeropuertos'),
            pinned: true,
            backgroundColor: cs.tertiaryContainer,
            foregroundColor: cs.onTertiaryContainer,
            actions: [
              IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}, tooltip: 'Filtrar'),
              IconButton(icon: const Icon(Icons.search), onPressed: () {}, tooltip: 'Buscar'),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: cs.primaryContainer,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 56),
                    Icon(Icons.local_airport, size: 48, color: cs.onPrimaryContainer),
                    const SizedBox(height: 8),
                    Text('6 aeropuertos monitoreados', style: TextStyle(color: cs.onPrimaryContainer)),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final aeropuerto = aeropuertos[i];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: cs.primaryContainer,
                        child: Text(aeropuerto.$1),
                      ),
                      title: Text(aeropuerto.$2),
                      subtitle: Text(aeropuerto.$3),
                      trailing: Chip(
                        label: const Text('Operativo'),
                        backgroundColor: Colors.green.shade100,
                      ),
                      onTap: () {},
                    ),
                  );
                },
                childCount: aeropuertos.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
