import 'package:flutter/material.dart';

class PlanetCard extends StatelessWidget {
  final String name;
  final String emoji;
  final String image;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const PlanetCard({
    super.key,
    required this.name,
    required this.emoji,
    required this.image,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.15),
                ),
                child: ClipOval(
                  child: Image.asset(
                    image,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,

                    // Si la imagen no existe,
                    // muestra el emoji como respaldo.
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Text(
                          emoji,
                          style: const TextStyle(
                            fontSize: 28,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}