
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/user_service.dart';
import 'home_screen.dart';
import 'register_screen.dart';

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
  bool _isLoggingIn = false;

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

  Future<void> _guardarSesion({
    required bool esInvitado,
    Map<String, dynamic>? usuario,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLoggedIn', true);
    await prefs.setBool('isGuest', esInvitado);

    if (esInvitado) {
      await prefs.remove('userId');
      await prefs.remove('userName');
      await prefs.remove('userEmail');
    } else if (usuario != null) {
      await prefs.setInt('userId', usuario['id'] as int);
      await prefs.setString('userName', usuario['nombre'] as String);
      await prefs.setString('userEmail', usuario['correo'] as String);
    }
  }

  Future<void> _iniciarSesion() async {
    if (_isLoggingIn) return;

    final correo = _emailController.text.trim();
    final contrasena = _passwordController.text;

    if (correo.isEmpty || contrasena.isEmpty) {
      _showCustomSnackBar(
        'Por favor, completa todos los campos',
        isError: true,
      );
      return;
    }

    setState(() => _isLoggingIn = true);

    try {
      final usuario = await UserService.instance.login(
        correo: correo,
        password: contrasena,
      );

      if (!mounted) return;

      if (usuario == null) {
        _showCustomSnackBar(
          'Correo o contraseña incorrectos',
          isError: true,
        );
        return;
      }

      await _guardarSesion(
        esInvitado: false,
        usuario: usuario,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      _showCustomSnackBar(
        'No se pudo iniciar sesión. Comprueba la base de datos.',
        isError: true,
      );
    } finally {
      if (mounted) {
        setState(() => _isLoggingIn = false);
      }
    }
  }

  Future<void> _entrarComoInvitado() async {
    try {
      await _guardarSesion(esInvitado: true);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      _showCustomSnackBar(
        'No se pudo iniciar como invitado.',
        isError: true,
      );
    }
  }

  void _abrirRegistro() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      ),
    );
  }

  void _showCustomSnackBar(
    String message, {
    bool isError = false,
  }) {
    final bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark;

    final snackBarBg = isError
        ? const Color(0xFFFF2A85)
        : (isDarkMode
            ? const Color(0xFF00D2FF)
            : const Color(0xFF007ACC));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
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
    final bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark;

    final List<Color> bgGradientColors = isDarkMode
        ? const [
            Color(0xFF1B0B3B),
            Color(0xFF0D0628),
            Color(0xFF050212),
          ]
        : const [
            Color(0xFFF3EEFF),
            Color(0xFFE2D6FF),
            Color(0xFFD4C2FF),
          ];

    final cardBgColor = isDarkMode
        ? const Color(0xFF0E0728).withOpacity(0.85)
        : Colors.white.withOpacity(0.9);

    final cardBorderColor = isDarkMode
        ? const Color(0xFF00D2FF).withOpacity(0.35)
        : const Color(0xFF8B129B).withOpacity(0.2);

    final primaryAccent = isDarkMode
        ? const Color(0xFF00D2FF)
        : const Color(0xFF6C5CE7);

    final textPrimary =
        isDarkMode ? Colors.white : const Color(0xFF1B0B3B);

    final textSecondary =
        isDarkMode ? Colors.white60 : Colors.black54;

    final inputBgColor = isDarkMode
        ? const Color(0xFF140A34)
        : const Color(0xFFF0EBF8);

    final inputBorderColor = isDarkMode
        ? const Color(0xFF2E1A66)
        : const Color(0xFFD0C2F2);

    const buttonGradient = [
      Color(0xFFFF2A85),
      Color(0xFF8B129B),
      Color(0xFF00D2FF),
    ];

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
            Positioned.fill(
              child: CustomPaint(
                painter: SpaceStarsPainter(
                  isDarkMode: isDarkMode,
                ),
              ),
            ),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 20,
                  ),
                  child: ScaleTransition(
                    scale: _fadeAnimation,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      decoration: BoxDecoration(
                        color: cardBgColor,
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: cardBorderColor,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: primaryAccent.withOpacity(0.2),
                            blurRadius: 35,
                            spreadRadius: 2,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(
                              isDarkMode ? 0.25 : 0.08,
                            ),
                            blurRadius: 25,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 26,
                          vertical: 32,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFFF2A85)
                                        .withOpacity(0.35),
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
                                  errorBuilder: (
                                    context,
                                    error,
                                    stackTrace,
                                  ) {
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
                            ShaderMask(
                              shaderCallback: (bounds) =>
                                  LinearGradient(
                                colors: [
                                  primaryAccent,
                                  const Color(0xFFFF2A85),
                                ],
                              ).createShader(bounds),
                              child: const Text(
                                'COSMUS',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: 3.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Aprende y visualiza',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: primaryAccent,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 28),

                            _buildTextField(
                              controller: _emailController,
                              hintText: 'Correo electrónico',
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

                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
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
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          border: Border.all(
                                            color: _rememberMe
                                                ? const Color(0xFFFF2A85)
                                                : textSecondary
                                                    .withOpacity(0.5),
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
                                  onTap: () {
                                    _showCustomSnackBar(
                                      'La recuperación de contraseña '
                                      'todavía no está disponible.',
                                      isError: true,
                                    );
                                  },
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

                            Container(
                              width: double.infinity,
                              height: 52,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(
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
                                onPressed: _isLoggingIn
                                    ? null
                                    : _iniciarSesion,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  disabledBackgroundColor:
                                      Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(30),
                                  ),
                                ),
                                child: _isLoggingIn
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child:
                                            CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                            const SizedBox(height: 20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    '¿No tienes una cuenta?',
                                    style: TextStyle(
                                      color: textSecondary,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: _abrirRegistro,
                                  child: Text(
                                    'Regístrate',
                                    style: TextStyle(
                                      color: primaryAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: borderColor,
          width: 1.2,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: isPassword
            ? TextInputType.visiblePassword
            : TextInputType.emailAddress,
        style: TextStyle(
          color: textColor,
          fontSize: 14.5,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: textColor.withOpacity(0.4),
            fontSize: 14,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(
              left: 18,
              right: 12,
            ),
            child: Icon(
              icon,
              color: accentColor,
              size: 21,
            ),
          ),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 50),
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

      Color starColor =
          isDarkMode ? Colors.white : const Color(0xFF6C5CE7);

      if (colorChoice == 1) {
        starColor = const Color(0xFF00D2FF);
      }

      if (colorChoice == 2) {
        starColor = const Color(0xFFFF2A85);
      }

      final paint = Paint()
        ..color = starColor.withOpacity(
          isDarkMode
              ? (rand.nextDouble() * 0.5 + 0.2)
              : (rand.nextDouble() * 0.3 + 0.1),
        );

      canvas.drawCircle(
        Offset(x, y),
        radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant SpaceStarsPainter oldDelegate,
  ) {
    return oldDelegate.isDarkMode != isDarkMode;
  }
}
