
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/planet_screen.dart';
import 'screens/solar_system_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/learn_screeen.dart';
import 'screens/learn_planets_screen.dart';

// ===============================
// PANTALLAS DEL QUIZ
// ===============================
import 'screens/quiz_screen.dart';
import 'screens/quiz_history_screen.dart';
import 'screens/quiz_category_screen.dart';
import 'screens/quiz_question_screen.dart';

// ==========================================
// NOTIFICADOR GLOBAL DEL TEMA
// ==========================================
final ValueNotifier<ThemeMode> themeNotifier =
    ValueNotifier<ThemeMode>(ThemeMode.dark);

// ==========================================
// INICIO DE LA APLICACIÓN
// ==========================================
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  final bool isDarkMode = prefs.getBool('isDarkMode') ?? true;

  themeNotifier.value =
      isDarkMode ? ThemeMode.dark : ThemeMode.light;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

// ==========================================
// APLICACIÓN PRINCIPAL
// ==========================================
class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({
    super.key,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, ThemeMode currentMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'COSMUS',
          themeMode: currentMode,

          // ==================================
          // TEMA CLARO
          // ==================================
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF1F5F9),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF1E88E5),
              brightness: Brightness.light,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(
                color: Color(0xFF0F172A),
              ),
              titleTextStyle: TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 20,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
            useMaterial3: true,
          ),

          // ==================================
          // TEMA OSCURO
          // ==================================
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF040B1E),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF61DAFB),
              brightness: Brightness.dark,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
            useMaterial3: true,
          ),

          // ==================================
          // RUTA INICIAL SEGÚN LA SESIÓN
          // ==================================
          initialRoute: isLoggedIn ? '/home' : '/login',

          // ==================================
          // RUTAS DE LA APLICACIÓN
          // ==================================
          routes: {
            '/login': (context) => const LoginScreen(),

            '/home': (context) => const HomeScreen(),

            '/solar-system': (context) =>
                const SolarSystemScreen(),

            '/learn': (context) => const LearnScreen(),

            '/learn-planets': (context) =>
                const LearnPlanetsScreen(),

            // ==================================
            // INFORMACIÓN DEL PLANETA
            // ==================================
            '/planet': (context) {
              final args =
                  ModalRoute.of(context)?.settings.arguments;

              if (args is Map<String, dynamic>) {
                return PlanetScreen(planet: args);
              }

              return const PlanetScreen();
            },

            // ==================================
            // QUIZ GENERAL
            // Siempre muestra la lista de planetas.
            // No asignar Tierra como valor predeterminado.
            // ==================================
            '/quiz': (context) => const QuizScreen(),

            // ==================================
            // CATEGORÍAS DEL QUIZ
            // Recibe el planeta seleccionado.
            // ==================================
            '/quiz-category': (context) {
              final args =
                  ModalRoute.of(context)?.settings.arguments;

              String? planetName;

              if (args is String) {
                planetName = args;
              } else if (args is Map) {
                planetName = args['planetName']?.toString();
              }

              return QuizCategoryScreen(
                planetName:
                    planetName?.trim().isNotEmpty == true
                        ? planetName!.trim()
                        : 'Tierra',
              );
            },

            // ==================================
            // PREGUNTAS DEL QUIZ
            // ==================================
            '/quiz-question': (context) {
              final args =
                  ModalRoute.of(context)?.settings.arguments;

              String planetName = 'Tierra';
              String category = 'General';

              if (args is Map) {
                planetName =
                    args['planetName']?.toString() ?? 'Tierra';

                category =
                    args['category']?.toString() ?? 'General';
              }

              return QuizQuestionScreen(
                planetName: planetName,
                categoryName: category,
              );
            },

            // ==================================
            // PERFIL
            // ==================================
            '/profile': (context) => const ProfileScreen(),

            // ==================================
            // HISTORIAL Y PROGRESO
            // ==================================
            '/progress': (context) => const QuizHistoryScreen(),
          },
        );
      },
    );
  }
}

// ==========================================
// PANTALLA PLACEHOLDER
// ==========================================
class PlaceholderScreen extends StatelessWidget {
  final String title;
  final IconData icon;

  const PlaceholderScreen({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Esta sección estará disponible próximamente.',
              style: TextStyle(
                color: Colors.white70,
              ),
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
