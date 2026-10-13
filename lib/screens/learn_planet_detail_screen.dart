
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:audioplayers/audioplayers.dart';

class LearnPlanetDetailScreen extends StatefulWidget {
  final Map<String, dynamic> planet;

  const LearnPlanetDetailScreen({
    super.key,
    required this.planet,
  });

  @override
  State<LearnPlanetDetailScreen> createState() =>
      _LearnPlanetDetailScreenState();
}

class _LearnPlanetDetailScreenState
    extends State<LearnPlanetDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _audioReproduciendo = false;
  bool rotando = true;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void cambiarRotacion() {
    setState(() {
      rotando = !rotando;

      if (rotando) {
        _animationController.repeat();
      } else {
        _animationController.stop();
      }
    });
  }

  Future<void> _reproducirAudio() async {
    if (_audioReproduciendo) {
      await _audioPlayer.pause();

      if (!mounted) return;

      setState(() => _audioReproduciendo = false);
      return;
    }

    final String audio = widget.planet['audio'] ?? '';

    if (audio.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Audio próximamente disponible.'),
        ),
      );
      return;
    }

    try {
      await _audioPlayer.play(
        AssetSource(audio.replaceFirst('assets/', '')),
      );

      if (!mounted) return;

      setState(() => _audioReproduciendo = true);
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo reproducir el audio.'),
        ),
      );
    }
  }

  Future<void> _abrirVideo(String videoUrl) async {
    if (videoUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Video próximamente disponible.'),
        ),
      );
      return;
    }

    final Uri? url = Uri.tryParse(videoUrl);

    if (url == null || !url.hasScheme) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El enlace del video no es válido.'),
        ),
      );
      return;
    }

    try {
      final abierto = await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );

      if (!abierto && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No se pudo abrir el video.'),
          ),
        );
      }
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo abrir el video.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark =
        Theme.of(context).brightness == Brightness.dark;

    final Color backgroundColor = isDark
        ? const Color(0xFF070A12)
        : const Color(0xFFF1F5F9);

    final Color primaryText = isDark
        ? Colors.white
        : const Color(0xFF0F172A);

    final Color secondaryText = isDark
        ? const Color(0xFFB0BAC9)
        : const Color(0xFF475569);

    final String name = widget.planet['name'] ?? 'Planeta';
    final String image = widget.planet['image'] ?? '';
    final String subtitle = widget.planet['subtitle'] ?? '';
    final String description = widget.planet['description'] ?? '';
    final String distance = widget.planet['distance'] ?? 'No disponible';
    final String day = widget.planet['day'] ?? 'No disponible';
    final String year = widget.planet['year'] ?? 'No disponible';
    final String moons = widget.planet['moons'] ?? 'No disponible';

    final Color color =
        widget.planet['color'] ?? const Color(0xFF42A5F5);

    final List<String> curiosities = List<String>.from(
      widget.planet['curiosities'] ?? [],
    );

    final List<String> galleryImages = List<String>.from(
      widget.planet['galleryImages'] ?? [image],
    ).where((path) => path.isNotEmpty).toSet().toList();

    final List<Map<String, String>> videos = [];
    final dynamic videoData = widget.planet['videos'];

    if (videoData is List) {
      for (final item in videoData) {
        if (item is Map) {
          final url = (item['url'] ?? '').toString();

          if (url.isNotEmpty) {
            videos.add({
              'url': url,
              'thumbnail': (item['thumbnail'] ?? '').toString(),
              'title': (item['title'] ?? 'Conoce más sobre $name')
                  .toString(),
            });
          }
        }
      }
    }

    if (videos.isEmpty) {
      final String oldUrl = widget.planet['videoUrl'] ?? '';

      if (oldUrl.isNotEmpty) {
        videos.add({
          'url': oldUrl,
          'thumbnail': widget.planet['videoThumbnail'] ?? '',
          'title': 'Conoce más sobre $name',
        });
      }
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: backgroundColor,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              pinned: true,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: primaryText,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                name,
                style: TextStyle(
                  color: primaryText,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(
                    rotando
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline,
                    color: primaryText,
                  ),
                  onPressed: cambiarRotacion,
                ),
              ],
            ),

            SliverToBoxAdapter(
              child: _PlanetHero(
                animation: _animationController,
                image: image,
                name: name,
                color: color,
                isDark: isDark,
                secondaryText: secondaryText,
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
                child: Column(
                  children: [
                    Text(
                      name.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: primaryText,
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: secondaryText,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: _Section(
                title: 'Galería de imágenes',
                icon: Icons.photo_library_outlined,
                color: color,
                isDark: isDark,
                textColor: primaryText,
                child: SizedBox(
                  height: 125,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: galleryImages.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      return _GalleryImage(
                        image: galleryImages[index],
                        color: color,
                        isDark: isDark,
                      );
                    },
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _InfoGrid(
                  distance: distance,
                  day: day,
                  year: year,
                  moons: moons,
                  color: color,
                  isDark: isDark,
                  primaryText: primaryText,
                  secondaryText: secondaryText,
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: _Section(
                title: 'Información',
                icon: Icons.info_outline,
                color: color,
                isDark: isDark,
                textColor: primaryText,
                child: Text(
                  description.isEmpty
                      ? 'Información próximamente disponible.'
                      : description,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.65,
                    color: secondaryText,
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: _Section(
                title: 'Curiosidades',
                icon: Icons.auto_awesome,
                color: color,
                isDark: isDark,
                textColor: primaryText,
                child: curiosities.isEmpty
                    ? Text(
                        'Próximamente encontrarás curiosidades sobre este planeta.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: secondaryText,
                        ),
                      )
                    : Column(
                        children: curiosities
                            .map(
                              (curiosity) => _Curiosity(
                                text: curiosity,
                                color: color,
                                isDark: isDark,
                                textColor: secondaryText,
                              ),
                            )
                            .toList(),
                      ),
              ),
            ),

            SliverToBoxAdapter(
              child: _Section(
                title: 'Aprende más',
                icon: Icons.play_circle_outline,
                color: color,
                isDark: isDark,
                textColor: primaryText,
                child: videos.isEmpty
                    ? Text(
                        'Videos próximamente disponibles.',
                        style: TextStyle(
                          color: secondaryText,
                          fontSize: 14,
                        ),
                      )
                    : SizedBox(
                        height: 205,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: videos.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final video = videos[index];

                            return _VideoCard(
                              thumbnail: video['thumbnail'] ?? '',
                              title: video['title'] ?? 'Video educativo',
                              color: color,
                              isDark: isDark,
                              textColor: primaryText,
                              onTap: () =>
                                  _abrirVideo(video['url'] ?? ''),
                            );
                          },
                        ),
                      ),
              ),
            ),

            SliverToBoxAdapter(
              child: _Section(
                title: 'Escucha y aprende',
                icon: Icons.volume_up_rounded,
                color: color,
                isDark: isDark,
                textColor: primaryText,
                child: _AudioCard(
                  color: color,
                  reproduciendo: _audioReproduciendo,
                  isDark: isDark,
                  textColor: primaryText,
                  onTap: _reproducirAudio,
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 35),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================
// IMAGEN PRINCIPAL ANIMADA
// =============================================================

class _PlanetHero extends StatelessWidget {
  final Animation<double> animation;
  final String image;
  final String name;
  final Color color;
  final bool isDark;
  final Color secondaryText;

  const _PlanetHero({
    required this.animation,
    required this.image,
    required this.name,
    required this.color,
    required this.isDark,
    required this.secondaryText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(.16),
                  blurRadius: 80,
                  spreadRadius: 20,
                ),
              ],
            ),
          ),
          Transform.rotate(
            angle: -math.pi / 7,
            child: Container(
              width: 310,
              height: 110,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(.07)
                      : const Color(0xFF64748B).withOpacity(.15),
                ),
                borderRadius: BorderRadius.circular(200),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              final movimiento =
                  math.sin(animation.value * math.pi * 2) * 8;

              return Transform.translate(
                offset: Offset(0, movimiento),
                child: Transform.rotate(
                  angle: animation.value * math.pi * 2,
                  child: child,
                ),
              );
            },
            child: Hero(
              tag: 'planet-$name',
              child: image.isEmpty
                  ? Container(
                      width: 245,
                      height: 245,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color.withOpacity(.25),
                      ),
                      child: Icon(
                        Icons.public,
                        size: 90,
                        color: color,
                      ),
                    )
                  : Image.asset(
                      image,
                      width: 245,
                      height: 245,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 245,
                          height: 245,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color.withOpacity(.25),
                          ),
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            size: 50,
                            color: color,
                          ),
                        );
                      },
                    ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: Row(
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Explora $name',
                  style: TextStyle(
                    fontSize: 12,
                    color: secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================
// GALERÍA DE IMÁGENES
// =============================================================

class _GalleryImage extends StatelessWidget {
  final String image;
  final Color color;
  final bool isDark;

  const _GalleryImage({
    required this.image,
    required this.color,
    required this.isDark,
  });

  void _ampliarImagen(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.92),
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Center(
                child: InteractiveViewer(
                  child: Image.asset(
                    image,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.image_not_supported_outlined,
                        color: color,
                        size: 60,
                      );
                    },
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 30,
                ),
                tooltip: 'Cerrar imagen',
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _ampliarImagen(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 155,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF10141E) : Colors.white,
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(.07)
                  : const Color(0xFFE2E8F0),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: color.withOpacity(.10),
                alignment: Alignment.center,
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: color,
                  size: 30,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// =============================================================
// GRID DE DATOS
// =============================================================

class _InfoGrid extends StatelessWidget {
  final String distance;
  final String day;
  final String year;
  final String moons;
  final Color color;
  final bool isDark;
  final Color primaryText;
  final Color secondaryText;

  const _InfoGrid({
    required this.distance,
    required this.day,
    required this.year,
    required this.moons,
    required this.color,
    required this.isDark,
    required this.primaryText,
    required this.secondaryText,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.65,
      children: [
        _DataCard(
          icon: Icons.location_on_outlined,
          title: 'Distancia',
          value: distance,
          color: color,
          isDark: isDark,
          primaryText: primaryText,
          secondaryText: secondaryText,
        ),
        _DataCard(
          icon: Icons.schedule,
          title: 'Día',
          value: day,
          color: color,
          isDark: isDark,
          primaryText: primaryText,
          secondaryText: secondaryText,
        ),
        _DataCard(
          icon: Icons.calendar_month_outlined,
          title: 'Año',
          value: year,
          color: color,
          isDark: isDark,
          primaryText: primaryText,
          secondaryText: secondaryText,
        ),
        _DataCard(
          icon: Icons.dark_mode_outlined,
          title: 'Lunas',
          value: moons,
          color: color,
          isDark: isDark,
          primaryText: primaryText,
          secondaryText: secondaryText,
        ),
      ],
    );
  }
}

class _DataCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;
  final bool isDark;
  final Color primaryText;
  final Color secondaryText;

  const _DataCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
    required this.isDark,
    required this.primaryText,
    required this.secondaryText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF10141E) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(.06)
              : const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 20,
              color: color,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    color: secondaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: primaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================
// SECCIÓN
// =============================================================

class _Section extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Widget child;
  final bool isDark;
  final Color textColor;

  const _Section({
    required this.title,
    required this.icon,
    required this.color,
    required this.child,
    required this.isDark,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 19, color: color),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          child,
        ],
      ),
    );
  }
}

// =============================================================
// CURIOSIDADES
// =============================================================

class _Curiosity extends StatelessWidget {
  final String text;
  final Color color;
  final bool isDark;
  final Color textColor;

  const _Curiosity({
    required this.text,
    required this.color,
    required this.isDark,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF10141E) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(.04)
              : const Color(0xFFE2E8F0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.star, size: 17, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================
// TARJETA DE VIDEO
// =============================================================

class _VideoCard extends StatelessWidget {
  final String thumbnail;
  final String title;
  final Color color;
  final bool isDark;
  final Color textColor;
  final VoidCallback onTap;

  const _VideoCard({
    required this.thumbnail,
    required this.title,
    required this.color,
    required this.isDark,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 255,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF10141E) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(.06)
                : const Color(0xFFE2E8F0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  thumbnail.isEmpty
                      ? Container(
                          color: color.withOpacity(.14),
                          child: Icon(
                            Icons.ondemand_video_outlined,
                            color: color,
                            size: 42,
                          ),
                        )
                      : Image.asset(
                          thumbnail,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: color.withOpacity(.14),
                              child: Icon(
                                Icons.ondemand_video_outlined,
                                color: color,
                                size: 42,
                              ),
                            );
                          },
                        ),
                  Container(
                    color: Colors.black.withOpacity(.20),
                  ),
                  Center(
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.black,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(13, 11, 13, 12),
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: textColor,
                  fontSize: 13,
                  height: 1.3,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================
// AUDIO
// =============================================================

class _AudioCard extends StatelessWidget {
  final Color color;
  final bool reproduciendo;
  final bool isDark;
  final Color textColor;
  final VoidCallback onTap;

  const _AudioCard({
    required this.color,
    required this.reproduciendo,
    required this.isDark,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF10141E) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(.06)
                : const Color(0xFFE2E8F0),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: color.withOpacity(.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                reproduciendo
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded,
                color: color,
                size: 30,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                reproduciendo
                    ? 'Reproduciendo información...'
                    : 'Escuchar información del planeta',
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Icons.graphic_eq_rounded,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
