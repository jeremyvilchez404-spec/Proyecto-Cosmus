
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../services/quiz_service.dart';
import 'quiz_result_detail_screen.dart';

class QuizHistoryScreen extends StatefulWidget {
  const QuizHistoryScreen({super.key});

  @override
  State<QuizHistoryScreen> createState() =>
      _QuizHistoryScreenState();
}

class _QuizHistoryScreenState extends State<QuizHistoryScreen> {
  bool isLoading = true;
  bool isGuest = false;
  int? userId;

  List<Map<String, dynamic>> history = [];

  @override
  void initState() {
    super.initState();
    themeNotifier.addListener(_onThemeChanged);
    _loadHistory();
  }

  @override
  void dispose() {
    themeNotifier.removeListener(_onThemeChanged);
    super.dispose();
  }

  void _onThemeChanged() {
    if (mounted) setState(() {});
  }

  Future<void> _loadHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final guest = prefs.getBool('isGuest') ?? false;
      final id = prefs.getInt('userId');

      List<Map<String, dynamic>> results = [];

      if (!guest && id != null) {
        results = await QuizService.instance.getQuizHistory(id);
      }

      if (!mounted) return;

      setState(() {
        isGuest = guest;
        userId = id;
        history = results;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo cargar el historial.'),
        ),
      );
    }
  }

  String _formatDate(dynamic value) {
    if (value == null) return 'Fecha no disponible';

    final date = DateTime.tryParse(value.toString());

    if (date == null) return 'Fecha no disponible';

    final localDate = date.toLocal();

    final day = localDate.day.toString().padLeft(2, '0');
    final month = localDate.month.toString().padLeft(2, '0');
    final year = localDate.year.toString();

    final hour = localDate.hour.toString().padLeft(2, '0');
    final minute = localDate.minute.toString().padLeft(2, '0');

    return '$day/$month/$year - $hour:$minute';
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

    final Color accent = isDarkMode
        ? const Color(0xFF61DAFB)
        : const Color(0xFF1E88E5);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        foregroundColor: textPrimary,
        title: const Text(
          'Historial de Quizzes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: _buildBody(
        cardBg: cardBg,
        textPrimary: textPrimary,
        textSecondary: textSecondary,
        cardBorder: cardBorder,
        accent: accent,
      ),
    );
  }

  Widget _buildBody({
    required Color cardBg,
    required Color textPrimary,
    required Color textSecondary,
    required Color cardBorder,
    required Color accent,
  }) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(color: accent),
      );
    }

    if (isGuest) {
      return _buildMessage(
        icon: Icons.person_outline_rounded,
        title: 'Estás en modo invitado',
        message:
            'El historial personal está disponible para las cuentas registradas. '
            'Los resultados realizados como invitado no se vinculan a una cuenta.',
        textPrimary: textPrimary,
        textSecondary: textSecondary,
      );
    }

    if (userId == null) {
      return _buildMessage(
        icon: Icons.account_circle_outlined,
        title: 'Iniciá sesión',
        message:
            'No se encontró una sesión de usuario. Iniciá sesión para consultar tu historial.',
        textPrimary: textPrimary,
        textSecondary: textSecondary,
      );
    }

    if (history.isEmpty) {
      return _buildMessage(
        icon: Icons.history_rounded,
        title: 'Todavía no hay resultados',
        message:
            'Cuando completes un cuestionario y se guarde el resultado, aparecerá aquí.',
        textPrimary: textPrimary,
        textSecondary: textSecondary,
      );
    }

    return RefreshIndicator(
      onRefresh: _loadHistory,
      color: accent,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: cardBorder),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.history_rounded,
                  color: accent,
                  size: 34,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tu actividad',
                        style: TextStyle(
                          color: textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${history.length} cuestionarios registrados',
                        style: TextStyle(
                          color: textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ...history.map(
            (result) => _buildHistoryCard(
              result: result,
              cardBg: cardBg,
              textPrimary: textPrimary,
              textSecondary: textSecondary,
              cardBorder: cardBorder,
              accent: accent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard({
    required Map<String, dynamic> result,
    required Color cardBg,
    required Color textPrimary,
    required Color textSecondary,
    required Color cardBorder,
    required Color accent,
  }) {
    final int score =
        (result['puntuacion'] as num?)?.toInt() ?? 0;

    final int total =
        (result['total_preguntas'] as num?)?.toInt() ?? 0;

    final double percentage = total > 0 ? score / total : 0;

    final Color resultColor = percentage >= 0.7
        ? const Color(0xFF49D49D)
        : const Color(0xFFFFB74D);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cardBorder),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () async {
            final int? resultId =
                (result['id'] as num?)?.toInt();

            final int? currentUserId = userId;

            if (resultId == null || currentUserId == null) {
              return;
            }

            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => QuizResultDetailScreen(
                  resultadoId: resultId,
                  userId: currentUserId,
                  planetName:
                      result['planeta']?.toString() ?? '',
                  categoryName:
                      result['categoria']?.toString() ?? '',
                  score: score,
                  totalQuestions: total,
                  date: _formatDate(result['fecha']),
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: accent.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.public_rounded,
                        color: accent,
                        size: 27,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            result['planeta']?.toString() ??
                                'Planeta desconocido',
                            style: TextStyle(
                              color: textPrimary,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            result['categoria']?.toString() ??
                                'Categoría desconocida',
                            style: TextStyle(
                              color: textSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$score/$total',
                      style: TextStyle(
                        color: resultColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: percentage.clamp(0.0, 1.0),
                    minHeight: 7,
                    backgroundColor: cardBorder,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      resultColor,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: textSecondary,
                      size: 15,
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                      child: Text(
                        _formatDate(result['fecha']),
                        style: TextStyle(
                          color: textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      '${(percentage * 100).round()}%',
                      style: TextStyle(
                        color: resultColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Ver respuestas',
                      style: TextStyle(
                        color: accent,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: accent,
                      size: 13,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessage({
    required IconData icon,
    required String title,
    required String message,
    required Color textPrimary,
    required Color textSecondary,
  }) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 72,
              color: const Color(0xFF61DAFB),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textPrimary,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textSecondary,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
