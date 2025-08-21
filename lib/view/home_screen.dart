import 'package:flutter/material.dart';
import 'package:jotstcg/controller/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = AuthController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Principal (Home)'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () {
              authController.signOut();
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Bem-vindo! Você está logado.'),
      ),
    );
  }
}
