import 'package:flutter/material.dart';

import '../data/quiz_data.dart';
import '../main.dart';
import 'quiz_question_screen.dart';

class QuizCategoryScreen extends StatefulWidget {
  final String planetName;

  const QuizCategoryScreen({super.key, required this.planetName});

  @override
  State<QuizCategoryScreen> createState() => _QuizCategoryScreenState();
}

class _QuizCategoryScreenState extends State<QuizCategoryScreen> {
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

  Color getPlanetColor() {
    switch (widget.planetName) {
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

  String getPlanetSymbol() {
    switch (widget.planetName) {
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

  IconData getCategoryIcon(String category) {
    switch (category) {
      case 'Características':
        return Icons.public_rounded;
      case 'Fauna':
        return Icons.pets_rounded;
      case 'Flora':
        return Icons.eco_rounded;
      case 'Luna':
        return Icons.nightlight_round;
      case 'Lunas':
        return Icons.brightness_3_rounded;
      case 'Superficie':
        return Icons.terrain_rounded;
      case 'Atmósfera':
        return Icons.air_rounded;
      case 'Anillos':
        return Icons.radio_button_unchecked_rounded;
      case 'Gran Mancha Roja':
        return Icons.blur_circular_rounded;
      case 'Curiosidades':
        return Icons.auto_awesome_rounded;
      default:
        return Icons.quiz_rounded;
    }
  }

  String getCategoryDescription(String category) {
    switch (category) {
      case 'Características':
        return 'Conoce sus principales características';
      case 'Fauna':
        return 'Descubre los animales del planeta';
      case 'Flora':
        return 'Aprende sobre plantas y vegetación';
      case 'Luna':
        return 'Conoce nuestro satélite natural';
      case 'Lunas':
        return 'Descubre sus satélites naturales';
      case 'Superficie':
        return 'Explora su superficie y composición';
      case 'Atmósfera':
        return 'Aprende sobre su atmósfera';
      case 'Anillos':
        return 'Descubre sus impresionantes anillos';
      case 'Gran Mancha Roja':
        return 'Conoce esta enorme tormenta';
      case 'Curiosidades':
        return 'Datos interesantes y sorprendentes';
      default:
        return 'Pon a prueba tus conocimientos';
    }
  }

  void openCategory(String category) {
    // Usamos la ruta nombrada '/quiz-question' tal como está definida en el main.dart
    Navigator.pushNamed(
      context,
      '/quiz-question',
      arguments: {'planetName': widget.planetName, 'category': category},
    );
  }

  Widget buildCategoryCard(String category, bool isDarkMode) {
    final Color planetColor = getPlanetColor();
    final Color cardBg = isDarkMode ? const Color(0xFF0B193D) : Colors.white;
    final Color borderColor = isDarkMode
        ? const Color(0xFF1B3266)
        : const Color(0xFFE2E8F0);
    final Color textPrimary = isDarkMode
        ? Colors.white
        : const Color(0xFF0F172A);
    final Color textSecondary = isDarkMode
        ? Colors.white54
        : const Color(0xFF64748B);

    return GestureDetector(
      onTap: () => openCategory(category),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: borderColor),
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
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: planetColor.withOpacity(0.14),
              ),
              child: Icon(
                getCategoryIcon(category),
                color: planetColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    getCategoryDescription(category),
                    style: TextStyle(color: textSecondary, fontSize: 12),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: isDarkMode
                  ? const Color(0xFF61DAFB)
                  : const Color(0xFF1E88E5),
              size: 16,
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
    final Color planetColor = getPlanetColor();

    final List<String> categories = QuizData.getCategories(widget.planetName);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        foregroundColor: textPrimary,
        title: Text(
          widget.planetName,
          style: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: planetColor.withOpacity(0.15),
                      border: Border.all(color: planetColor, width: 1.5),
                    ),
                    child: Center(
                      child: Text(
                        getPlanetSymbol(),
                        style: TextStyle(
                          color: planetColor,
                          fontSize: 29,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.planetName,
                          style: TextStyle(
                            color: textPrimary,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Selecciona un tema',
                          style: TextStyle(color: textSecondary, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Text(
                'Temas disponibles',
                style: TextStyle(
                  color: textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: categories.isEmpty
                    ? Center(
                        child: Text(
                          'No hay categorías disponibles.',
                          style: TextStyle(color: textSecondary),
                        ),
                      )
                    : ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return buildCategoryCard(
                            categories[index],
                            isDarkMode,
                          );
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
