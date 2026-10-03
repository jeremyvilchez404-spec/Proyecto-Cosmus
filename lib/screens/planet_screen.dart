import 'package:flutter/material.dart';
import '../main.dart'; // Importamos themeNotifier global
import 'quiz_screen.dart';

class PlanetScreen extends StatefulWidget {
  final Map<String, dynamic>? planet;

  const PlanetScreen({super.key, this.planet});

  @override
  State<PlanetScreen> createState() => _PlanetScreenState();
}

class _PlanetScreenState extends State<PlanetScreen> {
  @override
  void initState() {
    super.initState();
    // Escuchar activamente cambios del tema
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

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = themeNotifier.value == ThemeMode.dark;

    // Paleta de colores reactiva al tema
    final Color bgColor = isDarkMode
        ? const Color(0xFF040B1E)
        : const Color(0xFFF8FAFC);
    final Color cardBg = isDarkMode ? const Color(0xFF0B193D) : Colors.white;
    final Color cardBorder = isDarkMode
        ? const Color(0xFF1B3266)
        : const Color(0xFFE2E8F0);
    final Color textPrimary = isDarkMode
        ? Colors.white
        : const Color(0xFF0F172A);
    final Color textSecondary = isDarkMode
        ? Colors.white70
        : const Color(0xFF64748B);

    final args = ModalRoute.of(context)?.settings.arguments;

    final Map<String, dynamic> data =
        widget.planet ??
        (args is Map<String, dynamic>
            ? args
            : <String, dynamic>{
                'name': 'Planeta',
                'emoji': '🪐',
                'color': Colors.blue,
                'description': 'Información no disponible.',
                'distance': 'N/A',
                'moons': 'N/A',
                'dayLength': 'N/A',
                'temp': 'N/A',
              });

    final String name = data['name']?.toString() ?? 'Planeta';
    final String emoji = data['emoji']?.toString() ?? '🪐';
    final String description =
        data['description']?.toString() ?? 'Información no disponible.';

    final Color accentColor = data['color'] is Color
        ? data['color'] as Color
        : Colors.blueAccent;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        foregroundColor: textPrimary,
        elevation: 0,
        title: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold, color: textPrimary),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 10),

              // PLANETA DESTELLO / EMOJI
              Container(
                width: 190,
                height: 190,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accentColor.withOpacity(0.15),
                  boxShadow: [
                    BoxShadow(
                      color: accentColor.withOpacity(0.35),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(emoji, style: const TextStyle(fontSize: 110)),
                ),
              ),

              const SizedBox(height: 25),

              // NOMBRE
              Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                ),
              ),

              const SizedBox(height: 16),

              // DESCRIPCIÓN
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: textSecondary,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 35),

              // TARJETA DE INFORMACIÓN DE LOS ASTROS
              _buildInfoCard(
                title: 'Información del astro',
                cardBg: cardBg,
                cardBorder: cardBorder,
                titleColor: textPrimary,
                children: [
                  _buildRow(
                    Icons.public,
                    'Distancia al Sol',
                    data['distance']?.toString() ?? 'No disponible',
                    textPrimary,
                    textSecondary,
                  ),
                  _buildRow(
                    Icons.nightlight_round,
                    'Número de lunas',
                    data['moons']?.toString() ?? 'No disponible',
                    textPrimary,
                    textSecondary,
                  ),
                  _buildRow(
                    Icons.access_time,
                    'Duración del día',
                    data['dayLength']?.toString() ?? 'No disponible',
                    textPrimary,
                    textSecondary,
                  ),
                  _buildRow(
                    Icons.thermostat,
                    'Temperatura media',
                    data['temp']?.toString() ?? 'No disponible',
                    textPrimary,
                    textSecondary,
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // BOTÓN DE ACCESO AL QUIZ DIRECTO DEL PLANETA
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/quiz', arguments: name);
                  },
                  icon: const Icon(Icons.quiz),
                  label: Text('Hacer Quiz de $name'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE83E8C),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // BOTÓN VOLVER
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Volver al sistema solar'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: accentColor,
                    side: BorderSide(color: accentColor),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required List<Widget> children,
    required Color cardBg,
    required Color cardBorder,
    required Color titleColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          ...children,
        ],
      ),
    );
  }

  Widget _buildRow(
    IconData icon,
    String title,
    String value,
    Color textPrimary,
    Color textSecondary,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: textSecondary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: textSecondary, fontSize: 14),
            ),
          ),
          Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
