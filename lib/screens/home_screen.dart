import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // =========================
  // PALETA COSMUS (DARK MODE)
  // =========================

  static const Color cosmicBlue = Color(0xFF2196F3);
  static const Color spaceBlue = Color(0xFF1E88E5);
  static const Color cosmicPurple = Color(0xFFAB47BC);
  static const Color skyBlue = Color(0xFF29B6F6);
  static const Color solarYellow = Color(0xFFFFA726);

  static const Color background = Color(0xFF0B0E14);
  static const Color textDark = Colors.white;
  static const Color textGray = Color(0xFF94A3B8);

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
        break;

      case 1:
        // Favoritos
        Navigator.pushNamed(context, '/solar-system');
        break;

      case 2:
        // Explorar
        Navigator.pushNamed(context, '/solar-system');
        break;

      case 3:
        // Quiz (Se envía el argumento del planeta por defecto)
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
    return Scaffold(
      backgroundColor: background,

      // =====================================
      // APP BAR
      // =====================================
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(Icons.menu_rounded, color: textDark, size: 27),
          onPressed: () {},
        ),

        title: const Text(
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
                decoration: const BoxDecoration(
                  color: Color(0xFF1E293B),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_rounded,
                  color: Colors.white,
                  size: 22,
                ),
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0F2B5C), Color(0xFF15509E)],
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
            const Text(
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
                  title: 'Planetas',
                  subtitle: 'Explorar',
                  icon: Icons.public_rounded,
                  color: const Color(0xFF1E3A5F),
                  iconColor: const Color(0xFF42A5F5),
                  onTap: () {
                    Navigator.pushNamed(context, '/solar-system');
                  },
                ),

                _buildCategoryCard(
                  title: 'Quiz',
                  subtitle: 'Pon a prueba lo aprendi...',
                  icon: Icons.psychology_rounded,
                  color: const Color(0xFF2D234A),
                  iconColor: const Color(0xFFAB47BC),
                  onTap: () {
                    // Se envía el argumento del planeta por defecto
                    Navigator.pushNamed(context, '/quiz', arguments: 'Tierra');
                  },
                ),

                _buildCategoryCard(
                  title: 'Aprender',
                  subtitle: 'Contenido educativo',
                  icon: Icons.menu_book_rounded,
                  color: const Color(0xFF183B4E),
                  iconColor: const Color(0xFF29B6F6),
                  onTap: () {
                    Navigator.pushNamed(context, '/solar-system');
                  },
                ),

                _buildCategoryCard(
                  title: 'Progreso',
                  subtitle: 'Mira tus avances',
                  icon: Icons.emoji_events_rounded,
                  color: const Color(0xFF3E3218),
                  iconColor: const Color(0xFFFFA726),
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
                const Text(
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
                  child: const Text(
                    'Ver todo',
                    style: TextStyle(
                      color: Color(0xFF42A5F5),
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
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF131B29),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF1E293B)),
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
                          const Text(
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
                            style: const TextStyle(
                              fontSize: 12,
                              color: textGray,
                            ),
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
                        color: const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                        color: Color(0xFF42A5F5),
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
      // BARRA INFERIOR ESTILO REFERENCIA
      // =====================================
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // =====================================
  // TARJETAS
  // =====================================

  Widget _buildCategoryCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF131B29),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF1E293B)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
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
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: textDark,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 11, color: textGray),
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

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 82,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        border: const Border(top: BorderSide(color: Color(0xFF1E293B))),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(index: 0, icon: Icons.home_rounded, label: 'Inicio'),

          _buildNavItem(index: 1, icon: Icons.favorite_rounded, label: ''),

          _buildNavItem(index: 2, icon: Icons.public_rounded, label: ''),

          _buildNavItem(index: 3, icon: Icons.psychology_rounded, label: ''),

          _buildNavItem(index: 4, icon: Icons.person_rounded, label: ''),
        ],
      ),
    );
  }

  // =====================================
  // ITEM DE NAVEGACIÓN
  // =====================================

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final bool selected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(
          horizontal: selected ? 16 : 12,
          vertical: 9,
        ),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF1E3A5F) : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 27,
              color: selected
                  ? const Color(0xFF42A5F5)
                  : const Color(0xFF64748B),
            ),

            if (selected && label.isNotEmpty) ...[
              const SizedBox(width: 7),

              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF42A5F5),
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
