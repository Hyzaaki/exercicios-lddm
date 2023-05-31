import 'package:exercicios/src/pages/telaDeLogin/login_page.dart';
import 'package:exercicios/src/pages/telaDeLogin/registration_page.dart';
import 'package:flutter/material.dart';

import 'src/pages/itemListAlert/item_list_page.dart';

void main() async {

  /*
    definir factory em despositivos nao mobile apenas Mac
    sendo window e linux com erros pois a biblioteca Sqlite tem suporte apenas
    para essas citados

    -- https://pub.dev/packages/sqflite


    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

   */

  runApp(const ExerciseHubApp());
}

class ExerciseHubApp extends StatelessWidget {
  const ExerciseHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercicios LDDM',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/exercise1': (context) => const RegistrationScreen(),
        '/exercise2': (context) => LoginWidget(),
        '/exercise4': (context) => ItemListPage(),

        // Add more routes for other exercises
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela de exercicios'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/exercise2');
              },
              child: const Text('Exercício - Tela de Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/exercise1');
              },
              child: const Text('Exercício - Tela de signUp'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/exercise4');
              },
              child: const Text('Exercício - Lista Item Alert'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/exercise5');
              },
              child: const Text('Exercício - CRUD'),
            ),
          ],
        ),
      ),
    );
  }
}
