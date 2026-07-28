import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import 'personal_dto.dart';

class PantallaPaso2Personal extends StatelessWidget {
  const PantallaPaso2Personal({super.key});

  Future<List<TodoDtoUser>> _fetchPersonal() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users?_limit=8'),
    );
    if (response.statusCode != 200) {
      throw Exception('Error HTTP ${response.statusCode}');
    }
    final lista = jsonDecode(response.body) as List<dynamic>;
    return lista
        .map((item) => TodoDtoUser.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paso 2 · DTO de personal'),
        leading: BackButton(onPressed: () => context.go('/')),
      ),
      body: FutureBuilder<List<TodoDtoUser>>(
        future: _fetchPersonal(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final personal = snapshot.data ?? [];
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: personal.length,
            itemBuilder: (context, i) {
              final persona = personal[i];
              return Card(
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(persona.username),
                  subtitle: Text(persona.email),
                  trailing: SizedBox(
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(persona.phone, maxLines: 1, overflow: TextOverflow.ellipsis),
                        Text(persona.website, maxLines: 1, overflow: TextOverflow.ellipsis),
                      ],
                    ),
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
