import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;
  bool _rememberMe = false;

  // Variable de estado para alternar entre Modo Oscuro y Modo Claro
  bool _isDarkMode = true;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );
    _animationController.forward();
  }

  // Guardar estado de sesión persistente
  Future<void> _guardarSesion({required bool esInvitado}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setBool('isGuest', esInvitado);
  }

  Future<void> _iniciarSesion() async {
    const usuarioCorrecto = 'admin';
    const contrasenaCorrecta = '1234';

    final usuario = _emailController.text.trim();
    final contrasena = _passwordController.text;

    if (usuario.isEmpty || contrasena.isEmpty) {
      _showCustomSnackBar(
        'Por favor, completa todos los campos',
        isError: true,
      );
      return;
    }

    if (usuario == usuarioCorrecto && contrasena == contrasenaCorrecta) {
      await _guardarSesion(esInvitado: false);

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      _showCustomSnackBar('Usuario o contraseña incorrectos', isError: true);
    }
  }

  // Redirección y persistencia de sesión al entrar como invitado
  Future<void> _entrarComoInvitado() async {
    await _guardarSesion(esInvitado: true);

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  void _showCustomSnackBar(String message, {bool isError = false}) {
    final snackBarBg = isError
        ? const Color(0xFFFF2A85)
        : (_isDarkMode ? const Color(0xFF00D2FF) : const Color(0xFF6C5CE7));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: snackBarBg,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: snackBarBg.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                isError
                    ? Icons.error_outline_rounded
                    : Icons.check_circle_outline_rounded,
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bgGradientColors = _isDarkMode
        ? [
            const Color(0xFF1B0B3B),
            const Color(0xFF0D0628),
            const Color(0xFF050212),
          ]
        : [
            const Color(0xFFE2F1FF),
            const Color(0xFFEAE5FF),
            const Color(0xFFFCE4EC),
          ];

    final cardBgColor = _isDarkMode
        ? const Color(0xFF0E0728).withOpacity(0.85)
        : Colors.white.withOpacity(0.92);

    final cardBorderColor = _isDarkMode
        ? const Color(0xFF00D2FF).withOpacity(0.35)
        : const Color(0xFF6C5CE7).withOpacity(0.35);

    final primaryAccent = _isDarkMode
        ? const Color(0xFF00D2FF)
        : const Color(0xFF6C5CE7);

    final textPrimary = _isDarkMode ? Colors.white : const Color(0xFF1E1B4B);
    final textSecondary = _isDarkMode
        ? Colors.white60
        : const Color(0xFF5B5891);

    final inputBgColor = _isDarkMode
        ? const Color(0xFF140A34)
        : const Color(0xFFF1F3F9);

    final inputBorderColor = _isDarkMode
        ? const Color(0xFF2E1A66)
        : const Color(0xFFD1D5DB);

    final buttonGradient = _isDarkMode
        ? [
            const Color(0xFFFF2A85),
            const Color(0xFF8B129B),
            const Color(0xFF00D2FF),
          ]
        : [const Color(0xFF6C5CE7), const Color(0xFFFF2A85)];

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -0.2),
            radius: 1.2,
            colors: bgGradientColors,
          ),
        ),
        child: Stack(
          children: [
            // 1. Estrellas de fondo
            Positioned.fill(
              child: CustomPaint(
                painter: SpaceStarsPainter(isDarkMode: _isDarkMode),
              ),
            ),

            // 2. Contenido del Formulario
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22.0,
                    vertical: 20.0,
                  ),
                  child: ScaleTransition(
                    scale: _fadeAnimation,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      decoration: BoxDecoration(
                        color: cardBgColor,
                        borderRadius: BorderRadius.circular(32.0),
                        border: Border.all(color: cardBorderColor, width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: primaryAccent.withOpacity(0.2),
                            blurRadius: 35,
                            spreadRadius: 2,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 25,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 26.0,
                          vertical: 32.0,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Logo
                            Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFFFF2A85,
                                    ).withOpacity(0.35),
                                    blurRadius: 25,
                                    spreadRadius: 2,
                                  ),
                                  BoxShadow(
                                    color: primaryAccent.withOpacity(0.25),
                                    blurRadius: 35,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: inputBgColor,
                                      child: Icon(
                                        Icons.public,
                                        size: 70,
                                        color: primaryAccent,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Título
                            ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [
                                  primaryAccent,
                                  const Color(0xFFFF2A85),
                                ],
                              ).createShader(bounds),
                              child: const Text(
                                'COSMUS',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: 3.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Aprende y visualiza',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: primaryAccent,
                                letterSpacing: 2.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 28),

                            // Campos de Entrada
                            _buildTextField(
                              controller: _emailController,
                              hintText: 'Usuario o correo',
                              icon: Icons.person_outline_rounded,
                              bgColor: inputBgColor,
                              borderColor: inputBorderColor,
                              accentColor: primaryAccent,
                              textColor: textPrimary,
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              controller: _passwordController,
                              hintText: 'Contraseña',
                              icon: Icons.lock_outline_rounded,
                              isPassword: true,
                              obscureText: _obscureText,
                              bgColor: inputBgColor,
                              borderColor: inputBorderColor,
                              accentColor: primaryAccent,
                              textColor: textPrimary,
                              onToggleVisibility: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            const SizedBox(height: 14),

                            // Recordarme / Olvidé contraseña
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _rememberMe = !_rememberMe;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 200,
                                        ),
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          color: _rememberMe
                                              ? const Color(0xFFFF2A85)
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                          border: Border.all(
                                            color: _rememberMe
                                                ? const Color(0xFFFF2A85)
                                                : textSecondary.withOpacity(
                                                    0.5,
                                                  ),
                                            width: 1.8,
                                          ),
                                        ),
                                        child: _rememberMe
                                            ? const Icon(
                                                Icons.check,
                                                size: 14,
                                                color: Colors.white,
                                              )
                                            : null,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Recordarme',
                                        style: TextStyle(
                                          color: textSecondary,
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    '¿Olvidaste tu contraseña?',
                                    style: TextStyle(
                                      color: primaryAccent,
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 26),

                            // Botón de Ingresar
                            Container(
                              width: double.infinity,
                              height: 52,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(
                                  colors: buttonGradient,
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryAccent.withOpacity(0.35),
                                    blurRadius: 18,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: _iniciarSesion,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'INGRESAR',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Botón para ingresar como invitado
                            GestureDetector(
                              onTap: _entrarComoInvitado,
                              child: Text(
                                'Entrar como invitado',
                                style: TextStyle(
                                  color: primaryAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.5,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 3. Botón Flotante para cambiar Tema
            Positioned(
              top: 45,
              right: 20,
              child: SafeArea(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isDarkMode = !_isDarkMode;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: _isDarkMode
                          ? const Color(0xFF140A34)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: cardBorderColor, width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: primaryAccent.withOpacity(0.3),
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _isDarkMode
                              ? Icons.wb_sunny_rounded
                              : Icons.nightlight_round,
                          color: _isDarkMode
                              ? const Color(0xFFFFD700)
                              : const Color(0xFF6C5CE7),
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _isDarkMode ? 'Modo Claro' : 'Modo Oscuro',
                          style: TextStyle(
                            color: textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required Color bgColor,
    required Color borderColor,
    required Color accentColor,
    required Color textColor,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: borderColor, width: 1.2),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color: textColor, fontSize: 14.5),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: textColor.withOpacity(0.4), fontSize: 14),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 18, right: 12),
            child: Icon(icon, color: accentColor, size: 21),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 50),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: textColor.withOpacity(0.5),
                    size: 20,
                  ),
                  onPressed: onToggleVisibility,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}

class SpaceStarsPainter extends CustomPainter {
  final bool isDarkMode;

  SpaceStarsPainter({required this.isDarkMode});

  @override
  void paint(Canvas canvas, Size size) {
    final rand = math.Random(42);

    for (int i = 0; i < 80; i++) {
      final x = rand.nextDouble() * size.width;
      final y = rand.nextDouble() * size.height;
      final radius = rand.nextDouble() * 1.6 + 0.4;

      final colorChoice = rand.nextInt(3);
      Color starColor = isDarkMode ? Colors.white : const Color(0xFF6C5CE7);
      if (colorChoice == 1) starColor = const Color(0xFF00D2FF);
      if (colorChoice == 2) starColor = const Color(0xFFFF2A85);

      final paint = Paint()
        ..color = starColor.withOpacity(rand.nextDouble() * 0.5 + 0.2);
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant SpaceStarsPainter oldDelegate) =>
      oldDelegate.isDarkMode != isDarkMode;
}
