import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SolarSystemScreen extends StatefulWidget {
  const SolarSystemScreen({super.key});

  @override
  State<SolarSystemScreen> createState() => _SolarSystemScreenState();
}

class _SolarSystemScreenState extends State<SolarSystemScreen>
    with SingleTickerProviderStateMixin {
  late final TransformationController _transformationController;
  late final AnimationController _animationController;

  final AudioPlayer _audioPlayer = AudioPlayer();

  double _simulationSpeed = 1.0;
  bool _isPlaying = true;
  int _selectedPlanetIndex = 0;
  double _angleOffset = 0.0;

  final List<Map<String, dynamic>> planetas = [
    {
      'name': 'Sol',
      'image': 'assets/planetas/sol.png',
      'radius': 0.0,
      'speed': 0.0,
      'size': 92.0,
      'description':
          'La estrella central y motor de nuestro Sistema Solar.',
      'distance': '0 km',
      'moons': '8 planetas',
      'dayLength': '25–35 días',
      'temp': '5,500 °C',
      'color': Colors.orange,
    },
    {
      'name': 'Mercurio',
      'image': 'assets/planetas/Mercurio.png',
      'radius': 105.0,
      'speed': 4.15,
      'size': 25.0,
      'initialAngle': 0.2,
      'description':
          'El planeta más pequeño y cercano al Sol.',
      'distance': '57.9 millones km',
      'moons': '0',
      'dayLength': '58.6 días',
      'temp': '167 °C',
      'color': Colors.grey,
    },
    {
      'name': 'Venus',
      'image': 'assets/planetas/Venus.png',
      'radius': 145.0,
      'speed': 3.25,
      'size': 34.0,
      'initialAngle': 1.3,
      'description':
          'El planeta más caliente del Sistema Solar.',
      'distance': '108.2 millones km',
      'moons': '0',
      'dayLength': '243 días',
      'temp': '464 °C',
      'color': Colors.orange,
    },
    {
      'name': 'Tierra',
      'image': 'assets/planetas/tierra.png',
      'radius': 190.0,
      'speed': 2.55,
      'size': 38.0,
      'initialAngle': 2.3,
      'description':
          'Nuestro hogar y el único mundo conocido con vida.',
      'distance': '149.6 millones km',
      'moons': '1',
      'dayLength': '24 horas',
      'temp': '15 °C',
      'color': Colors.blue,
    },
    {
      'name': 'Marte',
      'image': 'assets/planetas/Marte.png',
      'radius': 235.0,
      'speed': 2.05,
      'size': 31.0,
      'initialAngle': 3.2,
      'description':
          'El planeta rojo, con desiertos y volcanes gigantes.',
      'distance': '227.9 millones km',
      'moons': '2',
      'dayLength': '24 h 37 min',
      'temp': '-63 °C',
      'color': Colors.red,
    },
    {
      'name': 'Júpiter',
      'image': 'assets/planetas/Jupiter.png',
      'radius': 305.0,
      'speed': 1.25,
      'size': 64.0,
      'initialAngle': 4.0,
      'description':
          'El planeta más grande del Sistema Solar.',
      'distance': '778.5 millones km',
      'moons': '95+',
      'dayLength': '9 h 56 min',
      'temp': '-110 °C',
      'color': Colors.deepOrange,
    },
    {
      'name': 'Saturno',
      'image': 'assets/planetas/Saturno.png',
      'radius': 365.0,
      'speed': 0.95,
      'size': 58.0,
      'initialAngle': 5.0,
      'description':
          'El gigante gaseoso famoso por sus impresionantes anillos.',
      'distance': '1,434 millones km',
      'moons': '140+',
      'dayLength': '10 h 42 min',
      'temp': '-140 °C',
      'color': Colors.amber,
      'rings': true,
    },
    {
      'name': 'Urano',
      'image': 'assets/planetas/Urano.png',
      'radius': 420.0,
      'speed': 0.68,
      'size': 48.0,
      'initialAngle': 5.7,
      'description':
          'Un gigante helado que gira inclinado de lado.',
      'distance': '2,871 millones km',
      'moons': '27',
      'dayLength': '17 h 14 min',
      'temp': '-195 °C',
      'color': Colors.cyan,
    },
    {
      'name': 'Neptuno',
      'image': 'assets/planetas/Neptuno.png',
      'radius': 470.0,
      'speed': 0.52,
      'size': 46.0,
      'initialAngle': 6.1,
      'description':
          'El planeta más distante y azotado por fuertes vientos.',
      'distance': '4,495 millones km',
      'moons': '14',
      'dayLength': '16 h 6 min',
      'temp': '-200 °C',
      'color': Colors.indigo,
    },
    {
      'name': 'Plutón',
      'image': 'assets/planetas/pluton.png',
      'radius': 515.0,
      'speed': 0.38,
      'size': 24.0,
      'initialAngle': 1.0,
      'description':
          'Un planeta enano situado en las regiones exteriores.',
      'distance': '5,906 millones km',
      'moons': '5',
      'dayLength': '153 horas',
      'temp': '-229 °C',
      'color': Colors.blueGrey,
    },
  ];

  @override
void initState() {
  super.initState();

  _transformationController = TransformationController();

  _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 16),
  );

  _animationController.addListener(() {
    if (!_isPlaying) return;

    setState(() {
      _angleOffset += 0.004 * _simulationSpeed;
    });
  });

  _animationController.repeat();

  _iniciarMusica();
}

Future<void> _iniciarMusica() async {
  try {
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.setVolume(0.75);

    await _audioPlayer.play(
      AssetSource('sonido_cosmos/sonido.mp3'),
    );
  } catch (e) {
    debugPrint('Error al reproducir música: $e');
  }
}

  @override
void dispose() {
  _audioPlayer.stop();
  _audioPlayer.dispose();

  _transformationController.dispose();
  _animationController.dispose();

  super.dispose();
}

  void _resetView() {
    setState(() {
      _transformationController.value = Matrix4.identity();
    });
  }

  void _zoomIn() {
    final current = _transformationController.value;
    final scale = current.getMaxScaleOnAxis();

    if (scale < 3.0) {
      setState(() {
        _transformationController.value =
            current.multiplied(
          Matrix4.diagonal3Values(1.2, 1.2, 1.0),
        );
      });
    }
  }

  void _zoomOut() {
    final current = _transformationController.value;
    final scale = current.getMaxScaleOnAxis();

    if (scale > 0.45) {
      setState(() {
        _transformationController.value =
            current.multiplied(
          Matrix4.diagonal3Values(0.83, 0.83, 1.0),
        );
      });
    }
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _resetSimulation() {
    setState(() {
      _simulationSpeed = 1.0;
      _angleOffset = 0.0;
      _isPlaying = true;
      _selectedPlanetIndex = 0;
    });

    _resetView();
  }

  Offset _planetPosition(
    Map<String, dynamic> planet,
    Offset center,
  ) {
    final double radius = planet['radius'] as double;

    if (radius == 0) {
      return center;
    }

    final double speed = planet['speed'] as double;

    final double initialAngle =
        (planet['initialAngle'] as double?) ?? 0.0;

    final double angle =
        initialAngle + (_angleOffset * speed);

    return Offset(
      center.dx + radius * math.cos(angle),
      center.dy + radius * math.sin(angle),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double mapSize = 1150.0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/planetas/cosmos.png',
              fit: BoxFit.cover,
              errorBuilder: (
                context,
                error,
                stackTrace,
              ) {
                return Container(
                  color: const Color(0xFF02030A),
                );
              },
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.8,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.35),
                  ],
                ),
              ),
            ),
          ),

          Positioned.fill(
            child: InteractiveViewer(
              transformationController:
                  _transformationController,
              minScale: 0.35,
              maxScale: 3.5,
              boundaryMargin:
                  const EdgeInsets.all(600),
              panEnabled: true,
              scaleEnabled: true,
              child: SizedBox(
                width: mapSize,
                height: mapSize,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final center = Offset(
                      mapSize / 2,
                      mapSize / 2,
                    );

                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned.fill(
                          child: CustomPaint(
                            painter: OrbitPainter(
                              planetas: planetas,
                              center: center,
                            ),
                          ),
                        ),

                        ...planetas
                            .asMap()
                            .entries
                            .map((entry) {
                          final index = entry.key;
                          final planet = entry.value;

                          final position =
                              _planetPosition(
                            planet,
                            center,
                          );

                          final bool selected =
                              index ==
                                  _selectedPlanetIndex;

                          final double size =
                              planet['size'] as double;

                          return Positioned(
                            left:
                                position.dx - size / 2,
                            top:
                                position.dy - size / 2,
                            child: _PlanetWidget(
                              planet: planet,
                              size: size,
                              selected: selected,
                              onTap: () {
                                setState(() {
                                  _selectedPlanetIndex =
                                      index;
                                });
                              },
                              onDoubleTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/planet',
                                  arguments: planet,
                                );
                              },
                            ),
                          );
                        }),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),

          _buildTopBar(context),

          _buildZoomControls(),

          _buildSelectedPlanetInfo(),

          _buildBottomControls(),

          _buildPlanetSelector(),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(
          top:
              MediaQuery.of(context).padding.top + 8,
          left: 12,
          right: 12,
          bottom: 18,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.85),
              Colors.transparent,
            ],
          ),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color:
                    Colors.black.withOpacity(0.45),
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      Colors.white.withOpacity(0.15),
                ),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () =>
                    Navigator.pop(context),
              ),
            ),

            const SizedBox(width: 12),

            const Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'COSMUS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Explora nuestro Sistema Solar',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color:
                    Colors.black.withOpacity(0.45),
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      Colors.white.withOpacity(0.15),
                ),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/planet',
                    arguments:
                        planetas[
                            _selectedPlanetIndex],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildZoomControls() {
    return Positioned(
      right: 16,
      top:
          MediaQuery.of(context).size.height * 0.23,
      child: Column(
        children: [
          _floatingButton(
            Icons.my_location,
            _resetView,
            tooltip: 'Centrar',
          ),
          const SizedBox(height: 9),
          _floatingButton(
            Icons.add,
            _zoomIn,
            tooltip: 'Acercar',
          ),
          const SizedBox(height: 5),
          _floatingButton(
            Icons.remove,
            _zoomOut,
            tooltip: 'Alejar',
          ),
        ],
      ),
    );
  }

  Widget _floatingButton(
    IconData icon,
    VoidCallback action, {
    String? tooltip,
  }) {
    return Tooltip(
      message: tooltip ?? '',
      child: Container(
        decoration: BoxDecoration(
          color:
              Colors.black.withOpacity(0.65),
          shape: BoxShape.circle,
          border: Border.all(
            color:
                Colors.white.withOpacity(0.18),
          ),
          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withOpacity(0.35),
              blurRadius: 10,
            ),
          ],
        ),
        child: IconButton(
          icon: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          onPressed: action,
        ),
      ),
    );
  }

  Widget _buildSelectedPlanetInfo() {
    final planet =
        planetas[_selectedPlanetIndex];

    return Positioned(
      left: 16,
      top:
          MediaQuery.of(context).size.height * 0.17,
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 12,
            sigmaY: 12,
          ),
          child: Container(
            width: 190,
            padding:
                const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color:
                  Colors.black.withOpacity(0.48),
              borderRadius:
                  BorderRadius.circular(18),
              border: Border.all(
                color:
                    Colors.white.withOpacity(0.12),
              ),
            ),
            child: Row(
              children: [
                _circleImage(
                  planet['image'],
                  42,
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        planet['name'],
                        style:
                            const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        'Toca para seleccionar',
                        style:
                            TextStyle(
                          color:
                              Colors.white54,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Positioned(
      left: 14,
      right: 14,
      bottom: 105,
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 12,
            sigmaY: 12,
          ),
          child: Container(
            padding:
                const EdgeInsets.fromLTRB(
              16,
              13,
              16,
              13,
            ),
            decoration: BoxDecoration(
              color:
                  Colors.black.withOpacity(0.62),
              borderRadius:
                  BorderRadius.circular(20),
              border: Border.all(
                color:
                    Colors.white.withOpacity(0.12),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.speed,
                      color: Colors.white70,
                      size: 18,
                    ),

                    const SizedBox(width: 8),

                    const Text(
                      'Velocidad',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight:
                            FontWeight.w500,
                      ),
                    ),

                    const Spacer(),

                    Container(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 9,
                        vertical: 4,
                      ),
                      decoration:
                          BoxDecoration(
                        color: Colors.white
                            .withOpacity(0.08),
                        borderRadius:
                            BorderRadius
                                .circular(8),
                      ),
                      child: Text(
                        '${_simulationSpeed.toStringAsFixed(1)}x',
                        style:
                            const TextStyle(
                          color: Colors.white,
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),

                Slider(
                  value: _simulationSpeed,
                  min: 0.1,
                  max: 5.0,
                  onChanged: (value) {
                    setState(() {
                      _simulationSpeed =
                          value;
                    });
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child:
                          ElevatedButton.icon(
                        onPressed:
                            _togglePlayPause,
                        icon: Icon(
                          _isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 18,
                        ),
                        label: Text(
                          _isPlaying
                              ? 'Pausar'
                              : 'Reanudar',
                        ),
                        style:
                            ElevatedButton
                                .styleFrom(
                          backgroundColor:
                              const Color(
                                  0xFF315BE8),
                          foregroundColor:
                              Colors.white,
                          elevation: 0,
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            vertical: 11,
                          ),
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(12),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child:
                          OutlinedButton.icon(
                        onPressed:
                            _resetSimulation,
                        icon: const Icon(
                          Icons.refresh,
                          size: 18,
                        ),
                        label: const Text(
                            'Reiniciar'),
                        style:
                            OutlinedButton
                                .styleFrom(
                          foregroundColor:
                              Colors.white,
                          side: BorderSide(
                            color: Colors.white
                                .withOpacity(
                                    0.18),
                          ),
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            vertical: 11,
                          ),
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(12),
                          ),
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
    );
  }

  Widget _buildPlanetSelector() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10,
      child: SizedBox(
        height: 78,
        child: ListView.builder(
          scrollDirection:
              Axis.horizontal,
          padding:
              const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          itemCount: planetas.length,
          itemBuilder:
              (context, index) {
            final planet =
                planetas[index];

            final selected =
                index ==
                    _selectedPlanetIndex;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPlanetIndex =
                      index;
                });
              },
              onDoubleTap: () {
                Navigator.pushNamed(
                  context,
                  '/planet',
                  arguments: planet,
                );
              },
              child: AnimatedContainer(
                duration:
                    const Duration(
                  milliseconds: 180,
                ),
                width: 68,
                margin:
                    const EdgeInsets
                        .symmetric(
                  horizontal: 4,
                ),
                padding:
                    const EdgeInsets
                        .symmetric(
                  vertical: 7,
                ),
                decoration:
                    BoxDecoration(
                  color: selected
                      ? Colors.white
                          .withOpacity(0.13)
                      : Colors.black
                          .withOpacity(0.52),
                  borderRadius:
                      BorderRadius
                          .circular(15),
                  border: Border.all(
                    color: selected
                        ? Colors.blueAccent
                        : Colors.white
                            .withOpacity(
                                0.10),
                    width:
                        selected ? 1.7 : 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .center,
                  children: [
                    _circleImage(
                      planet['image'],
                      selected
                          ? 38
                          : 34,
                    ),

                    const SizedBox(
                        height: 4),

                    Text(
                      planet['name'],
                      style: TextStyle(
                        color: selected
                            ? Colors.white
                            : Colors.white70,
                        fontSize: 9,
                        fontWeight: selected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                      maxLines: 1,
                      overflow:
                          TextOverflow
                              .ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _circleImage(
    String path,
    double size,
  ) {
    return Container(
      width: size,
      height: size,
      decoration:
          BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.white
                .withOpacity(0.08),
            blurRadius: 7,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          path,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder:
              (context, error, stackTrace) {
            return Container(
              width: size,
              height: size,
              decoration:
                  const BoxDecoration(
                shape:
                    BoxShape.circle,
                color:
                    Colors.white10,
              ),
              child: const Icon(
                Icons.public,
                color:
                    Colors.white38,
                size: 20,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PlanetWidget
    extends StatelessWidget {
  final Map<String, dynamic> planet;
  final double size;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onDoubleTap;

  const _PlanetWidget({
    required this.planet,
    required this.size,
    required this.selected,
    required this.onTap,
    required this.onDoubleTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSun =
        planet['name'] == 'Sol';

    final bool hasRings =
        planet['rings'] == true;

    return GestureDetector(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      child: SizedBox(
        width: hasRings
            ? size * 1.75
            : size + 12,
        height: hasRings
            ? size * 1.75
            : size + 12,
        child: Stack(
          alignment:
              Alignment.center,
          clipBehavior:
              Clip.none,
          children: [
            if (isSun)
              Container(
                width: size * 1.8,
                height: size * 1.8,
                decoration:
                    BoxDecoration(
                  shape:
                      BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors
                          .orange
                          .withOpacity(
                              0.30),
                      blurRadius: 55,
                      spreadRadius: 15,
                    ),
                    BoxShadow(
                      color: Colors
                          .amber
                          .withOpacity(
                              0.35),
                      blurRadius: 28,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),

            if (hasRings)
              Transform.rotate(
                angle: -0.30,
                child: Container(
                  width:
                      size * 1.75,
                  height:
                      size * 0.62,
                  decoration:
                      BoxDecoration(
                    border:
                        Border.all(
                      color: Colors
                          .amber
                          .shade200
                          .withOpacity(
                              0.75),
                      width: 5,
                    ),
                    shape:
                        BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors
                            .amber
                            .withOpacity(
                                0.25),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              ),

            AnimatedContainer(
              duration:
                  const Duration(
                milliseconds: 180,
              ),
              width: selected
                  ? size + 8
                  : size,
              height: selected
                  ? size + 8
                  : size,
              decoration:
                  BoxDecoration(
                shape:
                    BoxShape.circle,
                border: selected
                    ? Border.all(
                        color:
                            Colors.white,
                        width: 2.5,
                      )
                    : null,
                boxShadow: [
                  if (selected)
                    BoxShadow(
                      color: Colors
                          .white
                          .withOpacity(
                              0.45),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  planet['image'],
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (
                    context,
                    error,
                    stackTrace,
                  ) {
                    return Container(
                      decoration:
                          BoxDecoration(
                        shape:
                            BoxShape
                                .circle,
                        color: planet[
                                'color']
                            .withOpacity(
                                0.4),
                      ),
                      child:
                          const Icon(
                        Icons.public,
                        color:
                            Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrbitPainter
    extends CustomPainter {
  final List<Map<String, dynamic>>
      planetas;

  final Offset center;

  OrbitPainter({
    required this.planetas,
    required this.center,
  });

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final orbitPaint = Paint()
      ..style =
          PaintingStyle.stroke
      ..strokeWidth = 1.1
      ..color =
          Colors.white.withOpacity(
              0.22);

    final glowPaint = Paint()
      ..style =
          PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.blueAccent
          .withOpacity(0.025);

    for (final planet
        in planetas) {
      final double radius =
          planet['radius'] as double;

      if (radius <= 0) continue;

      canvas.drawCircle(
        center,
        radius,
        glowPaint,
      );

      canvas.drawCircle(
        center,
        radius,
        orbitPaint,
      );
    }

    final centerGlow = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.orange
              .withOpacity(0.16),
          Colors.orange
              .withOpacity(0.04),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: center,
          radius: 125,
        ),
      );

    canvas.drawCircle(
      center,
      125,
      centerGlow,
    );
  }

  @override
  bool shouldRepaint(
    covariant OrbitPainter
        oldDelegate,
  ) {
    return true;
  }
}