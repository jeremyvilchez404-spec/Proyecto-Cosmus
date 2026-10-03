import 'package:flutter/material.dart';
import 'learn_planet_detail_screen.dart';

class LearnPlanetsScreen extends StatelessWidget {
  const LearnPlanetsScreen({super.key});

  final List<Map<String, dynamic>> planets = const [
  {
    'name': 'Mercurio',
    'subtitle': 'El planeta más cercano al Sol',
    'image': 'assets/imagenes/Mercuriot.png',
    'icon': 'assets/imagenes/Mercuriot.png',
    'color': Color(0xFFBDBDBD),

    'description':
        'Mercurio es el planeta más pequeño del sistema solar y el más cercano al Sol. '
        'Es un planeta rocoso, con una superficie cubierta de cráteres y una atmósfera extremadamente delgada.\n\n'
        'Mercurio gira lentamente sobre su eje: tarda aproximadamente 59 días terrestres en completar una rotación. '
        'Sin embargo, debido a la relación entre su rotación y su movimiento alrededor del Sol, un día solar completo '
        '(de un amanecer al siguiente) dura aproximadamente 176 días terrestres.\n\n'
        'Mercurio completa una vuelta alrededor del Sol en aproximadamente 88 días terrestres, '
        'por lo que su año es el más corto de todos los planetas del sistema solar.\n\n'
        'A pesar de ser el planeta más cercano al Sol, Mercurio no es el más caliente. '
        'Venus alcanza temperaturas superficiales mayores debido a su densa atmósfera y al fuerte efecto invernadero.\n\n'
        'Mercurio no tiene lunas ni anillos.',

    'distance': '58 millones de km',
    'day': '59 días terrestres',
    'year': '88 días terrestres',
    'moons': '0',

    'curiosities': [
      'Es el planeta más cercano al Sol.',
      'Es el planeta más pequeño del sistema solar.',
      'Su año dura solamente 88 días terrestres.',
      'Una rotación de Mercurio dura aproximadamente 59 días terrestres.',
      'Su día solar dura aproximadamente 176 días terrestres.',
      'No tiene lunas.',
      'No tiene anillos.',
      'A pesar de estar más cerca del Sol, Venus es más caliente que Mercurio.',
    ],
    'videoUrl': 'https://www.youtube.com/watch?v=d6pNPnxp6PY',
    'videoThumbnail': 'assets/imagenes/pantalla_mercurio.png',
    'audio': 'assets/audios/Audio-Mercurio.mp3',
  },
  {
    'name': 'Venus',
    'subtitle': 'El planeta más caliente del sistema solar',
    'icon': 'assets/imagenes/Venust.png',
    'color': Color(0xFFE65603),
    'image': 'assets/imagenes/Venust.png',

    'description':
        'Venus es el segundo planeta desde el Sol y tiene un tamaño muy parecido al de la Tierra. '
        'Es un planeta rocoso, pero posee una atmósfera extremadamente densa compuesta principalmente por dióxido de carbono, '
        'con nubes de ácido sulfúrico.\n\n'
        'La enorme cantidad de dióxido de carbono provoca un intenso efecto invernadero que convierte a Venus '
        'en el planeta más caliente del sistema solar. Las temperaturas de su superficie son suficientemente altas '
        'como para fundir algunos metales.\n\n'
        'Venus gira muy lentamente y en dirección contraria a la mayoría de los planetas. '
        'Su rotación dura aproximadamente 243 días terrestres, mientras que completa una vuelta alrededor del Sol '
        'en aproximadamente 225 días terrestres.\n\n'
        'Por eso, un día de rotación en Venus dura más que un año venusiano. '
        'Sin embargo, desde un amanecer hasta el siguiente transcurren aproximadamente 117 días terrestres.\n\n'
        'Venus no tiene lunas ni anillos.',

    'distance': '108 millones de km',
    'day': '243 días terrestres',
    'year': '225 días terrestres',
    'moons': '0',

    'curiosities': [
      'Es el planeta más caliente del sistema solar.',
      'Su día de rotación dura más que su año.',
      'Gira en dirección contraria a la mayoría de los planetas.',
      'El Sol sale por el oeste y se pone por el este.',
      'Su atmósfera es extremadamente densa.',
      'Posee nubes de ácido sulfúrico.',
      'No tiene lunas.',
      'No tiene anillos.',
    ],
    'videoUrl': 'https://www.youtube.com/watch?v=HNHZggkO-wo',
    'videoThumbnail': 'assets/imagenes/Pantalla_Venus.png',
    'audio': 'assets/audios/Audio-Venus.mp3',
  },
  {
    'name': 'Tierra',
    'subtitle': 'Nuestro hogar en el universo',
    'icon': 'assets/imagenes/Tierrat.png',
    'color': Color(0xFF42A5F5),
    'image': 'assets/imagenes/Tierrat.png',

    'description':
        'La Tierra es el tercer planeta desde el Sol y nuestro hogar. Es un planeta rocoso con una superficie sólida '
        'formada por continentes, montañas, valles, llanuras y océanos.\n\n'
        'Aproximadamente el 71 % de la superficie terrestre está cubierta por agua. '
        'La Tierra posee una atmósfera rica en nitrógeno y oxígeno, que permite la existencia de la vida tal como la conocemos.\n\n'
        'La Tierra tarda aproximadamente 24 horas en completar una rotación y alrededor de 365 días en completar '
        'una vuelta alrededor del Sol.\n\n'
        'Es el único planeta conocido que posee grandes cantidades de agua líquida estable en su superficie '
        'y el único planeta donde se ha confirmado la existencia de vida.\n\n'
        'La Tierra tiene una luna natural: la Luna.',

    'distance': '150,2 millones de km',
    'day': '24 horas',
    'year': '365 días terrestres',
    'moons': '1',

    'curiosities': [
      'Es el único planeta conocido que alberga vida.',
      'Aproximadamente el 71 % de su superficie está cubierta por agua.',
      'Tiene una atmósfera compuesta principalmente por nitrógeno y oxígeno.',
      'La Tierra tiene una luna natural: la Luna.',
      'La Luna se aleja de la Tierra aproximadamente 3,8 centímetros por año.',
      'El agua terrestre existe en estado sólido, líquido y gaseoso.',
      'La Tierra es el planeta rocoso más grande del sistema solar.',
    ],
    'videoUrl': 'https://www.youtube.com/watch?v=cf7cPLdI0hk',
    'videoThumbnail': 'assets/imagenes/Pantalla_Tierra.png',
    'audio': 'assets/audios/Audio-Tierra.mp3',
  },
  {
    'name': 'Marte',
    'subtitle': 'El planeta rojo',
    'icon': 'assets/imagenes/Martet.png',
    'color': Color(0xFFE62020),
    'image': 'assets/imagenes/Martet.png',
    'description':
        'Marte es el cuarto planeta desde el Sol y es conocido como el planeta rojo debido al hierro oxidado '
        'presente en sus rocas y polvo superficial.\n\n'
        'Es un planeta rocoso y frío, aproximadamente la mitad del tamaño de la Tierra. '
        'Su atmósfera es muy delgada y está compuesta principalmente por dióxido de carbono.\n\n'
        'Marte tarda aproximadamente 24,6 horas en completar una rotación, por lo que la duración de su día '
        'es muy parecida a la de la Tierra. Un día solar marciano recibe el nombre de sol.\n\n'
        'Su año dura aproximadamente 687 días terrestres. Marte también presenta estaciones debido a la inclinación '
        'de su eje de rotación.\n\n'
        'Marte posee dos pequeñas lunas llamadas Fobos y Deimos.',

    'distance': '227,9 millones de km',
    'day': '24,6 horas',
    'year': '687 días terrestres',
    'moons': '2',
    
    'curiosities': [
      'Es conocido como el planeta rojo.',
      'Su color se debe principalmente al hierro oxidado de su superficie.',
      'Tiene dos lunas: Fobos y Deimos.',
      'Posee enormes tormentas de polvo que pueden cubrir grandes regiones del planeta.',
      'Tiene Valles Marineris, uno de los sistemas de cañones más grandes conocidos del sistema solar.',
      'Posee Olympus Mons, el volcán más grande conocido del sistema solar.',
      'Un día marciano dura aproximadamente 24,6 horas.',
    ],
    'videoUrl': 'https://www.youtube.com/watch?v=cf7cPLdI0hk',
    'videoThumbnail': 'assets/imagenes/Pantalla_marte.png',
    'audio': 'assets/audios/Audio-Marte.mp3',
  },
  {
    'name': 'Júpiter',
    'subtitle': 'El planeta más grande del sistema solar',
    'icon': 'assets/imagenes/Jupitert.png',
    'color': Color(0xFFF7560B),
    'image': 'assets/imagenes/Jupitert.png',
    'description':
        'Júpiter es el planeta más grande del sistema solar y el quinto planeta desde el Sol. '
        'Es un gigante gaseoso compuesto principalmente por hidrógeno y helio.\n\n'
        'Júpiter no posee una superficie sólida como la Tierra. Su atmósfera presenta bandas de nubes '
        'y enormes tormentas, entre ellas la famosa Gran Mancha Roja.\n\n'
        'Júpiter gira extremadamente rápido. Una rotación completa tarda aproximadamente 9,9 horas, '
        'lo que convierte a Júpiter en el planeta con el día más corto del sistema solar.\n\n'
        'A pesar de su rápida rotación, Júpiter tarda aproximadamente 12 años terrestres en completar una vuelta alrededor del Sol.\n\n'
        'Actualmente NASA indica que Júpiter tiene 115 lunas reconocidas oficialmente. '
        'Entre ellas destacan Ío, Europa, Ganímedes y Calisto, conocidas como las lunas galileanas.',

    'distance': '778 millones de km',
    'day': '9,9 horas',
    'year': '11,86 años terrestres',
    'moons': '115',

    'curiosities': [
      'Es el planeta más grande del sistema solar.',
      'Tiene el día más corto de todos los planetas.',
      'Una rotación dura aproximadamente 9,9 horas.',
      'La Gran Mancha Roja es una enorme tormenta atmosférica.',
      'Tiene 115 lunas reconocidas oficialmente por la IAU según NASA.',
      'Ganímedes, una de sus lunas, es el satélite natural más grande del sistema solar.',
      'Posee un sistema de anillos muy débiles.',
    ],
    'videoUrl': 'https://www.youtube.com/watch?v=5ehFn46dAdc',
    'videoThumbnail': 'assets/imagenes/Pantalla_jupiter.png',
    'audio': 'assets/audios/Audio-Jupiter.mp3',
  },
  {
    'name': 'Saturno',
    'subtitle': 'El planeta de los impresionantes anillos',
    'icon': 'assets/imagenes/Saturnot.png',
    'color': Color(0xFFE99E6C),
    'image': 'assets/imagenes/Saturnot.png',
    'description':
        'Saturno es el sexto planeta desde el Sol y el segundo planeta más grande del sistema solar. '
        'Es un gigante gaseoso compuesto principalmente por hidrógeno y helio.\n\n'
        'Es famoso por su espectacular sistema de anillos, formado principalmente por fragmentos de hielo y roca '
        'de diferentes tamaños. Aunque otros planetas también poseen anillos, los de Saturno son los más destacados '
        'y fáciles de observar.\n\n'
        'Saturno gira rápidamente sobre su eje y completa una rotación en aproximadamente 10,7 horas. '
        'Sin embargo, necesita aproximadamente 29,4 años terrestres para completar una vuelta alrededor del Sol.\n\n'
        'Según NASA, Saturno tenía 274 lunas confirmadas en marzo de 2025, aunque el número puede cambiar '
        'cuando se confirmen nuevos satélites.\n\n'
        'Entre sus lunas más conocidas se encuentran Titán y Encélado.',

    'distance': '1.400 millones de km',
    'day': '10,7 horas',
    'year': '29,4 años terrestres',
    'moons': '274',

    'curiosities': [
      'Es el segundo planeta más grande del sistema solar.',
      'Posee el sistema de anillos más espectacular del sistema solar.',
      'Sus anillos están formados principalmente por hielo y roca.',
      'Un día en Saturno dura aproximadamente 10,7 horas.',
      'Un año en Saturno dura aproximadamente 29,4 años terrestres.',
      'Tiene 274 lunas confirmadas según NASA en marzo de 2025.',
      'Titán es la luna más grande de Saturno.',
      'En el polo norte de Saturno existe una enorme estructura atmosférica con forma hexagonal.',
    ],

    'videoUrl': 'https://www.youtube.com/watch?v=HrFGmGr7KA0',
    'videoThumbnail': 'assets/imagenes/Pantalla_Saturno.png',
    'audio': 'assets/audios/Audio-Saturno.mp3',
  },
  {
    'name': 'Urano',
    'subtitle': 'Un gigante de hielo que gira de lado',
    'icon': 'assets/imagenes/Uranot.png',
    'color': Color(0xFF4DD0E1),
    'image': 'assets/imagenes/Uranot.png',
    'description':
        'Urano es el séptimo planeta desde el Sol y uno de los dos gigantes de hielo del sistema solar. '
        'Su composición es diferente a la de los gigantes gaseosos Júpiter y Saturno.\n\n'
        'Su atmósfera está formada principalmente por hidrógeno y helio, además de metano. '
        'El metano absorbe parte de la luz roja y contribuye al color azul verdoso característico de Urano.\n\n'
        'Una de sus características más llamativas es su inclinación axial de aproximadamente 97,8 grados. '
        'Por esta razón, Urano parece girar prácticamente de lado mientras recorre su órbita.\n\n'
        'Urano tarda aproximadamente 17 horas en completar una rotación y unos 84 años terrestres '
        'en completar una vuelta alrededor del Sol.\n\n'
        'Urano tiene 28 lunas conocidas y también posee un sistema de anillos tenues.',

    'distance': '2.900 millones de km',
    'day': '17 horas',
    'year': '84 años terrestres',
    'moons': '28',

    'curiosities': [
      'Urano gira prácticamente de lado debido a su inclinación axial de aproximadamente 97,8 grados.',
      'Tiene 28 lunas conocidas.',
      'Posee un sistema de anillos tenues.',
      'El metano de su atmósfera contribuye a su color azul verdoso.',
      'Sus estaciones son extremas debido a su gran inclinación.',
      'Cada estación dura aproximadamente 21 años terrestres.',
      'Fue visitado de cerca por la Voyager 2 en 1986.',
    ],
    'videoUrl': 'https://www.youtube.com/watch?v=enkjdmFkgYk',
    'videoThumbnail': 'assets/imagenes/Pantalla_Urano.png',
    'audio': 'assets/audios/Audio-Urano.mp3',
  },
  {
    'name': 'Neptuno',
    'subtitle': 'El planeta más lejano del sistema solar',
    'icon': 'assets/imagenes/Neptunot.png',
    'color': Color(0xFF5C6BC0),
    'image': 'assets/imagenes/Neptunot.png',

    'description':
        'Neptuno es el octavo y más lejano de los ocho planetas del sistema solar. '
        'Es un gigante de hielo, oscuro, frío y conocido por sus fuertes vientos.\n\n'
        'Su atmósfera está compuesta principalmente por hidrógeno y helio, además de metano. '
        'El metano contribuye a su característico color azul.\n\n'
        'Neptuno gira rápidamente y tarda aproximadamente 16 horas en completar una rotación. '
        'Sin embargo, debido a su enorme distancia del Sol, necesita aproximadamente 165 años terrestres '
        'para completar una vuelta alrededor del Sol.\n\n'
        'Neptuno tiene 16 lunas conocidas. La más grande es Tritón, que posee una órbita retrógrada, '
        'es decir, se mueve en dirección opuesta a la rotación del planeta.\n\n'
        'También posee anillos, aunque son mucho más débiles y difíciles de observar que los de Saturno.',

    'distance': '4.500 millones de km',
    'day': '16 horas',
    'year': '165 años terrestres',
    'moons': '16',

    'curiosities': [
      'Es el planeta más lejano del sistema solar.',
      'Tiene algunos de los vientos más rápidos conocidos del sistema solar.',
      'Tarda aproximadamente 165 años terrestres en completar una órbita.',
      'Tiene 16 lunas conocidas.',
      'Tritón es su luna más grande.',
      'Tritón tiene una órbita retrógrada.',
      'Posee anillos muy débiles.',
      'Fue el primer planeta descubierto mediante predicciones matemáticas antes de su observación.',
    ],
    'videoUrl': 'https://www.youtube.com/watch?v=boCOI-Rckp8',
    'videoThumbnail': 'assets/imagenes/Pantalla_Neptuno.png',
    'audio': 'assets/audios/Audio-Neptuno.mp3',
  },
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0E14),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Los Planetas',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF0F2B5C),
                    Color(0xFF15509E),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Conoce los planetas 🪐',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Aprende sobre sus características, curiosidades y secretos.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Explora cada planeta',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 7),

            const Text(
              'Selecciona un planeta para comenzar a aprender.',
              style: TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 18),

            ...planets.map(
              (planet) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _PlanetCard(
                  name: planet['name'],
                  subtitle: planet['subtitle'],
                  icon: planet['icon'],
                  image: planet['image'],
                  color: planet['color'],
                  onTap: () { 
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => LearnPlanetDetailScreen(
                  planet: planet,
                ),
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

class _PlanetCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final String icon;
  final String image;
  final Color color;
  final VoidCallback onTap;

  const _PlanetCard({
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: const Color(0xFF131B29),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF1E293B),
          ),
        ),
        child: Row(
          children: [
            Container(
  width: 60,
  height: 60,
  decoration: BoxDecoration(
    color: color.withOpacity(0.15),
    shape: BoxShape.circle,
  ),
  child: ClipOval(
    child: Image.asset(
      icon,
      width: 60,
      height: 60,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          Icons.public,
          color: color,
          size: 32,
        );
      },
    ),
  ),
),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 12,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xFF42A5F5),
                size: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}