import 'package:flutter/material.dart';

import '../widgets/learn_card.dart';
import 'learn_planets_screen.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E14),

      // =========================================
      // APP BAR
      // =========================================

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
          'Aprender',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),

        centerTitle: true,
      ),

      // =========================================
      // CONTENIDO
      // =========================================

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // =========================================
            // BANNER
            // =========================================

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

              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [

                        Text(
                          'Descubre el universo 🌌',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        SizedBox(height: 8),

                        Text(
                          'Aprende de forma sencilla sobre el espacio y sus misterios.',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 10),

                  const Text(
                    '🔭',
                    style: TextStyle(
                      fontSize: 45,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // =========================================
            // TÍTULO
            // =========================================

            const Text(
              'Temas para aprender',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 7),

            const Text(
              'Selecciona un tema para comenzar a explorar.',
              style: TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 18),

            // =========================================
            // SISTEMA SOLAR
            // =========================================

            LearnCard(
              title: 'Sistema Solar',
              description:
                  'Conoce el Sol, los planetas y los cuerpos que forman nuestro vecindario cósmico.',
              icon: Icons.public_rounded,
              iconColor: const Color(0xFF42A5F5),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/solar-system',
                );
              },
            ),

            const SizedBox(height: 14),

            // =========================================
            // PLANETAS
            // =========================================

          LearnCard(
  title: 'Los Planetas',
  description:
      'Descubre las características, tamaños y curiosidades de cada planeta.',
  icon: Icons.language_rounded,
  iconColor: const Color(0xFFAB47BC),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LearnPlanetsScreen(),
      ),
    );
  },
),

            const SizedBox(height: 14),

            // =========================================
            // LA LUNA
            // =========================================

            LearnCard(
              title: 'La Luna',
              description:
                  'Aprende sobre nuestro satélite natural, sus fases y sus características.',
              icon: Icons.nightlight_round,
              iconColor: const Color(0xFF90CAF9),
              onTap: () {
                _mostrarProximamente(context, 'La Luna');
              },
            ),

            const SizedBox(height: 14),

            // =========================================
            // ESTRELLAS
            // =========================================

            LearnCard(
              title: 'Las Estrellas',
              description:
                  'Conoce qué son las estrellas, cómo se forman y cómo evolucionan.',
              icon: Icons.auto_awesome_rounded,
              iconColor: const Color(0xFFFFD54F),
              onTap: () {
                _mostrarProximamente(context, 'Las Estrellas');
              },
            ),

            const SizedBox(height: 14),

            // =========================================
            // UNIVERSO
            // =========================================

            LearnCard(
              title: 'El Universo',
              description:
                  'Explora galaxias, nebulosas y otros fenómenos del universo.',
              icon: Icons.blur_on_rounded,
              iconColor: const Color(0xFF29B6F6),
              onTap: () {
                _mostrarProximamente(context, 'El Universo');
              },
            ),

            const SizedBox(height: 14),

            // =========================================
            // EXPLORACIÓN ESPACIAL
            // =========================================

            LearnCard(
              title: 'Exploración espacial',
              description:
                  'Descubre cómo la humanidad estudia y explora el espacio.',
              icon: Icons.rocket_launch_rounded,
              iconColor: const Color(0xFFFFA726),
              onTap: () {
                _mostrarProximamente(
                  context,
                  'Exploración espacial',
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // =========================================
  // MENSAJE TEMPORAL
  // =========================================

  void _mostrarProximamente(
    BuildContext context,
    String titulo,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$titulo estará disponible próximamente.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}