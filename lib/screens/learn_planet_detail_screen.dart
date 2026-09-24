import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LearnPlanetDetailScreen extends StatelessWidget {
  final Map<String, dynamic> planet;

  const LearnPlanetDetailScreen({
    super.key,
    required this.planet,
  });

  @override
  Widget build(BuildContext context) {
    final String name = planet['name'] ?? 'Planeta';
    final String image = planet['image'] ?? '';
    final String subtitle = planet['subtitle'] ?? '';
    final String description = planet['description'] ?? '';
    final String distance = planet['distance'] ?? 'No disponible';
    final String day = planet['day'] ?? 'No disponible';
    final String year = planet['year'] ?? 'No disponible';
    final String moons = planet['moons'] ?? 'No disponible';

    final List<String> curiosities =
        List<String>.from(planet['curiosities'] ?? []);

    final Color color =
        planet['color'] ?? const Color(0xFF42A5F5);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0E14),

      // =========================================================
      // APP BAR
      // =========================================================

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

        title: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),

        centerTitle: true,
      ),

      // =========================================================
      // CONTENIDO
      // =========================================================

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 35),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // =====================================================
            // IMAGEN DEL PLANETA
            // =====================================================

            Container(
              width: double.infinity,
              height: 280,

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withOpacity(0.25),
                    const Color(0xFF111827),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),

                borderRadius: BorderRadius.circular(28),

                border: Border.all(
                  color: color.withOpacity(0.25),
                ),
              ),

              child: Center(
                child: Image.asset(
                  image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,

                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.public,
                      size: 100,
                      color: color,
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 24),

            // =====================================================
            // NOMBRE
            // =====================================================

            Text(
              name,
              style: TextStyle(
                color: color,
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              subtitle,
              style: const TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 25),

            // =====================================================
            // INFORMACIÓN
            // =====================================================

            _SectionTitle(
              icon: Icons.menu_book_rounded,
              title: '¿Qué es $name?',
              color: color,
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: const Color(0xFF131B29),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF1E293B),
                ),
              ),

              child: Text(
                description,
                style: const TextStyle(
                  color: Color(0xFFD1D5DB),
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
            ),

            const SizedBox(height: 28),

            // =====================================================
            // DATOS PRINCIPALES
            // =====================================================

            _SectionTitle(
              icon: Icons.analytics_rounded,
              title: 'Datos principales',
              color: color,
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: const Color(0xFF131B29),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF1E293B),
                ),
              ),

              child: Column(
                children: [

                  _InfoRow(
                    icon: Icons.public,
                    title: 'Distancia al Sol',
                    value: distance,
                    color: color,
                  ),

                  _InfoRow(
                    icon: Icons.access_time_rounded,
                    title: 'Duración del día',
                    value: day,
                    color: color,
                  ),

                  _InfoRow(
                    icon: Icons.calendar_month_rounded,
                    title: 'Duración del año',
                    value: year,
                    color: color,
                  ),

                  _InfoRow(
                    icon: Icons.nightlight_round,
                    title: 'Número de lunas',
                    value: moons,
                    color: color,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // =====================================================
            // CURIOSIDADES
            // =====================================================

            _SectionTitle(
              icon: Icons.lightbulb_rounded,
              title: 'Curiosidades',
              color: color,
            ),

            const SizedBox(height: 12),

            ...curiosities.map(
              (curiosity) => Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: const Color(0xFF131B29),
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(
                    color: const Color(0xFF1E293B),
                  ),
                ),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Icon(
                      Icons.auto_awesome,
                      color: color,
                      size: 20,
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        curiosity,
                        style: const TextStyle(
                          color: Color(0xFFD1D5DB),
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            // =====================================================
// VIDEO EDUCATIVO
// =====================================================

_SectionTitle(
  icon: Icons.play_circle_fill_rounded,
  title: 'Aprende con un video',
  color: color,
),

const SizedBox(height: 12),

GestureDetector(
  onTap: () async {
    final String videoUrl = planet['videoUrl'] ?? '';

    if (videoUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Video próximamente disponible.',
          ),
        ),
      );
      return;
    }

    final Uri url = Uri.parse(videoUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  },

  child: Container(
    width: double.infinity,
    height: 200,

    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),

      border: Border.all(
        color: color.withOpacity(0.25),
      ),

      image: DecorationImage(
        image: AssetImage(
          planet['videoThumbnail'] ??
              'assets/planetas/cosmos.png',
        ),
        fit: BoxFit.fill,
      ),
    ),

    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withOpacity(0.35),
      ),

      child: Center(
        child: Container(
          width: 64,
          height: 64,

          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),

          child: const Icon(
            Icons.play_arrow_rounded,
            color: Colors.white,
            size: 38,
          ),
        ),
      ),
    ),
  ),
),

const SizedBox(height: 10),

const Text(
  'Toca la imagen para ver el video en YouTube',
  style: TextStyle(
    color: Color(0xFF94A3B8),
    fontSize: 12,
  ),
),

            const SizedBox(height: 28),

            // =====================================================
            // AUDIO
            // =====================================================

            _SectionTitle(
              icon: Icons.volume_up_rounded,
              title: 'Escucha y aprende',
              color: color,
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

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
                    width: 52,
                    height: 52,

                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),

                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: color,
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 15),

                  const Expanded(
                    child: Text(
                      'Escuchar información del planeta',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  Icon(
                    Icons.graphic_eq_rounded,
                    color: color,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================
// TÍTULO DE SECCIÓN
// =============================================================

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const _SectionTitle({
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Icon(
          icon,
          color: color,
          size: 22,
        ),

        const SizedBox(width: 9),

        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

// =============================================================
// FILA DE INFORMACIÓN
// =============================================================

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),

      child: Row(
        children: [

          Icon(
            icon,
            color: color,
            size: 20,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 13,
              ),
            ),
          ),

          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}