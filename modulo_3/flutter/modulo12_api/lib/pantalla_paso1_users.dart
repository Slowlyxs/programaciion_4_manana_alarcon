import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class PantallaPaso1User extends StatelessWidget {
  const PantallaPaso1User({super.key});

  Future<Map<String, dynamic>> _fetchUser() async {
    final res = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users/1'),
    );

    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paso 1 Users · FutureBuilder crudo'),
        leading: BackButton(onPressed: () => context.go('/')),
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _fetchUser(),
          builder: (context, snap) {
            // Estado 1: cargando
            if (snap.connectionState != ConnectionState.done) {
              return const CircularProgressIndicator();
            }

            // Estado 2: error
            if (snap.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 48, color: Colors.red),
                  const SizedBox(height: 8),
                  Text(
                    'Error: ${snap.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              );
            }

            // Estado 3: datos disponibles
            final user = snap.data!;

            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person, size: 60, color: Colors.blue),
                  const SizedBox(height: 16),

                  Text(
                    user['name'],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '@${user['username']}',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),

                  const SizedBox(height: 16),

                  ListTile(
                    leading: const Icon(Icons.email),
                    title: Text(user['email']),
                  ),

                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: Text(user['phone']),
                  ),

                  ListTile(
                    leading: const Icon(Icons.language),
                    title: Text(user['website']),
                  ),

                  ListTile(
                    leading: const Icon(Icons.business),
                    title: Text(user['company']['name']),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
