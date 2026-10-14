
import 'package:flutter/material.dart';

import '../main.dart';
import '../services/quiz_service.dart';

class QuizResultDetailScreen extends StatefulWidget {
  final int resultadoId;
  final int userId;
  final String planetName;
  final String categoryName;
  final int score;
  final int totalQuestions;
  final String date;

  const QuizResultDetailScreen({
    super.key,
    required this.resultadoId,
    required this.userId,
    required this.planetName,
    required this.categoryName,
    required this.score,
    required this.totalQuestions,
    required this.date,
  });

  @override
  State<QuizResultDetailScreen> createState() =>
      _QuizResultDetailScreenState();
}

class _QuizResultDetailScreenState
    extends State<QuizResultDetailScreen> {
  bool isLoading = true;
  String? errorMessage;
  List<Map<String, dynamic>> answers = [];

  @override
  void initState() {
    super.initState();
    themeNotifier.addListener(_onThemeChanged);
    _loadDetails();
  }

  @override
  void dispose() {
    themeNotifier.removeListener(_onThemeChanged);
    super.dispose();
  }

  void _onThemeChanged() {
    if (mounted) setState(() {});
  }

  Future<void> _loadDetails() async {
    try {
      final result =
          await QuizService.instance.getQuizResultDetails(
        resultadoId: widget.resultadoId,
        userId: widget.userId,
      );

      if (!mounted) return;

      setState(() {
        answers = result;
        isLoading = false;
        errorMessage = null;
      });
    } catch (e) {
      debugPrint('Error al consultar el detalle del quiz: $e');

      if (!mounted) return;

      setState(() {
        isLoading = false;
        errorMessage =
            'No se pudo cargar el detalle de este cuestionario.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark =
        themeNotifier.value == ThemeMode.dark;

    final Color background = isDark
        ? const Color(0xFF040B1E)
        : const Color(0xFFF1F5F9);

    final Color cardColor = isDark
        ? const Color(0xFF0B193D)
        : Colors.white;

    final Color primaryText =
        isDark ? Colors.white : const Color(0xFF0F172A);

    final Color secondaryText =
        isDark ? Colors.white60 : const Color(0xFF64748B);

    final Color borderColor = isDark
        ? const Color(0xFF1B3266)
        : const Color(0xFFE2E8F0);

    final double percentage = widget.totalQuestions > 0
        ? widget.score / widget.totalQuestions
        : 0;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        foregroundColor: primaryText,
        elevation: 0,
        title: const Text(
          'Detalle del cuestionario',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF61DAFB),
              ),
            )
          : errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      errorMessage!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: primaryText),
                    ),
                  ),
                )
              : answers.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          'Este resultado no tiene respuestas detalladas guardadas.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: primaryText),
                        ),
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: borderColor),
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.planetName,
                                style: TextStyle(
                                  color: primaryText,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                widget.categoryName,
                                style: const TextStyle(
                                  color: Color(0xFF61DAFB),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                'Resultado: ${widget.score}/${widget.totalQuestions}',
                                style: TextStyle(
                                  color: primaryText,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: percentage.clamp(0.0, 1.0),
                                  minHeight: 8,
                                  backgroundColor: borderColor,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                    Color(0xFF61DAFB),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '${(percentage * 100).round()}% • ${widget.date}',
                                style: TextStyle(
                                  color: secondaryText,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Revisión de respuestas',
                          style: TextStyle(
                            color: primaryText,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...List.generate(answers.length, (index) {
                          final answer = answers[index];

                          final List<String> options =
                              List<String>.from(
                            answer['opciones'] as List? ?? [],
                          );

                          final String correctAnswer =
                              answer['respuestaCorrecta']
                                      ?.toString() ??
                                  '';

                          final String? selectedAnswer =
                              answer['respuestaSeleccionada']
                                  ?.toString();

                          final bool isCorrect =
                              answer['esCorrecta'] == true;

                          final String explanation =
                              answer['explicacion']?.toString() ??
                                  '';

                          return Container(
                            margin:
                                const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(17),
                            decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius:
                                  BorderRadius.circular(20),
                              border: Border.all(
                                color: borderColor,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pregunta ${index + 1}',
                                  style: const TextStyle(
                                    color: Color(0xFF61DAFB),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  answer['enunciado']?.toString() ??
                                      '',
                                  style: TextStyle(
                                    color: primaryText,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                ...options.map((option) {
                                  final bool correctOption =
                                      option == correctAnswer;

                                  final bool selectedOption =
                                      selectedAnswer != null &&
                                          option == selectedAnswer;

                                  final Color optionColor =
                                      correctOption
                                          ? const Color(0xFF22C55E)
                                          : selectedOption
                                              ? const Color(0xFFEF4444)
                                              : secondaryText;

                                  final IconData? optionIcon =
                                      correctOption
                                          ? Icons.check_circle_rounded
                                          : selectedOption
                                              ? Icons.cancel_rounded
                                              : null;

                                  return Container(
                                    width: double.infinity,
                                    margin:
                                        const EdgeInsets.only(bottom: 8),
                                    padding: const EdgeInsets.all(11),
                                    decoration: BoxDecoration(
                                      color: optionColor.withOpacity(
                                        isDark ? 0.12 : 0.08,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(12),
                                      border: Border.all(
                                        color: optionColor.withOpacity(
                                          0.55,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            option,
                                            style: TextStyle(
                                              color: primaryText,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        if (optionIcon != null)
                                          Icon(
                                            optionIcon,
                                            color: optionColor,
                                            size: 20,
                                          ),
                                      ],
                                    ),
                                  );
                                }),
                                const SizedBox(height: 8),
                                Text(
                                  selectedAnswer == null
                                      ? 'Tu respuesta: Sin responder'
                                      : 'Tu respuesta: $selectedAnswer',
                                  style: TextStyle(
                                    color: isCorrect
                                        ? const Color(0xFF22C55E)
                                        : const Color(0xFFEF4444),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Respuesta correcta: $correctAnswer',
                                  style: const TextStyle(
                                    color: Color(0xFF22C55E),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                if (explanation.trim().isNotEmpty) ...[
                                  const SizedBox(height: 14),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(13),
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? const Color(0xFF112A4D)
                                          : const Color(0xFFEAF9FF),
                                      borderRadius:
                                          BorderRadius.circular(14),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          '¿Por qué?',
                                          style: TextStyle(
                                            color: Color(0xFF61DAFB),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          explanation,
                                          style: TextStyle(
                                            color: primaryText,
                                            fontSize: 13,
                                            height: 1.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
    );
  }
}
