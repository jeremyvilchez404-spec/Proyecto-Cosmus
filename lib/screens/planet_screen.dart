import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class PlanetScreen extends StatelessWidget {
  final Map<String, dynamic>? planet;

  const PlanetScreen({super.key, this.planet});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    final Map<String, dynamic> data =
        planet ??
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
      backgroundColor: const Color(0xFF050711),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 10),

              // PLANETA
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
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 35),

              // INFORMACIÓN
              _buildInfoCard(
                title: 'Información del astro',
                children: [
                  _buildRow(
                    Icons.public,
                    'Distancia al Sol',
                    data['distance']?.toString() ?? 'No disponible',
                  ),

                  _buildRow(
                    Icons.nightlight_round,
                    'Número de lunas',
                    data['moons']?.toString() ?? 'No disponible',
                  ),

                  _buildRow(
                    Icons.access_time,
                    'Duración del día',
                    data['dayLength']?.toString() ?? 'No disponible',
                  ),

                  _buildRow(
                    Icons.thermostat,
                    'Temperatura media',
                    data['temp']?.toString() ?? 'No disponible',
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // BOTÓN VOLVER
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Volver al sistema solar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: Colors.white,
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
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
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

  Widget _buildRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.white54, size: 20),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white60, fontSize: 14),
            ),
          ),

          Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
