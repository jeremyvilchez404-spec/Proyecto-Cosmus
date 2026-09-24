import 'package:flutter/material.dart';

import '../main.dart';
import 'quiz_category_screen.dart';

class QuizScreen extends StatefulWidget {
  final String? planetName;

  const QuizScreen({super.key, this.planetName});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<String> planets = [
    'Mercurio',
    'Venus',
    'Tierra',
    'Marte',
    'Júpiter',
    'Saturno',
    'Urano',
    'Neptuno',
  ];

  @override
  void initState() {
    super.initState();

    themeNotifier.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    themeNotifier.removeListener(_onThemeChanged);
    super.dispose();
  }

  void _onThemeChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  Color getPlanetColor(String planet) {
    switch (planet) {
      case 'Mercurio':
        return const Color(0xFF9E9E9E);

      case 'Venus':
        return const Color(0xFFE6B566);

      case 'Tierra':
        return const Color(0xFF3D8BFF);

      case 'Marte':
        return const Color(0xFFE85D4A);

      case 'Júpiter':
        return const Color(0xFFD39A6A);

      case 'Saturno':
        return const Color(0xFFE0C58B);

      case 'Urano':
        return const Color(0xFF66D9E8);

      case 'Neptuno':
        return const Color(0xFF4169E1);

      default:
        return const Color(0xFF61DAFB);
    }
  }

  String getPlanetSymbol(String planet) {
    switch (planet) {
      case 'Mercurio':
        return '☿';

      case 'Venus':
        return '♀';

      case 'Tierra':
        return '⊕';

      case 'Marte':
        return '♂';

      case 'Júpiter':
        return '♃';

      case 'Saturno':
        return '♄';

      case 'Urano':
        return '♅';

      case 'Neptuno':
        return '♆';

      default:
        return '●';
    }
  }

  void openPlanet(String planet) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => QuizCategoryScreen(planetName: planet)),
    );
  }

  Widget buildPlanetCard(String planet, bool isDarkMode) {
    final Color planetColor = getPlanetColor(planet);

    final Color cardBg = isDarkMode ? const Color(0xFF0B193D) : Colors.white;

    final Color borderColor = isDarkMode
        ? const Color(0xFF1B3266)
        : const Color(0xFFE2E8F0);

    final Color textColor = isDarkMode ? Colors.white : const Color(0xFF0F172A);

    return GestureDetector(
      onTap: () => openPlanet(planet),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: borderColor, width: 1.2),
          boxShadow: [
            if (!isDarkMode)
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 7,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          children: [
            // PLANETA
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: planetColor.withOpacity(0.15),
                border: Border.all(color: planetColor, width: 1.5),
              ),
              child: Center(
                child: Text(
                  getPlanetSymbol(planet),
                  style: TextStyle(
                    color: planetColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 14),

            // NOMBRE
            Expanded(
              child: Text(
                planet,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // FLECHA
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDarkMode
                    ? Colors.white.withOpacity(0.06)
                    : const Color(0xFFF1F5F9),
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
                color: isDarkMode
                    ? const Color(0xFF61DAFB)
                    : const Color(0xFF1E88E5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = themeNotifier.value == ThemeMode.dark;

    final Color bgColor = isDarkMode
        ? const Color(0xFF040B1E)
        : const Color(0xFFF8FAFC);

    final Color textPrimary = isDarkMode
        ? Colors.white
        : const Color(0xFF0F172A);

    final Color textSecondary = isDarkMode
        ? Colors.white60
        : const Color(0xFF64748B);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        foregroundColor: textPrimary,
        title: Text(
          'Quiz',
          style: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selecciona un planeta',
                style: TextStyle(
                  color: textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                'Elige un planeta para comenzar el desafío.',
                style: TextStyle(color: textSecondary, fontSize: 13),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: ListView.builder(
                  itemCount: planets.length,
                  itemBuilder: (context, index) {
                    return buildPlanetCard(planets[index], isDarkMode);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
