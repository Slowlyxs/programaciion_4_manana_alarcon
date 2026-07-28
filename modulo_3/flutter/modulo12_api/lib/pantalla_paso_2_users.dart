import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import 'todo_dto_user.dart';

class PantallaPaso2Users extends StatelessWidget {
  const PantallaPaso2Users({super.key});

  Future<List<TodoDtoUser>> _fetchUsers() async {
    final res = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users?_limit=15'),
    );

    final lista = jsonDecode(res.body) as List<dynamic>;

    return lista
        .map((e) => TodoDtoUser.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paso 2 USERS · DTO simple'),
        leading: BackButton(onPressed: () => context.go('/')),
      ),
      body: FutureBuilder<List<TodoDtoUser>>(
        future: _fetchUsers(),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }

          final users = snap.data ?? [];

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Chip(
                      label: Text('${users.length} usuarios'),
                      backgroundColor: Colors.blue[100],
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, i) {
                    final u = users[i];

                    return ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(u.username),
                      subtitle: Text(u.email),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text(u.phone), Text(u.website)],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
