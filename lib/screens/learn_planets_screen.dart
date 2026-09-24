import 'package:flutter/material.dart';
import 'learn_planet_detail_screen.dart';

class LearnPlanetsScreen extends StatelessWidget {
  const LearnPlanetsScreen({super.key});

  final List<Map<String, dynamic>> planets = const [
    {
      'name': 'Mercurio',
      'subtitle': 'El planeta más cercano al Sol',
      'icon': '☿',
      'image': 'assets/imagenes/Mercurio.png',
      'description':
      'Mercurio es el planeta más cercano al Sol y el más pequeño del Sistema Solar. Su superficie rocosa presenta numerosos cráteres y experimenta grandes cambios de temperatura entre el día y la noche.',
      'distance': '57.9 millones de km',
      'day': '58.6 días terrestres',
      'year': '88 días terrestres',
      'moons': '0',
      'curiosities': [
      'Es el planeta más cercano al Sol.',
      'Es el planeta más pequeño del Sistema Solar.',
      'Un año en Mercurio dura solo 88 días terrestres.',
      ],
      'videoUrl': 'https://www.youtube.com/watch?v=d6pNPnxp6PY',
      'videoThumbnail': 'assets/imagenes/pantalla_mercurio.png',
      'color': Color(0xFF9E9E9E),
      }, 
    {
      'name': 'Venus',
      'subtitle': 'El planeta más caliente',
      'icon': '♀',
      'color': Color(0xFFFFB74D),
    },
    {
      'name': 'Tierra',
      'subtitle': 'Nuestro hogar en el universo',
      'icon': '🌎',
      'color': Color(0xFF42A5F5),
    },
    {
      'name': 'Marte',
      'subtitle': 'El planeta rojo',
      'icon': '🔴',
      'color': Color(0xFFEF5350),
    },
    {
      'name': 'Júpiter',
      'subtitle': 'El planeta más grande',
      'icon': '🟠',
      'color': Color(0xFFFFA726),
    },
    {
      'name': 'Saturno',
      'subtitle': 'El planeta de los anillos',
      'icon': '🪐',
      'color': Color(0xFFFFD54F),
    },
    {
      'name': 'Urano',
      'subtitle': 'Un gigante de hielo',
      'icon': '🔵',
      'color': Color(0xFF4DD0E1),
    },
    {
      'name': 'Neptuno',
      'subtitle': 'El planeta más lejano',
      'icon': '🔵',
      'color': Color(0xFF5C6BC0),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E14),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Los Planetas',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF0F2B5C),
                    Color(0xFF15509E),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Conoce los planetas 🪐',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Aprende sobre sus características, curiosidades y secretos.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Explora cada planeta',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 7),

            const Text(
              'Selecciona un planeta para comenzar a aprender.',
              style: TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 18),

            ...planets.map(
              (planet) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _PlanetCard(
                  name: planet['name'],
                  subtitle: planet['subtitle'],
                  icon: planet['icon'],
                  color: planet['color'],
                  onTap: () { 
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => LearnPlanetDetailScreen(
                  planet: planet,
                ),
              ),
            );
          },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanetCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final String icon;
  final Color color;
  final VoidCallback onTap;

  const _PlanetCard({
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: const Color(0xFF131B29),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF1E293B),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(17),
              ),
              child: Center(
                child: Text(
                  icon,
                  style: const TextStyle(
                    fontSize: 31,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 12,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xFF42A5F5),
                size: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}