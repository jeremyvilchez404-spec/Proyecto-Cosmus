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

class _LearnPlanetDetailScreenState extends State<LearnPlanetDetailScreen>
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

  // ===========================================================
  // AUDIO
  // ===========================================================

  Future<void> _reproducirAudio() async {
    if (_audioReproduciendo) {
      await _audioPlayer.pause();

      setState(() {
        _audioReproduciendo = false;
      });

      return;
    }

    // Obtiene el audio directamente desde los datos del planeta
    final String? audio = widget.planet['audio'];

    // Si el planeta todavía no tiene audio
    if (audio == null || audio.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Audio próximamente disponible.'),
        ),
      );
      return;
    }

    try {
      // Audioplayers necesita la ruta sin "assets/"
      final String ruta = audio.replaceFirst(
        'assets/',
        '',
      );

      await _audioPlayer.play(
        AssetSource(ruta),
      );

      setState(() {
        _audioReproduciendo = true;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo reproducir el audio.'),
        ),
      );
    }
  }

  // ===========================================================
  // VIDEO
  // ===========================================================

  Future<void> abrirVideo() async {
    final String videoUrl = widget.planet['videoUrl'] ?? '';

    if (videoUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Video próximamente disponible.'),
        ),
      );
      return;
    }

    final Uri url = Uri.parse(videoUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo abrir el video.'),
        ),
      );
    }
  }

  // ===========================================================
  // BUILD
  // ===========================================================

  @override
  Widget build(BuildContext context) {
    final String name = widget.planet['name'] ?? 'Planeta';
    final String image = widget.planet['image'] ?? '';
    final String subtitle = widget.planet['subtitle'] ?? '';
    final String description = widget.planet['description'] ?? '';

    final String distance =
        widget.planet['distance'] ?? 'No disponible';

    final String day =
        widget.planet['day'] ?? 'No disponible';

    final String year =
        widget.planet['year'] ?? 'No disponible';

    final String moons =
        widget.planet['moons'] ?? 'No disponible';

    final List<String> curiosities =
        List<String>.from(widget.planet['curiosities'] ?? []);

    final Color color =
        widget.planet['color'] ?? const Color(0xFF42A5F5);

    final String videoThumbnail =
        widget.planet['videoThumbnail'] ??
            'assets/planetas/cosmos.png';

    return Scaffold(
      backgroundColor: const Color(0xFF070A12),

      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [

            // ===================================================
            // APP BAR
            // ===================================================

            SliverAppBar(
              backgroundColor: const Color(0xFF070A12),
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              pinned: true,

              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              title: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
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
                    color: Colors.white,
                  ),
                  onPressed: cambiarRotacion,
                ),
              ],
            ),

            // ===================================================
            // PLANETA
            // ===================================================

            SliverToBoxAdapter(
              child: _PlanetHero(
                animation: _animationController,
                image: image,
                name: name,
                color: color,
              ),
            ),

            // ===================================================
            // NOMBRE
            // ===================================================

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  8,
                  24,
                  20,
                ),
                child: Column(
                  children: [
                    Text(
                      name.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
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
                        color: Colors.white.withOpacity(.60),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ===================================================
            // DATOS
            // ===================================================

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: _InfoGrid(
                  distance: distance,
                  day: day,
                  year: year,
                  moons: moons,
                  color: color,
                ),
              ),
            ),

            // ===================================================
            // INFORMACIÓN
            // ===================================================

            SliverToBoxAdapter(
              child: _Section(
                title: 'Información',
                icon: Icons.info_outline,
                color: color,

                child: Text(
                  description.isEmpty
                      ? 'Información próximamente disponible.'
                      : description,

                  style: TextStyle(
                    fontSize: 15,
                    height: 1.65,
                    color: Colors.white.withOpacity(.72),
                  ),
                ),
              ),
            ),

            // ===================================================
            // CURIOSIDADES
            // ===================================================

            SliverToBoxAdapter(
              child: _Section(
                title: 'Curiosidades',
                icon: Icons.auto_awesome,
                color: color,

                child: curiosities.isEmpty
                    ? Text(
                        'Próximamente encontrarás curiosidades sobre este planeta.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.white.withOpacity(.60),
                        ),
                      )
                    : Column(
                        children: curiosities
                            .map(
                              (curiosity) => _Curiosity(
                                text: curiosity,
                                color: color,
                              ),
                            )
                            .toList(),
                      ),
              ),
            ),

            // ===================================================
            // VIDEO
            // ===================================================

            SliverToBoxAdapter(
              child: _Section(
                title: 'Aprende más',
                icon: Icons.play_circle_outline,
                color: color,

                child: _VideoCard(
                  thumbnail: videoThumbnail,
                  color: color,
                  name: name,
                  onTap: abrirVideo,
                ),
              ),
            ),

            // ===================================================
            // AUDIO
            // ===================================================

            SliverToBoxAdapter(
              child: _Section(
                title: 'Escucha y aprende',
                icon: Icons.volume_up_rounded,
                color: color,

                child: _AudioCard(
                  color: color,
                  reproduciendo: _audioReproduciendo,
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
// HERO DEL PLANETA
// =============================================================

class _PlanetHero extends StatelessWidget {
  final Animation<double> animation;
  final String image;
  final String name;
  final Color color;

  const _PlanetHero({
    required this.animation,
    required this.image,
    required this.name,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,

      child: Stack(
        alignment: Alignment.center,

        children: [

          // Brillo detrás del planeta
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

          // Órbita decorativa
          Transform.rotate(
            angle: -math.pi / 7,

            child: Container(
              width: 310,
              height: 110,

              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white.withOpacity(.07),
                ),
                borderRadius: BorderRadius.circular(200),
              ),
            ),
          ),

          // Planeta animado
          AnimatedBuilder(
            animation: animation,

            builder: (context, child) {
              final double movimiento =
                  math.sin(
                    animation.value * math.pi * 2,
                  ) *
                  8;

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

                  // Si no existe imagen
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

                  // Imagen del planeta
                  : Image.asset(
                      image,
                      width: 245,
                      height: 245,
                      fit: BoxFit.contain,

                      errorBuilder:
                          (context, error, stackTrace) {
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
                    color: Colors.white.withOpacity(.45),
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
// GRID DE DATOS
// =============================================================

class _InfoGrid extends StatelessWidget {
  final String distance;
  final String day;
  final String year;
  final String moons;
  final Color color;

  const _InfoGrid({
    required this.distance,
    required this.day,
    required this.year,
    required this.moons,
    required this.color,
  });

  String formatoDistancia(String value) {
    if (value == '57.9 millones de km') {
      return '57.9 millones de km';
    }

    return value;
  }

  String formatoDia(String value) {
    if (value == '58.6 días/años terrestres') {
      return '58.6 días/años terrestres';
  }   

    return value;
  }

  String formatoAno(String value) {
    return value.replaceAll(
      ' 88',
      'terrestres',
    );
  }

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
          value: formatoDistancia(distance),
          color: color,
        ),

        _DataCard(
          icon: Icons.schedule,
          title: 'Día',
          value: formatoDia(day),
          color: color,
        ),

        _DataCard(
          icon: Icons.calendar_month_outlined,
          title: 'Año',
          value: formatoAno(year),
          color: color,
        ),

        _DataCard(
          icon: Icons.dark_mode_outlined,
          title: 'Lunas',
          value: moons,
          color: color,
        ),
      ],
    );
  }
}

// =============================================================
// DATA CARD
// =============================================================

class _DataCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _DataCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: const Color(0xFF10141E),
        borderRadius: BorderRadius.circular(18),

        border: Border.all(
          color: Colors.white.withOpacity(.06),
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
              mainAxisAlignment:
                  MainAxisAlignment.center,

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: TextStyle(
                    fontSize: 11,
                    color:
                        Colors.white.withOpacity(.45),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,

                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
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

  const _Section({
    required this.title,
    required this.icon,
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        28,
        20,
        0,
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              Icon(
                icon,
                size: 19,
                color: color,
              ),

              const SizedBox(width: 8),

              Text(
                title,

                style: const TextStyle(
                  color: Colors.white,
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
// CURIOSIDAD
// =============================================================

class _Curiosity extends StatelessWidget {
  final String text;
  final Color color;

  const _Curiosity({
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      margin: const EdgeInsets.only(
        bottom: 10,
      ),

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: const Color(0xFF10141E),
        borderRadius: BorderRadius.circular(15),

        border: Border.all(
          color: Colors.white.withOpacity(.04),
        ),
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Icon(
            Icons.star,
            size: 17,
            color: color,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              text,

              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: Colors.white.withOpacity(.72),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================
// VIDEO
// =============================================================

class _VideoCard extends StatelessWidget {
  final String thumbnail;
  final Color color;
  final String name;
  final VoidCallback onTap;

  const _VideoCard({
    required this.thumbnail,
    required this.color,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        height: 190,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),

          image: DecorationImage(
            image: AssetImage(thumbnail),
            fit: BoxFit.cover,
          ),
        ),

        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),

            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,

              colors: [
                Colors.transparent,
                Colors.black.withOpacity(.82),
              ],
            ),
          ),

          padding: const EdgeInsets.all(18),

          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.end,

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(
                'Conoce más sobre $name',

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                'Video educativo',

                style: TextStyle(
                  color: Colors.white.withOpacity(.65),
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 12),

              Container(
                width: 45,
                height: 45,

                decoration:
                    const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.black,
                ),
              ),
            ],
          ),
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
  final VoidCallback onTap;

  const _AudioCard({
    required this.color,
    required this.reproduciendo,
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
          color: const Color(0xFF10141E),
          borderRadius: BorderRadius.circular(20),

          border: Border.all(
            color: Colors.white.withOpacity(.06),
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

                style: const TextStyle(
                  color: Colors.white,
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