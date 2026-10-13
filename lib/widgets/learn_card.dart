
import 'package:flutter/material.dart';

class LearnCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget icon;
  final VoidCallback onTap;

  const LearnCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark;

    final Color cardColor = isDarkMode
        ? const Color(0xFF131B29)
        : Colors.white;

    final Color borderColor = isDarkMode
        ? const Color(0xFF1E293B)
        : const Color(0xFFE2E8F0);

    final Color titleColor = isDarkMode
        ? Colors.white
        : const Color(0xFF0F172A);

    final Color descriptionColor = isDarkMode
        ? const Color(0xFF94A3B8)
        : const Color(0xFF64748B);

    final Color arrowBackground = isDarkMode
        ? const Color(0xFF1E293B)
        : const Color(0xFFEAF2FC);

    const Color arrowColor = Color(0xFF42A5F5);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: icon,
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    description,
                    style: TextStyle(
                      color: descriptionColor,
                      fontSize: 12,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: arrowBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: arrowColor,
                size: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
