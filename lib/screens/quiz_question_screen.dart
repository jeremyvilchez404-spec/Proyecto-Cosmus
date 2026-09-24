import 'package:flutter/material.dart';

import '../data/quiz_data.dart';
import '../main.dart';
import '../models/quiz_question.dart';

class QuizQuestionScreen extends StatefulWidget {
  final String planetName;
  final String categoryName;

  const QuizQuestionScreen({
    super.key,
    required this.planetName,
    required this.categoryName,
  });

  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  late List<QuizQuestion> questions;

  int currentQuestion = 0;
  int score = 0;

  int? selectedAnswer;
  bool answered = false;

  @override
  void initState() {
    super.initState();

    themeNotifier.addListener(_onThemeChanged);

    questions = QuizData.getQuestions(widget.planetName, widget.categoryName);
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

  // ============================================================
  // RESPUESTA
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
  // SIGUIENTE
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
  // REINICIAR
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
  // RESULTADO
  // ============================================================

  void showResult() {
    final int total = questions.length;

    final int percentage = total == 0 ? 0 : ((score / total) * 100).round();

    final bool isDarkMode = themeNotifier.value == ThemeMode.dark;

    final Color dialogBg = isDarkMode ? const Color(0xFF0B193D) : Colors.white;

    final Color textPrimary = isDarkMode
        ? Colors.white
        : const Color(0xFF0F172A);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: dialogBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // TROFEO
                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFFD166).withOpacity(0.15),
                  ),
                  child: const Icon(
                    Icons.emoji_events,
                    color: Color(0xFFFFD166),
                    size: 42,
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  'QUIZ COMPLETADO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textPrimary,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  '${widget.planetName} • ${widget.categoryName}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF61DAFB),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 22),

                // PUNTUACIÓN
                Container(
                  width: 125,
                  height: 125,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF61DAFB).withOpacity(0.12),
                    border: Border.all(
                      color: const Color(0xFF61DAFB),
                      width: 3,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$score/$total',
                        style: TextStyle(
                          color: textPrimary,
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
                  style: TextStyle(
                    color: isDarkMode
                        ? Colors.white70
                        : const Color(0xFF64748B),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 25),

                // REPETIR
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
                      backgroundColor: const Color(0xFF61DAFB),
                      foregroundColor: const Color(0xFF04101F),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // VOLVER A CATEGORÍAS
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(dialogContext);

                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('VOLVER A CATEGORÍAS'),
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
        );
      },
    );
  }

  // ============================================================
  // MENSAJE
  // ============================================================

  String resultMessage() {
    final int total = questions.length;

    if (total == 0) {
      return 'No hay preguntas disponibles.';
    }

    final double percentage = score / total;

    if (percentage == 1) {
      return '¡Perfecto! 🚀\nDominaste este tema.';
    }

    if (percentage >= 0.8) {
      return '¡Excelente trabajo! 🌟\nTienes muy buenos conocimientos.';
    }

    if (percentage >= 0.6) {
      return '¡Muy bien! 🪐\nYa conoces bastante sobre este tema.';
    }

    if (percentage >= 0.4) {
      return '¡Buen intento! 🌌\nTodavía puedes aprender un poco más.';
    }

    return '¡Sigue intentando! 🚀\nPuedes repetir el quiz para mejorar.';
  }

  // ============================================================
  // COLOR OPCIONES
  // ============================================================

  Color getOptionColor(int index, bool isDarkMode) {
    if (!answered) {
      return isDarkMode ? const Color(0xFF0B193D) : Colors.white;
    }

    final int correctAnswer = questions[currentQuestion].correctAnswer;

    if (index == correctAnswer) {
      return isDarkMode ? const Color(0xFF14532D) : const Color(0xFFDCFCE7);
    }

    if (index == selectedAnswer) {
      return isDarkMode ? const Color(0xFF7F1D1D) : const Color(0xFFFEE2E2);
    }

    return isDarkMode ? const Color(0xFF0B193D) : Colors.white;
  }

  Color getOptionBorderColor(int index, bool isDarkMode) {
    if (!answered) {
      return isDarkMode ? const Color(0xFF1B3266) : const Color(0xFFE2E8F0);
    }

    final int correctAnswer = questions[currentQuestion].correctAnswer;

    if (index == correctAnswer) {
      return const Color(0xFF22C55E);
    }

    if (index == selectedAnswer) {
      return const Color(0xFFEF4444);
    }

    return isDarkMode ? const Color(0xFF1B3266) : const Color(0xFFE2E8F0);
  }

  Widget getOptionIcon(int index) {
    if (!answered) {
      return const SizedBox.shrink();
    }

    final int correctAnswer = questions[currentQuestion].correctAnswer;

    if (index == correctAnswer) {
      return const Icon(Icons.check_circle_rounded, color: Color(0xFF22C55E));
    }

    if (index == selectedAnswer) {
      return const Icon(Icons.cancel_rounded, color: Color(0xFFEF4444));
    }

    return const SizedBox.shrink();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = themeNotifier.value == ThemeMode.dark;

    final Color bgColor = isDarkMode
        ? const Color(0xFF040B1E)
        : const Color(0xFFF8FAFC);

    final Color cardBg = isDarkMode ? const Color(0xFF0B193D) : Colors.white;

    final Color textPrimary = isDarkMode
        ? Colors.white
        : const Color(0xFF0F172A);

    final Color textSecondary = isDarkMode
        ? Colors.white60
        : const Color(0xFF64748B);

    final Color cardBorder = isDarkMode
        ? const Color(0xFF1B3266)
        : const Color(0xFFE2E8F0);

    if (questions.isEmpty) {
      return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: bgColor,
          foregroundColor: textPrimary,
          elevation: 0,
          title: Text(
            widget.categoryName,
            style: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Text(
            'No hay preguntas disponibles.',
            style: TextStyle(color: textPrimary),
          ),
        ),
      );
    }

    final QuizQuestion question = questions[currentQuestion];

    final double progress = (currentQuestion + 1) / questions.length;

    return Scaffold(
      backgroundColor: bgColor,

      // ========================================================
      // APP BAR
      // ========================================================
      appBar: AppBar(
        backgroundColor: bgColor,
        foregroundColor: textPrimary,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.planetName,
              style: TextStyle(
                color: textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              widget.categoryName,
              style: const TextStyle(
                color: Color(0xFF61DAFB),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),

      // ========================================================
      // BODY
      // ========================================================
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
          child: Column(
            children: [
              // ==================================================
              // PROGRESO
              // ==================================================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pregunta ${currentQuestion + 1} de ${questions.length}',
                    style: TextStyle(color: textSecondary, fontSize: 14),
                  ),

                  Text(
                    '${(progress * 100).round()}%',
                    style: const TextStyle(
                      color: Color(0xFF61DAFB),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: isDarkMode
                      ? const Color(0xFF17264D)
                      : const Color(0xFFE2E8F0),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF61DAFB),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ==================================================
              // SCORE
              // ==================================================
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.star_rounded,
                    color: Color(0xFFFFD166),
                    size: 21,
                  ),

                  const SizedBox(width: 5),

                  Text(
                    '$score',
                    style: const TextStyle(
                      color: Color(0xFFFFD166),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

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
                          color: cardBg,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: cardBorder),
                          boxShadow: [
                            if (!isDarkMode)
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(
                                  0xFF61DAFB,
                                ).withOpacity(0.12),
                              ),
                              child: const Icon(
                                Icons.help_outline_rounded,
                                color: Color(0xFF61DAFB),
                                size: 30,
                              ),
                            ),

                            const SizedBox(height: 17),

                            Text(
                              question.question,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: textPrimary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        'Selecciona una respuesta:',
                        style: TextStyle(
                          color: textSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // ==========================================
                      // OPCIONES
                      // ==========================================
                      ...List.generate(question.options.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () => selectAnswer(index),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: getOptionColor(index, isDarkMode),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: getOptionBorderColor(
                                      index,
                                      isDarkMode,
                                    ),
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 34,
                                      height: 34,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isDarkMode
                                            ? Colors.white.withOpacity(0.08)
                                            : const Color(0xFFF1F5F9),
                                      ),
                                      child: Text(
                                        String.fromCharCode(65 + index),
                                        style: TextStyle(
                                          color: textPrimary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 14),

                                    Expanded(
                                      child: Text(
                                        question.options[index],
                                        style: TextStyle(
                                          color: textPrimary,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),

                                    getOptionIcon(index),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),

                      // ==========================================
                      // EXPLICACIÓN
                      // ==========================================
                      if (answered)
                        Container(
                          margin: const EdgeInsets.only(top: 4, bottom: 15),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? const Color(0xFF112A4D)
                                : const Color(0xFFEAF9FF),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF61DAFB).withOpacity(0.4),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.lightbulb_rounded,
                                color: Color(0xFFFFD166),
                                size: 22,
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: Text(
                                  question.explanation,
                                  style: TextStyle(
                                    color: textPrimary,
                                    fontSize: 13,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      // ==========================================
                      // BOTÓN
                      // ==========================================
                      if (answered)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: nextQuestion,
                            icon: Icon(
                              currentQuestion < questions.length - 1
                                  ? Icons.arrow_forward
                                  : Icons.emoji_events,
                            ),
                            label: Text(
                              currentQuestion < questions.length - 1
                                  ? 'SIGUIENTE PREGUNTA'
                                  : 'VER RESULTADOS',
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF61DAFB),
                              foregroundColor: const Color(0xFF04101F),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),

                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
