import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class PantallaPaso1 extends StatelessWidget {
  const PantallaPaso1({super.key});

  Future<Map<String, dynamic>> _fetchOperacion() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/todos/1'),
    );
    if (response.statusCode != 200) {
      throw Exception('Error HTTP ${response.statusCode}');
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paso 1 · FutureBuilder sin DTO'),
        leading: BackButton(onPressed: () => context.go('/')),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchOperacion(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.wifi_off, size: 48, color: Colors.red),
                  const SizedBox(height: 8),
                  Text('Error: ${snapshot.error}'),
                ],
              ),
            );
          }

          final operacion = snapshot.data!;
          final completada = operacion['completed'] as bool;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        completada ? Icons.task_alt : Icons.pending_actions,
                        size: 54,
                        color: completada ? Colors.green : Colors.orange,
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Operación aeroportuaria ${operacion['id']}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        operacion['title'] as String,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 14),
                      Chip(label: Text(completada ? 'Completada' : 'Pendiente')),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
