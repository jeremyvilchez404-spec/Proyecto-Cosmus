import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;

  // ============================================================
  // LOGIN TEMPORAL
  // Usuario: admin
  // Contraseña: 1234
  // ============================================================
  void _iniciarSesion() {
    const usuarioCorrecto = 'admin';
    const contrasenaCorrecta = '1234';

    final usuario = _emailController.text.trim();
    final contrasena = _passwordController.text;

    // Verificar campos vacíos
    if (usuario.isEmpty || contrasena.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return;
    }

    // Verificar usuario y contraseña
    if (usuario == usuarioCorrecto && contrasena == contrasenaCorrecta) {
      // Ir al Home y eliminar el Login del historial
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario o contraseña incorrectos')),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // =====================================================
          // FONDO ESPACIAL
          // =====================================================
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0, -0.2),
                  radius: 1.2,
                  colors: [
                    Color(0xFF0B193D),
                    Color(0xFF040B1E),
                    Color(0xFF02050E),
                  ],
                ),
              ),
            ),
          ),

          // =====================================================
          // RESPLANDOR CIAN
          // =====================================================
          Positioned(
            top: -100,
            left: MediaQuery.of(context).size.width * 0.15,
            child: Container(
              width: 280,
              height: 280,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0x6600E5FF), Colors.transparent],
                  stops: [0.0, 0.7],
                ),
              ),
            ),
          ),

          // =====================================================
          // CONTENIDO
          // =====================================================
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),

                    // =================================================
                    // LOGO / NOMBRE
                    // =================================================
                    const Text(
                      'COSMUS',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 6.0,
                        color: Colors.white,
                      ),
                    ),

                    const Text(
                      'EXPLORA EL SISTEMA SOLAR',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.5,
                        color: Color(0xFF00E5FF),
                      ),
                    ),

                    const SizedBox(height: 36),

                    // =================================================
                    // BIENVENIDA
                    // =================================================
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: '¡Bienvenido a ',
                            style: TextStyle(color: Colors.white),
                          ),
                          TextSpan(
                            text: 'Cosmus!',
                            style: TextStyle(color: Color(0xFF00E5FF)),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Inicia sesión para continuar tu\n'
                      'aventura por el universo.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF90A4AE),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // =================================================
                    // USUARIO
                    // =================================================
                    _buildTextField(
                      controller: _emailController,
                      hintText: 'Usuario o correo',
                      icon: Icons.person_outline,
                    ),

                    const SizedBox(height: 16),

                    // =================================================
                    // CONTRASEÑA
                    // =================================================
                    _buildTextField(
                      controller: _passwordController,
                      hintText: 'Contraseña',
                      icon: Icons.lock_outline,
                      isPassword: true,
                      obscureText: _obscureText,
                      onToggleVisibility: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),

                    const SizedBox(height: 24),

                    // =================================================
                    // BOTÓN INGRESAR
                    // =================================================
                    Container(
                      width: double.infinity,
                      height: 54,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4A72B8), Color(0xFF2C4A85)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF3B62AD).withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),

                      child: ElevatedButton(
                        onPressed: _iniciarSesion,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),

                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Ingresar',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),

                            SizedBox(width: 8),

                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // =================================================
                    // OLVIDASTE CONTRASEÑA
                    // =================================================
                    GestureDetector(
                      onTap: () {},

                      child: const Text(
                        '¿Olvidaste tu contraseña?',
                        style: TextStyle(
                          color: Color(0xFF00E5FF),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // =================================================
                    // DIVISOR
                    // =================================================
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,

                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.transparent, Color(0xFF00E5FF)],
                              ),
                            ),
                          ),
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),

                          child: Icon(
                            Icons.star_rate_rounded,
                            color: Color(0xFF00E5FF),
                            size: 18,
                          ),
                        ),

                        Expanded(
                          child: Container(
                            height: 1,

                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF00E5FF), Colors.transparent],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // =================================================
                    // CREAR CUENTA
                    // =================================================
                    SizedBox(
                      width: double.infinity,
                      height: 52,

                      child: OutlinedButton(
                        onPressed: () {},

                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xFF1E3A6E),
                            width: 1.5,
                          ),

                          backgroundColor: const Color(
                            0xFF071228,
                          ).withOpacity(0.6),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),

                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Icon(
                              Icons.person_add_outlined,
                              color: Colors.white,
                              size: 20,
                            ),

                            SizedBox(width: 8),

                            Text(
                              'Crear una cuenta',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // CAMPO DE TEXTO REUTILIZABLE
  // ===============================================================
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0B1736).withOpacity(0.8),

        borderRadius: BorderRadius.circular(28),

        border: Border.all(color: const Color(0xFF1D3560), width: 1.2),
      ),

      child: TextField(
        controller: controller,

        obscureText: obscureText,

        style: const TextStyle(color: Colors.white),

        decoration: InputDecoration(
          hintText: hintText,

          hintStyle: const TextStyle(color: Color(0xFF536A8A), fontSize: 14),

          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 18, right: 12),

            child: Icon(icon, color: const Color(0xFF00E5FF), size: 22),
          ),

          prefixIconConstraints: const BoxConstraints(minWidth: 50),

          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,

                    color: const Color(0xFF00E5FF),

                    size: 20,
                  ),

                  onPressed: onToggleVisibility,
                )
              : null,

          border: InputBorder.none,

          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}
