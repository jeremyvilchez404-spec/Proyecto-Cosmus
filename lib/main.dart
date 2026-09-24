import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/planet_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/solar_system_screen.dart';
import 'screens/learn_screeen.dart';
import 'screens/learn_planets_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COSMUS',

      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF040B1E),
        useMaterial3: true,
      ),

      // Inicia directamente en la pantalla de Login
      initialRoute: '/login',

      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/solar-system': (context) => const SolarSystemScreen(),
        '/learn': (context) => const LearnScreen(),
        '/learn-planets': (context) => const LearnPlanetsScreen(),

        '/planet': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;

          if (args is Map<String, dynamic>) {
            return PlanetScreen(planet: args);
          }

          return const PlanetScreen();
        },

        '/quiz': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;

          // Extrae el nombre del planeta si se envía como String; usa 'Tierra' como valor por defecto
          final String planetName = args is String ? args : 'Tierra';

          return QuizScreen(planetName: planetName);
        },

        '/profile': (context) =>
            const PlaceholderScreen(title: 'Perfil', icon: Icons.person),
      },
    );
  }
}

/// Pantalla temporal para rutas en desarrollo
class PlaceholderScreen extends StatelessWidget {
  final String title;
  final IconData icon;

  const PlaceholderScreen({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: Colors.blueAccent),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Esta sección estará disponible próximamente.',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}
