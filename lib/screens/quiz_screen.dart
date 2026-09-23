import 'package:flutter/material.dart';

import '../data/quiz_data.dart';
import '../models/quiz_question.dart';

class QuizScreen extends StatefulWidget {
  final String? planetName;

  const QuizScreen({super.key, this.planetName});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // ============================================================
  // PLANETAS DISPONIBLES
  // ============================================================

  final List<String> planets = [
    'Mercurio',
    'Venus',
    'Tierra',
    'Marte',
    'Júpiter',
    'Saturno',
    'Urano',
    'Neptuno',
  ];

  final Map<String, IconData> planetIcons = {
    'Mercurio': Icons.circle,
    'Venus': Icons.circle,
    'Tierra': Icons.public,
    'Marte': Icons.circle,
    'Júpiter': Icons.circle,
    'Saturno': Icons.circle,
    'Urano': Icons.circle,
    'Neptuno': Icons.circle,
  };

  // ============================================================
  // ESTADO DEL QUIZ
  // ============================================================

  late String selectedPlanet;

  int currentQuestion = 0;
  int score = 0;

  int? selectedAnswer;
  bool answered = false;

  late List<QuizQuestion> questions;

  @override
  void initState() {
    super.initState();

    // Si se recibió un planeta desde otra pantalla,
    // lo seleccionamos automáticamente.
    if (widget.planetName != null &&
        planets.any(
          (planet) =>
              planet.toLowerCase() == widget.planetName!.trim().toLowerCase(),
        )) {
      selectedPlanet = planets.firstWhere(
        (planet) =>
            planet.toLowerCase() == widget.planetName!.trim().toLowerCase(),
      );
    } else {
      // Si no se recibió ningún planeta,
      // seleccionamos Mercurio por defecto.
      selectedPlanet = 'Mercurio';
    }

    loadQuiz(selectedPlanet);
  }

  // ============================================================
  // CARGAR QUIZ DEL PLANETA
  // ============================================================

  void loadQuiz(String planet) {
    final String targetName = planet.trim().toLowerCase();

    final String matchedKey = QuizData.quizzes.keys.firstWhere(
      (key) => key.trim().toLowerCase() == targetName,
      orElse: () => '',
    );

    questions = QuizData.quizzes[matchedKey] ?? [];

    currentQuestion = 0;
    score = 0;
    selectedAnswer = null;
    answered = false;
  }

  // ============================================================
  // SELECCIONAR PLANETA
  // ============================================================

  void selectPlanet(String planet) {
    if (planet == selectedPlanet) return;

    setState(() {
      selectedPlanet = planet;
      loadQuiz(planet);
    });
  }

  // ============================================================
  // SELECCIONAR RESPUESTA
  // ============================================================

  void selectAnswer(int index) {
    if (answered || questions.isEmpty) return;

    setState(() {
      selectedAnswer = index;
      answered = true;

      if (index == questions[currentQuestion].correctAnswer) {
        score++;
      }
    });
  }

  // ============================================================
  // SIGUIENTE PREGUNTA
  // ============================================================

  void nextQuestion() {
    if (!answered) return;

    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
        selectedAnswer = null;
        answered = false;
      });
    } else {
      showResult();
    }
  }

  // ============================================================
  // REINICIAR QUIZ
  // ============================================================

  void restartQuiz() {
    setState(() {
      currentQuestion = 0;
      score = 0;
      selectedAnswer = null;
      answered = false;
    });
  }

  // ============================================================
  // MOSTRAR RESULTADO
  // ============================================================

  void showResult() {
    final int total = questions.length;
    final int percentage = total == 0 ? 0 : ((score / total) * 100).round();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: const Color(0xFF0B193D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFFFD166).withValues(alpha: 0.15),
                    ),
                    child: const Icon(
                      Icons.emoji_events,
                      color: Color(0xFFFFD166),
                      size: 42,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'QUIZ COMPLETADO',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    selectedPlanet,
                    style: const TextStyle(
                      color: Color(0xFF61DAFB),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 22),

                  Container(
                    width: 125,
                    height: 125,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFE83E8C).withValues(alpha: 0.12),
                      border: Border.all(
                        color: const Color(0xFFE83E8C),
                        width: 3,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$score/$total',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 29,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '$percentage%',
                          style: const TextStyle(
                            color: Color(0xFFFFD166),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    resultMessage(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                        restartQuiz();
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('REPETIR QUIZ'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE83E8C),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(dialogContext);

                        if (mounted) {
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('VOLVER'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF61DAFB),
                        side: const BorderSide(color: Color(0xFF61DAFB)),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // MENSAJE DEL RESULTADO
  // ============================================================

  String resultMessage() {
    final int total = questions.length;

    if (total == 0) {
      return 'No hay preguntas disponibles.';
    }

    final double percentage = score / total;

    if (percentage == 1) {
      return '¡Perfecto! 🚀\nConoces muy bien este planeta.';
    }

    if (percentage >= 0.8) {
      return '¡Excelente trabajo! 🌟\nTienes muy buenos conocimientos.';
    }

    if (percentage >= 0.6) {
      return '¡Muy bien! 🪐\nYa conoces bastante sobre este planeta.';
    }

    if (percentage >= 0.4) {
      return '¡Buen intento! 🌌\nTodavía puedes aprender un poco más.';
    }

    return '¡Sigue intentando! 🚀\nPuedes repetir el quiz para mejorar.';
  }

  // ============================================================
  // COLOR DE OPCIONES
  // ============================================================

  Color getOptionColor(int index) {
    if (!answered) {
      return const Color(0xFF111F46);
    }

    final int correctAnswer = questions[currentQuestion].correctAnswer;

    if (index == correctAnswer) {
      return const Color(0xFF14532D);
    }

    if (index == selectedAnswer) {
      return const Color(0xFF7F1D1D);
    }

    return const Color(0xFF111F46);
  }

  // ============================================================
  // BORDE DE OPCIONES
  // ============================================================

  Color getOptionBorderColor(int index) {
    if (!answered) {
      return const Color(0xFF203765);
    }

    final int correctAnswer = questions[currentQuestion].correctAnswer;

    if (index == correctAnswer) {
      return const Color(0xFF49D49D);
    }

    if (index == selectedAnswer) {
      return const Color(0xFFFF5C9A);
    }

    return const Color(0xFF203765);
  }

  // ============================================================
  // ICONO DE OPCIONES
  // ============================================================

  Widget getOptionIcon(int index) {
    if (!answered) {
      return const Icon(Icons.radio_button_unchecked, color: Colors.white30);
    }

    final int correctAnswer = questions[currentQuestion].correctAnswer;

    if (index == correctAnswer) {
      return const Icon(Icons.check_circle, color: Color(0xFF49D49D));
    }

    if (index == selectedAnswer) {
      return const Icon(Icons.cancel, color: Color(0xFFFF5C9A));
    }

    return const Icon(Icons.radio_button_unchecked, color: Colors.white);
  }

  // ============================================================
  // TARJETA DE PLANETA
  // ============================================================

  Widget buildPlanetCard(String planet) {
    final bool isSelected = planet == selectedPlanet;

    return GestureDetector(
      onTap: () => selectPlanet(planet),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        width: 100,
        height: 92,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFE83E8C).withValues(alpha: 0.16)
              : const Color(0xFF0B193D),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFE83E8C)
                : const Color(0xFF203765),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // PLANETA
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getPlanetColor(planet),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(
                            0xFFE83E8C,
                          ).withValues(alpha: 0.25),
                          blurRadius: 10,
                        ),
                      ]
                    : null,
              ),
              child: planet == 'Tierra'
                  ? const Icon(Icons.public, color: Colors.white, size: 22)
                  : null,
            ),

            const SizedBox(height: 7),

            Text(
              planet,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // COLOR VISUAL DE CADA PLANETA
  // ============================================================

  Color getPlanetColor(String planet) {
    switch (planet) {
      case 'Mercurio':
        return const Color(0xFF9E9E9E);

      case 'Venus':
        return const Color(0xFFE6B566);

      case 'Tierra':
        return const Color(0xFF3D8BFF);

      case 'Marte':
        return const Color(0xFFE85D4A);

      case 'Júpiter':
        return const Color(0xFFD39A6A);

      case 'Saturno':
        return const Color(0xFFE0C58B);

      case 'Urano':
        return const Color(0xFF66D9E8);

      case 'Neptuno':
        return const Color(0xFF4169E1);

      default:
        return const Color(0xFF61DAFB);
    }
  }

  // ============================================================
  // PANTALLA
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF040B1E),

      appBar: AppBar(
        backgroundColor: const Color(0xFF040B1E),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Quiz',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ==================================================
              // SELECTOR DE PLANETAS
              // ==================================================
              const Text(
                'Selecciona un planeta',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Elige el planeta que quieres poner a prueba.',
                style: TextStyle(color: Colors.white60, fontSize: 13),
              ),

              const SizedBox(height: 14),

              SizedBox(
                height: 92,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: planets.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    return buildPlanetCard(planets[index]);
                  },
                ),
              ),

              const SizedBox(height: 20),

              // ==================================================
              // SI NO HAY PREGUNTAS
              // ==================================================
              if (questions.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.quiz_outlined,
                          color: Color(0xFF61DAFB),
                          size: 60,
                        ),

                        const SizedBox(height: 15),

                        Text(
                          'No hay preguntas disponibles para $selectedPlanet.',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              // ==================================================
              // QUIZ
              // ==================================================
              else ...[
                // INFORMACIÓN DEL QUIZ
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Quiz de $selectedPlanet',
                      style: const TextStyle(
                        color: Color(0xFF61DAFB),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xFFFFD166),
                          size: 18,
                        ),

                        const SizedBox(width: 5),

                        Text(
                          '$score',
                          style: const TextStyle(
                            color: Color(0xFFFFD166),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // ==================================================
                // PROGRESO
                // ==================================================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pregunta ${currentQuestion + 1} de ${questions.length}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),

                    Text(
                      '${((currentQuestion + 1) / questions.length * 100).round()}%',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: (currentQuestion + 1) / questions.length,
                    minHeight: 8,
                    backgroundColor: const Color(0xFF17264D),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFFE83E8C),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // ==================================================
                // CONTENIDO
                // ==================================================
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // ==========================================
                        // PREGUNTA
                        // ==========================================
                        Container(
                          padding: const EdgeInsets.all(22),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0B193D),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: const Color(0xFF1B3266)),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(
                                    0xFFE83E8C,
                                  ).withValues(alpha: 0.15),
                                ),
                                child: const Icon(
                                  Icons.help_outline,
                                  color: Color(0xFFE83E8C),
                                  size: 28,
                                ),
                              ),

                              const SizedBox(height: 15),

                              Text(
                                questions[currentQuestion].question,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          'Selecciona una respuesta:',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),

                        const SizedBox(height: 10),

                        // ==========================================
                        // OPCIONES
                        // ==========================================
                        ...List.generate(
                          questions[currentQuestion].options.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 11),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(18),
                              onTap: () => selectAnswer(index),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 220),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 15,
                                ),
                                decoration: BoxDecoration(
                                  color: getOptionColor(index),
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                    color: getOptionBorderColor(index),
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 38,
                                      height: 38,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withValues(
                                          alpha: 0.08,
                                        ),
                                      ),
                                      child: Text(
                                        String.fromCharCode(65 + index),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 13),

                                    Expanded(
                                      child: Text(
                                        questions[currentQuestion]
                                            .options[index],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),

                                    getOptionIcon(index),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        // ==========================================
                        // EXPLICACIÓN
                        // ==========================================
                        if (answered)
                          Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: const Color(0xFF101F42),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.06),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '💡',
                                  style: TextStyle(fontSize: 22),
                                ),

                                const SizedBox(width: 10),

                                Expanded(
                                  child: Text(
                                    questions[currentQuestion].explanation,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // ==================================================
                // BOTÓN SIGUIENTE
                // ==================================================
                SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    onPressed: answered ? nextQuestion : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE83E8C),
                      disabledBackgroundColor: const Color(0xFF252C40),
                      foregroundColor: Colors.white,
                      disabledForegroundColor: Colors.white30,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Text(
                      currentQuestion == questions.length - 1
                          ? 'VER RESULTADO'
                          : 'SIGUIENTE →',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
