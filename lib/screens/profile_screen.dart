
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../services/quiz_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isGuest = false;
  bool isLoadingProfile = true;

  int? userId;
  int quizCount = 0;

  String userName = 'Explorador Espacial';
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    themeNotifier.addListener(_onThemeChanged);
    _cargarDatosUsuario();
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

  // =====================================================
  // CARGAR DATOS DEL USUARIO Y ESTADÍSTICAS
  // =====================================================

  Future<void> _cargarDatosUsuario() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final guest = prefs.getBool('isGuest') ?? false;
      final savedUserId = prefs.getInt('userId');

      String name = guest
          ? 'Invitado Cósmico'
          : (prefs.getString('userName') ?? 'Explorador Espacial');

      String email = prefs.getString('userEmail') ?? '';
      int count = 0;

      if (!guest && savedUserId != null) {
        final user = await QuizService.instance.getUserById(
          savedUserId,
        );

        if (user != null) {
          name = user['nombre'] as String;
          email = user['correo'] as String;

          count = await QuizService.instance.getQuizCount(
            savedUserId,
          );
        }
      }

      if (!mounted) return;

      setState(() {
        isGuest = guest;
        userId = savedUserId;
        userName = name;
        userEmail = email;
        quizCount = count;
        isLoadingProfile = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoadingProfile = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No se pudieron cargar los datos del perfil.',
          ),
        ),
      );
    }
  }

  // =====================================================
  // CERRAR SESIÓN SIN BORRAR LAS PREFERENCIAS
  // =====================================================

  Future<void> _cerrarSesion() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('isLoggedIn');
    await prefs.remove('isGuest');
    await prefs.remove('userId');
    await prefs.remove('userName');
    await prefs.remove('userEmail');

    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = themeNotifier.value == ThemeMode.dark;

    final Color bgColor = isDarkMode
        ? const Color(0xFF040B1E)
        : const Color(0xFFF1F5F9);

    final Color cardBg = isDarkMode
        ? const Color(0xFF0B193D)
        : Colors.white;

    final Color textPrimary = isDarkMode
        ? Colors.white
        : const Color(0xFF0F172A);

    final Color textSecondary = isDarkMode
        ? Colors.white60
        : const Color(0xFF64748B);

    final Color cardBorder = isDarkMode
        ? const Color(0xFF1B3266)
        : const Color(0xFFE2E8F0);

    final Color primaryAccent = isDarkMode
        ? const Color(0xFF61DAFB)
        : const Color(0xFF1E88E5);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        foregroundColor: textPrimary,
        title: const Text(
          'Mi Perfil',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: isLoadingProfile
          ? Center(
              child: CircularProgressIndicator(
                color: primaryAccent,
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Column(
                children: [
                  // ==========================================
                  // INFORMACIÓN DEL USUARIO
                  // ==========================================

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: cardBorder),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: const Color(
                            0xFFE83E8C,
                          ).withOpacity(0.2),
                          child: const Text(
                            '👨‍🚀',
                            style: TextStyle(fontSize: 45),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          userName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: textPrimary,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (userEmail.isNotEmpty) ...[
                          const SizedBox(height: 5),
                          Text(
                            userEmail,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: textSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ],
                        const SizedBox(height: 6),
                        Text(
                          isGuest
                              ? 'Modo de exploración'
                              : 'Explorador Espacial',
                          style: TextStyle(
                            color: textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ==========================================
                  // ESTADÍSTICAS REALES
                  // ==========================================

                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          title: 'Estado',
                          value: isGuest ? 'Invitado' : 'Registrado',
                          icon: Icons.person_rounded,
                          iconColor: const Color(0xFFFFD166),
                          cardBg: cardBg,
                          cardBorder: cardBorder,
                          textPrimary: textPrimary,
                          textSecondary: textSecondary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          title: 'Quizzes',
                          value: '$quizCount Hechos',
                          icon: Icons.psychology_rounded,
                          iconColor: const Color(0xFFE83E8C),
                          cardBg: cardBg,
                          cardBorder: cardBorder,
                          textPrimary: textPrimary,
                          textSecondary: textSecondary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // ==========================================
                  // OPCIONES Y AJUSTES
                  // ==========================================

                  Container(
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: cardBorder),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.palette_outlined,
                            color: primaryAccent,
                          ),
                          title: Text(
                            'Modo Oscuro',
                            style: TextStyle(color: textPrimary),
                          ),
                          trailing: Switch(
                            value: isDarkMode,
                            activeColor: const Color(0xFFE83E8C),
                            onChanged: (value) async {
                              themeNotifier.value = value
                                  ? ThemeMode.dark
                                  : ThemeMode.light;

                              final prefs =
                                  await SharedPreferences.getInstance();

                              await prefs.setBool(
                                'isDarkMode',
                                value,
                              );
                            },
                          ),
                        ),

                        Divider(color: cardBorder, height: 1),

                        ListTile(
                          leading: const Icon(
                            Icons.info_outline,
                            color: Color(0xFF49D49D),
                          ),
                          title: Text(
                            'Acerca de COSMUS',
                            style: TextStyle(color: textPrimary),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: textSecondary,
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ==========================================
                  // CERRAR SESIÓN
                  // ==========================================

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: _cerrarSesion,
                      icon: const Icon(Icons.logout_rounded),
                      label: const Text(
                        'CERRAR SESIÓN',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                          0xFFFF2A85,
                        ).withOpacity(0.15),
                        foregroundColor: const Color(0xFFFF2A85),
                        elevation: 0,
                        side: const BorderSide(
                          color: Color(0xFFFF2A85),
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // =====================================================
  // TARJETA REUTILIZABLE DE ESTADÍSTICAS
  // =====================================================

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    required Color cardBg,
    required Color cardBorder,
    required Color textPrimary,
    required Color textSecondary,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              color: textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
