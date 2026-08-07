import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class PantallaPaso1User extends StatelessWidget {
  const PantallaPaso1User({super.key});

  Future<Map<String, dynamic>> _fetchPersonal() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users/1'),
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
        title: const Text('Paso 1 · Personal sin DTO'),
        leading: BackButton(onPressed: () => context.go('/')),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchPersonal(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final personal = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Icon(Icons.badge_outlined, size: 60, color: Colors.indigo),
              const SizedBox(height: 12),
              Text(
                personal['name'] as String,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              const Text('Personal de operaciones aeroportuarias', textAlign: TextAlign.center),
              const SizedBox(height: 18),
              ListTile(leading: const Icon(Icons.account_circle), title: Text('@${personal['username']}')),
              ListTile(leading: const Icon(Icons.email), title: Text(personal['email'] as String)),
              ListTile(leading: const Icon(Icons.phone), title: Text(personal['phone'] as String)),
              ListTile(leading: const Icon(Icons.business), title: Text((personal['company'] as Map<String, dynamic>)['name'] as String)),
            ],
          );
        },
      ),
    );
  }
}
