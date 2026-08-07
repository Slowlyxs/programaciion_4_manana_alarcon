import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import 'todo_dto.dart';

class PantallaPaso2 extends StatelessWidget {
  const PantallaPaso2({super.key});

  Future<List<TodoDto>> _fetchOperaciones() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/todos?_limit=8'),
    );

    if (response.statusCode != 200) {
      throw Exception('Error HTTP ${response.statusCode}');
    }

    final lista = jsonDecode(response.body) as List<dynamic>;
    return lista
        .map((item) => TodoDto.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paso 2 · DTO de operaciones'),
        leading: BackButton(onPressed: () => context.go('/')),
      ),
      body: FutureBuilder<List<TodoDto>>(
        future: _fetchOperaciones(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final operaciones = snapshot.data ?? [];
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: operaciones.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, i) {
              final operacion = operaciones[i];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(child: Text('${operacion.id}')),
                  title: Text(
                    'Operación aeroportuaria ${operacion.id}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(operacion.title),
                  trailing: Chip(
                    avatar: Icon(
                      operacion.completed ? Icons.check_circle : Icons.schedule,
                      size: 18,
                    ),
                    label: Text(operacion.completed ? 'Completada' : 'Pendiente'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
