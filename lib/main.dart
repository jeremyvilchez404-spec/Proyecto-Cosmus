import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/planet_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/solar_system_screen.dart';

void main() async {
  // Asegura la inicialización de los bindings de Flutter antes de SharedPreferences
  WidgetsFlutterBinding.ensureInitialized();

  // Lee el estado guardado de la sesión
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

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

      // Si la sesión ya está iniciada entra directo a /home, sino a /login
      initialRoute: isLoggedIn ? '/home' : '/login',

      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/solar-system': (context) => const SolarSystemScreen(),

        '/planet': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;

          if (args is Map<String, dynamic>) {
            return PlanetScreen(planet: args);
          }

          return const PlanetScreen();
        },

        '/quiz': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;

          // Extrae el nombre del planeta si se envía como String; usa 'Tierra' por defecto
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
