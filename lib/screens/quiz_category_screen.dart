
import 'package:flutter/material.dart';

import '../main.dart';
import '../services/quiz_service.dart';

class QuizCategoryScreen extends StatefulWidget {
  final String planetName;

  const QuizCategoryScreen({
    super.key,
    required this.planetName,
  });

  @override
  State<QuizCategoryScreen> createState() =>
      _QuizCategoryScreenState();
}

class _QuizCategoryScreenState extends State<QuizCategoryScreen> {
  late Future<List<String>> _categoriesFuture;

  static const Map<String, String> planetImages = {
    'Mercurio': 'assets/imagenes/Mercuriot.png',
    'Venus': 'assets/imagenes/Venust.png',
    'Tierra': 'assets/imagenes/Tierrat.png',
    'Marte': 'assets/imagenes/Martet.png',
    'Júpiter': 'assets/imagenes/Jupitert.png',
    'Saturno': 'assets/imagenes/Saturnot.png',
    'Urano': 'assets/imagenes/Uranot.png',
    'Neptuno': 'assets/imagenes/Neptunot.png',
  };

  static const Map<String, String> categoryImages = {
    'Características': 'assets/decoraciones/Caracteristicas.png',
    'Superficie': 'assets/decoraciones/Superficie.png',
    'Curiosidades': 'assets/decoraciones/Curiosidades.png',
  };

  @override
  void initState() {
    super.initState();

    _categoriesFuture =
        QuizService.instance.getCategories(widget.planetName);

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

  IconData getCategoryIcon(String category) {
    switch (category) {
      case 'Características':
        return Icons.public_rounded;
      case 'Superficie':
        return Icons.terrain_rounded;
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
      case 'Superficie':
        return 'Explora su superficie y composición';
      case 'Curiosidades':
        return 'Datos interesantes y sorprendentes';
      default:
        return 'Pon a prueba tus conocimientos';
    }
  }

  void openCategory(String category) {
    Navigator.pushNamed(
      context,
      '/quiz-question',
      arguments: {
        'planetName': widget.planetName,
        'category': category,
      },
    );
  }

  Widget buildPlanetImage(Color planetColor) {
    final String? imagePath = planetImages[widget.planetName];

    return Container(
      width: 62,
      height: 62,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: planetColor.withOpacity(0.15),
        border: Border.all(
          color: planetColor,
          width: 1.5,
        ),
      ),
      child: ClipOval(
        child: imagePath == null
            ? Icon(
                Icons.public_rounded,
                color: planetColor,
                size: 32,
              )
            : Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.public_rounded,
                    color: planetColor,
                    size: 32,
                  );
                },
              ),
      ),
    );
  }

  Widget buildCategoryImage(
    String category,
    Color planetColor,
    bool isDarkMode,
  ) {
    final String? imagePath = categoryImages[category];

    return Container(
      width: 48,
      height: 48,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: planetColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: imagePath == null
            ? Icon(
                getCategoryIcon(category),
                color: planetColor,
                size: 25,
              )
            : Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: isDarkMode
                        ? const Color(0xFF15264A)
                        : const Color(0xFFF1F5F9),
                    alignment: Alignment.center,
                    child: Icon(
                      getCategoryIcon(category),
                      color: planetColor,
                      size: 25,
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget buildCategoryCard(
    String category,
    bool isDarkMode,
  ) {
    final Color planetColor = getPlanetColor();

    final Color cardBg = isDarkMode
        ? const Color(0xFF0B193D)
        : Colors.white;

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
            buildCategoryImage(
              category,
              planetColor,
              isDarkMode,
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
                    style: TextStyle(
                      color: textSecondary,
                      fontSize: 12,
                    ),
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
    final bool isDarkMode =
        themeNotifier.value == ThemeMode.dark;

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
          widget.planetName,
          style: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.bold,
          ),
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
                  buildPlanetImage(getPlanetColor()),
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
                          style: TextStyle(
                            color: textSecondary,
                            fontSize: 13,
                          ),
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
                child: FutureBuilder<List<String>>(
                  future: _categoriesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: getPlanetColor(),
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'No se pudieron cargar las categorías.',
                          style: TextStyle(
                            color: textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    final List<String> categories =
                        snapshot.data ?? [];

                    if (categories.isEmpty) {
                      return Center(
                        child: Text(
                          'No hay categorías disponibles.',
                          style: TextStyle(
                            color: textSecondary,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return buildCategoryCard(
                          categories[index],
                          isDarkMode,
                        );
                      },
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
