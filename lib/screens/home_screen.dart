import 'package:flutter/material.dart';
// Asegúrate de importar main.dart para poder acceder y modificar el themeNotifier global
import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // =====================================
  // PALETAS DE COLOR DINÁMICAS
  // =====================================
  static const Color solarYellow = Color(0xFFFFA726);

  final Map<String, dynamic> featuredPlanet = {
    'name': 'El Sol',
    'emoji': '☀️',
    'color': solarYellow,
    'description':
        'La estrella de nuestro Sistema Solar que da vida al vecindario cósmico.',
  };

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Inicio (Pantalla actual)
        break;

      case 1:
        // Explorar
        Navigator.pushNamed(context, '/solar-system');
        break;

      case 2:
        // Aprender
        Navigator.pushNamed(context, '/learn');
        break;

      case 3:
        // Quiz
        Navigator.pushNamed(context, '/quiz', arguments: 'Tierra');
        break;

      case 4:
        // Perfil
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Escuchamos el valor global de tema con ValueListenableBuilder o leyendo directamente
    final bool isDarkMode = themeNotifier.value == ThemeMode.dark;

    // Definición de colores adaptables al tema global
    final Color bgColor = isDarkMode
        ? const Color(0xFF0B0E14)
        : const Color(0xFFF1F5F9);
    final Color textDark = isDarkMode ? Colors.white : const Color(0xFF0F172A);
    final Color textGray = isDarkMode
        ? const Color(0xFF94A3B8)
        : const Color(0xFF64748B);
    final Color cardBgColor = isDarkMode
        ? const Color(0xFF131B29)
        : Colors.white;
    final Color cardBorderColor = isDarkMode
        ? const Color(0xFF1E293B)
        : const Color(0xFFE2E8F0);
    final Color bottomNavBg = isDarkMode
        ? const Color(0xFF0F172A)
        : Colors.white;
    final Color primaryAccent = isDarkMode
        ? const Color(0xFF42A5F5)
        : const Color(0xFF1E88E5);

    return Scaffold(
      backgroundColor: bgColor,

      // =====================================
      // APP BAR CON ACCESO AL PERFIL
      // =====================================
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu_rounded, color: textDark, size: 27),
          onPressed: () {},
        ),
        title: Text(
          'COSMUS',
          style: TextStyle(
            color: textDark,
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color(0xFF1E293B)
                      : const Color(0xFFE2E8F0),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person_rounded, color: textDark, size: 22),
              ),
            ),
          ),
        ],
      ),

      // =====================================
      // BODY
      // =====================================
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =====================================
            // BANNER
            // =====================================
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
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Explora nuestro\nvecindario cósmico',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/solar-system');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF0F2B5C),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 11,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Explorar',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 7),
                              Icon(Icons.arrow_forward_rounded, size: 17),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text('🪐', style: TextStyle(fontSize: 65)),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // =====================================
            // TÍTULO
            // =====================================
            Text(
              '¿Qué quieres aprender?',
              style: TextStyle(
                color: textDark,
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 15),

            // =====================================
            // CATEGORÍAS
            // =====================================
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 1.12,
              children: [
                _buildCategoryCard(
                  isDarkMode: isDarkMode,
                  title: 'Planetas',
                  subtitle: 'Explorar',
                  icon: Icons.public_rounded,
                  color: isDarkMode
                      ? const Color(0xFF1E3A5F)
                      : const Color(0xFFE3F2FD),
                  iconColor: const Color(0xFF42A5F5),
                  cardBgColor: cardBgColor,
                  cardBorderColor: cardBorderColor,
                  textDark: textDark,
                  textGray: textGray,
                  onTap: () {
                    Navigator.pushNamed(context, '/solar-system');
                  },
                ),
                _buildCategoryCard(
                  isDarkMode: isDarkMode,
                  title: 'Quiz',
                  subtitle: 'Pon a prueba lo aprendi...',
                  icon: Icons.psychology_rounded,
                  color: isDarkMode
                      ? const Color(0xFF2D234A)
                      : const Color(0xFFF3E5F5),
                  iconColor: const Color(0xFFAB47BC),
                  cardBgColor: cardBgColor,
                  cardBorderColor: cardBorderColor,
                  textDark: textDark,
                  textGray: textGray,
                  onTap: () {
                    Navigator.pushNamed(context, '/quiz', arguments: 'Tierra');
                  },
                ),
                _buildCategoryCard(
                  isDarkMode: isDarkMode,
                  title: 'Aprender',
                  subtitle: 'Contenido educativo',
                  icon: Icons.menu_book_rounded,
                  color: isDarkMode
                      ? const Color(0xFF183B4E)
                      : const Color(0xFFE0F7FA),
                  iconColor: const Color(0xFF29B6F6),
                  cardBgColor: cardBgColor,
                  cardBorderColor: cardBorderColor,
                  textDark: textDark,
                  textGray: textGray,
                  onTap: () {
                    Navigator.pushNamed(context, '/learn');
                  },
                ),
                _buildCategoryCard(
                  isDarkMode: isDarkMode,
                  title: 'Progreso',
                  subtitle: 'Mira tus avances',
                  icon: Icons.emoji_events_rounded,
                  color: isDarkMode
                      ? const Color(0xFF3E3218)
                      : const Color(0xFFFFF3E0),
                  iconColor: const Color(0xFFFFA726),
                  cardBgColor: cardBgColor,
                  cardBorderColor: cardBorderColor,
                  textDark: textDark,
                  textGray: textGray,
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
              ],
            ),

            const SizedBox(height: 28),

            // =====================================
            // DESCUBRE EL ESPACIO
            // =====================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Descubre el espacio ✨',
                  style: TextStyle(
                    color: textDark,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/solar-system');
                  },
                  child: Text(
                    'Ver todo',
                    style: TextStyle(
                      color: primaryAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // =====================================
            // TARJETA DEL SOL
            // =====================================
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/planet',
                  arguments: featuredPlanet,
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: cardBgColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: cardBorderColor),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 62,
                      height: 62,
                      decoration: BoxDecoration(
                        color: solarYellow.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text('☀️', style: TextStyle(fontSize: 30)),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'El Sol',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            featuredPlanet['description'],
                            style: TextStyle(fontSize: 12, color: textGray),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? const Color(0xFF1E293B)
                            : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                        color: primaryAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),

      // =====================================
      // BARRA INFERIOR
      // =====================================
      bottomNavigationBar: _buildBottomNavigationBar(
        isDarkMode: isDarkMode,
        bottomNavBg: bottomNavBg,
        cardBorderColor: cardBorderColor,
        primaryAccent: primaryAccent,
      ),
    );
  }

  // =====================================
  // TARJETAS DE CATEGORÍA
  // =====================================

  Widget _buildCategoryCard({
    required bool isDarkMode,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color iconColor,
    required Color cardBgColor,
    required Color cardBorderColor,
    required Color textDark,
    required Color textGray,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: cardBorderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDarkMode ? 0.2 : 0.05),
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: iconColor, size: 25),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 11, color: textGray),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =====================================
  // BOTTOM NAVIGATION
  // =====================================

  Widget _buildBottomNavigationBar({
    required bool isDarkMode,
    required Color bottomNavBg,
    required Color cardBorderColor,
    required Color primaryAccent,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 82,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: bottomNavBg,
        border: Border(top: BorderSide(color: cardBorderColor)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDarkMode ? 0.3 : 0.08),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            isDarkMode: isDarkMode,
            index: 0,
            icon: Icons.home_rounded,
            label: 'Inicio',
            primaryAccent: primaryAccent,
          ),
          _buildNavItem(
            isDarkMode: isDarkMode,
            index: 1,
            icon: Icons.public_rounded,
            label: 'Explorar',
            primaryAccent: primaryAccent,
          ),
          _buildNavItem(
            isDarkMode: isDarkMode,
            index: 2,
            icon: Icons.menu_book_rounded,
            label: 'Aprender',
            primaryAccent: primaryAccent,
          ),
          _buildNavItem(
            isDarkMode: isDarkMode,
            index: 3,
            icon: Icons.psychology_rounded,
            label: 'Quiz',
            primaryAccent: primaryAccent,
          ),
          _buildNavItem(
            isDarkMode: isDarkMode,
            index: 4,
            icon: Icons.person_rounded,
            label: 'Perfil',
            primaryAccent: primaryAccent,
          ),
        ],
      ),
    );
  }

  // =====================================
  // ITEM DE NAVEGACIÓN (TEXTO E ICONO SIEMPRE VISIBLES)
  // =====================================

  Widget _buildNavItem({
    required bool isDarkMode,
    required int index,
    required IconData icon,
    required String label,
    required Color primaryAccent,
  }) {
    final bool selected = _selectedIndex == index;

    // Colores condicionales para elemento seleccionado vs no seleccionado
    final Color itemColor = selected
        ? primaryAccent
        : (isDarkMode ? const Color(0xFF64748B) : const Color(0xFF94A3B8));

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? (isDarkMode ? const Color(0xFF1E3A5F) : const Color(0xFFE3F2FD))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 23, color: itemColor),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: itemColor,
                fontSize: 10.5,
                fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
