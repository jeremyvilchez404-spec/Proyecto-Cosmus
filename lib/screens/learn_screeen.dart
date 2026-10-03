import 'package:flutter/material.dart';
// Asegúrate de importar main.dart para acceder al themeNotifier global
import '../main.dart';

import '../widgets/learn_card.dart';
import 'learn_planets_screen.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Envolvemos con ValueListenableBuilder para escuchar cambios en el tema global
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentTheme, child) {
        final bool isDarkMode = currentTheme == ThemeMode.dark;

        // Definición de colores dinámicos según el modo global
        final Color bgColor = isDarkMode
            ? const Color(0xFF0B0E14)
            : const Color(0xFFF1F5F9);
        final Color textDark = isDarkMode
            ? Colors.white
            : const Color(0xFF0F172A);
        final Color textGray = isDarkMode
            ? const Color(0xFF94A3B8)
            : const Color(0xFF64748B);

        return Scaffold(
          backgroundColor: bgColor,

          // =========================================
          // APP BAR
          // =========================================
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: textDark),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Aprender',
              style: TextStyle(
                color: textDark,
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
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDarkMode
                          ? [const Color(0xFF0F2B5C), const Color(0xFF15509E)]
                          : [const Color(0xFF1E88E5), const Color(0xFF42A5F5)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF15509E).withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 7),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                      SizedBox(width: 10),
                      Text('🔭', style: TextStyle(fontSize: 45)),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // =========================================
                // TÍTULO
                // =========================================
                Text(
                  'Temas para aprender',
                  style: TextStyle(
                    color: textDark,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  'Selecciona un tema para comenzar a explorar.',
                  style: TextStyle(color: textGray, fontSize: 13),
                ),

                const SizedBox(height: 18),

                // =========================================
                // SISTEMA SOLAR
                // =========================================
                LearnCard(
                  title: 'Sistema Solar',
                  description:
                      'Conoce el Sol, los planetas y los cuerpos que forman nuestro vecindario cósmico.',
                  icon: ClipOval(
                    child: Image.asset(
                      'assets/imagenes/icono_sol.png',
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/solar-system');
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
                  icon: ClipOval(
                    child: Image.asset(
                      'assets/imagenes/icono_tierra.png',
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                    ),
                  ),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
