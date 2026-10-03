import 'package:flutter/material.dart';
import 'learn_planet_detail_screen.dart';

class LearnPlanetsScreen extends StatelessWidget {
  const LearnPlanetsScreen({super.key});

  final List<Map<String, dynamic>> planets = const [
    {
      'name': 'Mercurio',
      'subtitle': 'El planeta más cercano al Sol',
      'image': 'assets/imagenes/Mercuriot.png',
      'color': Color.fromARGB(255, 255, 253, 253),
      'icon': 'assets/imagenes/Mercuriot.png',
      'description':
      'Mercurio es el planeta más pequeño de nuestro sistema solar,  es apenas un poco más grande que la Luna de la tierra, sin embargo, mercurio no tiene luna.\n'
      'Este pequeño planeta gira lentamente en comparación con la tierra, por lo que un día dura mucho tiempo, se necesitan 59 días terrestres para tener un día (o una rotación completa) en mercurio.\n\n'
      'Sin embargo, ¡un año en mercurio pasa rápido! debido a que es el planeta más cercano al Sol, no se tarda mucho en dar una vuelta completa, mercurio completa una revolución alrededor del Sol en solo 88 días terrestres.\n\n'
      'Si vivieras allí, ¡sería tu cumpleaños cada tres meses!Un día en mercurio no es como un día en la tierra, Para nosotros, el Sol sale y se pone todos los días, debido a que mercurio tiene una rotación lenta y un año corto, allí el Sol tarda mucho tiempo en salir y ponerse.\n '
      '¡Mercurio solo tiene un amanecer cada 180 días terrestres!, No es loco?',
      'distance': '57.9 millones de km',
      'day': '58.6 días terrestres',
      'year': '88 días terrestres',
      'moons': '0',
      'curiosities': [
      'su atmosfera es muy delgada  y no lo protege',
      'Es dificil de observar desde la tierra',
      'Es el planeta más cercano al Sol.',
      'Es el planeta más pequeño del Sistema Solar.',
      'Un año en Mercurio dura solo 88 días terrestres.',
      'No es el más caliente: Aunque está más cerca del Sol, Venus es más caliente debido a su gruesa atmósfera que atrapa el calor',
      'Venus se ve como un planeta muy activo. Tiene montañas y volcanes. Venus es similar a la Tierra, en tamaño. La Tierra es solo un poco más grande.',
      'La fuerte gravedad del Sol impide que Mercurio conserve lunas a su alrededor.',
      ],
      'videoUrl': 'https://www.youtube.com/watch?v=d6pNPnxp6PY',
      'videoThumbnail': 'assets/imagenes/pantalla_mercurio.png',
      'audio': 'assets/audios/Audio-Mercurio.mp3',
      }, 
    {
      'name': 'Venus',
      'subtitle': 'el segundo planeta del sistema solar y el más caliente de todos',
      'icon': 'assets/imagenes/Venust.png',
      'color': Color.fromARGB(255, 230, 86, 3),
      'image': 'assets/imagenes/Venust.png',
      'description':
      'Aunque Venus no es el planeta más cercano al Sol, es el más caliente, tiene una atmósfera densa, llena de dióxido de carbono, que provoca el efecto invernadero, y de nubes compuestas de ácido sulfúrico, los gases atrapan el calor y mantienen a Venus bien calentito,\n\n'
      'De hecho, hace tanto calor en Venus que metales como el plomo serían charcos de metal fundido.\n'
      'Venus se ve como un planeta muy activo, tiene montañas y volcanes, venus es similar a la tierra, (en tamaño), la tierra es solo un poco más grande ,venus es poco común porque gira en dirección contraria a la de la tierra y la mayoría de los otros planetas.\n\n' 
      'Su rotación es muy lenta, tarda alrededor de 243 días terrestres en girar solo una vez, debido a que está tan cerca del Sol, un año pasa muy rápido, venus tarda 225 días terrestres en dar toda la vuelta alrededor del Sol. Esto significa que, en Venus, un día es un poco más largo que un año.\n\n'
      'Debido a que las longitudes del día y del año son similares, un día en Venus no es como un día en la Tierra. Aquí, en la Tierra, el Sol sale y se pone una vez por día. En Venus, el Sol sale cada 117 días terrestres. Así que el Sol sale dos veces por año, ¡aunque todavía sea el mismo día! Y dado que Venus rota hacia atrás, el Sol sale por el oeste y se pone en el este.\n'
      'Al igual que Mercurio, Venus no tiene ninguna luna.', 
      'distance': '57.9 millones de km',
      'day': '243',
      'year': '225',
      'moons': '0',
      'curiosities': [
      'Un día dura más que un año. (• Rotación lenta: Venus tarda 243 días terrestres en girar sobre sí mismo una sola vez.Órbita rápida Tarda solo 225 días terrestres en dar una vuelta completa alrededor del Sol.)',
      'Gira al revés',
      'Lluvia que se evapora',
      'Un nombre de diosa, (Mitología: Venus recibe su nombre de la diosa romana del amor y la belleza.)',
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
      'description'
      :
      'Nuestro hogar, el planeta Tierra, es un planeta terrestre y rocoso. Tiene una superficie sólida y activa, con montañas, valles, cañones, llanuras y mucho más. La Tierra es especial porque es un planeta océano, ya que el agua cubre el 70% de su superficie.\n\n'
      'Nuestra atmósferaestá compuesta, en gran parte, por nitrógeno. También tiene mucho oxígeno, que nos permite respirar. Además, nos protege de los meteoroides que se acercan a la Tierra, la mayoría de los cuales se desintegran en nuestra atmósfera antes de llegar a la superficie en forma de meteoritos.\n\n'
      'Es posible que, como se trata de nuestro hogar, pienses que lo sabemos todo sobre la Tierra. ¡La verdad es que no! Aún nos queda mucho por aprender sobre nuestro planeta. Actualmente, hay muchos satélites en órbita alrededor de la Tierra, tomando fotos y realizando mediciones. Esto nos permite saber más cosas sobre el clima, los océanos, la tierra, el cambio climático y muchos otros temas importantes.',
      'distance: 149.6 millones de kilómetros'
      'day': '24',
      'year': '365',
      'moons': '1',
      'curiosities': [
      'No es redonda: Tiene una forma irregular llamada geoide porque se ensancha en el ecuador y se aplana ligeramente en los polo.\n\n'
      '• La Luna se aleja: El satélite natural se separa cada año de la Tierra a un ritmo aproximado de 4 centímetros por año.',

      'El verdadero pulmón: Los océanos producen entre el 50% y el 80% del oxígeno del planeta gracias al fitoplancton y las algas marinas.',
      'El agua cubre más del 70% de la Tierra\n\n'
      'En la Tierra, el agua se encuentra en estado sólido, líquido y gaseoso.'
      'Además, cubre las tres cuartas partes de la superficie terrestre en forma de pantanos, lagos, ríos, mares y océanos.'
      'Estos últimos contienen alrededor del 97% de toda el agua del planeta.',
      
      ],
      'videoUrl': 'https://www.youtube.com/watch?v=cf7cPLdI0hk',
      'videoThumbnail': 'assets/imagenes/Pantalla_Tierra.png',
      'audio': 'assets/audios/Audio-Tierra.mp3',
    },
    {
      'name': 'Marte',
      'subtitle': 'El planeta rojo',
      'icon': 'assets/imagenes/Martet.png',
      'color': Color.fromARGB(255, 230, 32, 32),
      'image': 'assets/imagenes/Martet.png',
      'description'
      :
      'Marte es un mundo frío y desértico. La temperatura media en Marte es de -65 grados Celsius (-85 grados Fahrenheit), muy por debajo del punto de congelación. Marte tiene la mitad del tamaño de la Tierra. A veces es llamado el planeta rojo. Es rojo debido al hierro oxidado de su suelo.\n\n'
      'Al igual que la Tierra, Marte tiene estaciones del año, casquetes polares, volcanes, cañones y tiempo meteorológico. Tiene una atmósfera muy delgada compuesta principalmente de dióxido de carbono, nitrógeno y argón. Las personas no podrían respirar el aire en Marte.'
      'distance: 228 millones de kilómetros',
      'day': '24,6 horas',
      'year': '687 dias',
      'moons': '2',
      'curiosities': [
      'Tormentas de polvo gigantescas\n\n'
      '•Sufre las tormentas de polvo más grandes de todo el sistema solar.'
      '•todo el planeta durante semanas o meses y bloquear la luz del sol.',

      'Dos lunas con forma de patata \n\n'
      '•Tiene dos satélites naturales pequeños llamados Fobos y Deimos.'
      '•No son redondos; tienen una forma irregular parecida a una patata.'
      '•Fobos orbita tan rápido que sale y se pone dos veces al día, y se acerca cada vez más al planeta, por lo que podría desintegrarse en el futuro y formar un anillo.',

      'El gran cañón Valles Marineris\n\n'
      '•Posee el sistema de cañones más grande del sistema sola'
      '•El Valles Marineris se extiende a lo largo de unos 3.870 kilómetros'
      '•Es más de 10 veces más largo que el Gran Cañón de la Tierra.',
      
      ],
      'videoUrl': 'https://www.youtube.com/watch?v=cf7cPLdI0hk',
      'videoThumbnail': 'assets/imagenes/Pantalla_marte.png',
      'audio': 'assets/audios/Audio-Marte.mp3',
    },
    {
      'name': 'Júpiter',
      'subtitle': 'El planeta más grande',
      'icon': 'assets/imagenes/Jupitert.png',
      'color': Color.fromARGB(255, 247, 86, 11),
      'image': 'assets/imagenes/Jupitert.png',
      'description'
      :
      'Júpiter es el planeta más grande de nuestro sistema solar. Es parecido a una estrella, pero nunca tuvo la masa suficiente para comenzar a arder. Está cubierto de bandas de nubes arremolinadas. Tiene grandes tormentas como la Gran Mancha Roja, que existe desde hace cientos de años. Júpiter es un gigante gaseoso y no tiene una superficie sólida. Todavía no está claro si en el fondo Júpiter tiene un núcleo central de material sólido o si podría ser una sopa espesa, supercaliente y densa. Júpiter también tiene anillos, pero son demasiado tenues para verlos con claridad.\n\n'
      '• Características principales'
      '• Gigante gaseoso: No tiene una superficie sólida y está formado principalmente por hidrógeno y helio.'
      '• Gran Mancha Roja: Es una tormenta gigante e histórica que es más grande que la Tierra.'
      '• Lunas: Tiene 95 lunas reconocidas oficialmente, entre las que destacan las cuatro lunas galileanas descubiertas por Galileo Galilei: Ío, Europa, Ganímedes y Calisto. Ganímedes es el satélite natural más grande de todo el sistema solar.',
      '• Gran tamaño: Su masa es más del doble que la de todos los demás planetas juntos.'
      'distance: 228 millones de kilómetros'
      'day': '10 horas',
      'year': '11.8 años',
      'moons': '95',
      'curiosities': [
      '•El día más rápido: Tarda solo unas 9,9 horas en dar una vuelta completa sobre su propio eje, lo que lo convierte en el día más corto del sistema solar..\n\n'
      '•Auroras perpetuas: Tiene auroras boreales cientos de veces más energéticas que las de la Tierra y que nunca se detienen',
      '•Anillos tenues: Posee un sistema de anillos compuestos de pequeñas partículas de polvo oscuro, difíciles de ver a simple vista',

      ],
      'videoUrl': 'https://www.youtube.com/watch?v=5ehFn46dAdc',
      'videoThumbnail': 'assets/imagenes/Pantalla_jupiter.png',
      'audio': 'assets/audios/Audio-Jupiter.mp3',
    },
    {
      'name': 'Saturno',
      'subtitle': 'El planeta de los anillos',
      'icon': 'assets/imagenes/Saturnot.png',
      'color': Color.fromARGB(255, 233, 158, 108),
      'image': 'assets/imagenes/Saturnot.png',
      'description'
      :
      'Saturno no es el único planeta que tiene anillos, pero definitivamente tiene los más bellos. Los anillos que vemos están compuestos por grupos de pequeños aros que rodean a Saturno. Están hechos de pedazos de hielo y roca. Como Júpiter, Saturno es una pelota de hidrógeno y helio, en gran parte.\n\n'
      ''
      'Estructura y superficie'
      'Es un gigante de gas, como Júpiter. Está compuesto por hidrógeno y helio, sobre todo.'
      'Tiene una atmósfera densa'
      'Cuenta con un precioso grupo de siete anillos separados por espacio entre ellos.'
      'Cuando Galileo Galilei vio a Saturno a través de un telescopio en el siglo XVII, no estaba seguro de lo que estaba viendo. Al principio, creyó que estaba mirando tres planetas, o un planeta con asas. Ahora, sabemos que esas "asas" eran los anillos de Saturno.',
      'distance: 228 millones de kilómetros'
      'day': '10,7 horas',
      'year': '29 años',
      'moons': '274',
      'curiosities': [
      'Anillos de hielo: Sus icónicos anillos están formados por fragmentos de hielo y roca que van desde tamaño microscópico hasta varios metros.\n\n'
      'Días muy cortos: A pesar de tardar casi 29 años terrestres en dar la vuelta al Sol, gira tan rápido sobre su eje que un día dura solo 10.7 horas.'
      'Tormenta hexagonal: En su polo norte existe una extraña tormenta permanente con una perfecta forma geométrica de seis lados',
      ],
      'videoUrl': 'https://www.youtube.com/watch?v=HrFGmGr7KA0',
      'videoThumbnail': 'assets/imagenes/Pantalla_Saturno.png',
      'audio': 'assets/audios/Audio-Saturno.mp3',
    },
    {
      'name': 'Urano',
      'subtitle': 'Un gigante de hielo',
      'icon': 'assets/imagenes/Uranot.png',
      'color': Color(0xFF4DD0E1),
      'image': 'assets/imagenes/Uranot.png',
      'description':
      'Urano está compuesto de agua, metano y amoniaco sobre un pequeño centro rocoso. Su atmósfera está hecha de hidrógeno y helio, como Júpiter y Saturno, pero además contiene metano. El metano es lo que le da a Urano el color azul.\n\n'
      'Urano también tiene anillos tenues, los anillos internos son angostos y oscuros, los anillos externos tienen colores vivos y son más fáciles de ver, como venus, urano rota en dirección opuesta a la de la mayoría de los otros planetas.\n'
      'y a diferencia de cualquier otro planeta, urano rota de lado.',
      'distance: 2.870 millones de kilómetros'
      'day': '17 horas y 14 minutos',
      'year': ' 84 años',
      'moons': '28',
      'curiosities': [
      'Su eje de rotación está inclinado casi 97.8 grados, lo que significa que rota prácticamente acostado, como si rodara sobre su órbita, debido a un posible impacto gigante en su pasado.',
      'Debido a su inclinación, cada polo pasa 42 años de luz solar continua y otros 42 años en completa oscuridad.',
      'Es el planeta más frío: Su atmósfera registra temperaturas mínimas de hasta -224.2 °C, siendo la más gélida de todo el sistema solar, incluso más fría que la de Neptuno, que está más lejos',
      'Solo una nave creada por el ser humano lo ha visitado de cerca: la sonda Voyager 2 de la NASA en el año 1986.',
      'Color azul por el metano: Su atmósfera está compuesta de hidrógeno, helio y metano. Este último gas absorbe la luz roja y refleja el característico color azul verdoso del planeta',
      ],
      'videoUrl': 'https://www.youtube.com/watch?v=enkjdmFkgYk',
      'videoThumbnail': 'assets/imagenes/Pantalla_Urano.png',
      'audio': 'assets/audios/Audio-Urano.mp3',
    },
    {
      'name': 'Neptuno',
      'subtitle': 'El planeta más lejano',
      'icon': 'assets/imagenes/Neptunot.png',
      'color': Color(0xFF5C6BC0),
      'image': 'assets/imagenes/Neptunot.png',
      'description':
      'Neptuno es oscuro, frío y muy ventoso. Es el último planeta de nuestro sistema solar. Se encuentra a más de 30 veces la distancia de la Tierra al Sol. Neptuno es muy similar a Urano. Está formado por una densa niebla de agua, amoníaco y metano sobre un núcleo sólido del tamaño de la Tierra. Su atmósfera está compuesta de hidrógeno, helio y metano. El metano le da a Neptuno el mismo color azul que a Urano. Neptuno tiene seis anillos, pero son muy difíciles de ver.',
      'distance: 4.500 millones de kilómetros'
      'day': '16, horas',
      'year': '165 años',
      'moons': '16',
      'curiosities': [
      'Vientos extremos: Tiene los vientos más fuertes del sistema solar, los cuales pueden superar los 2.000 km/h.',
      'Fue el primer planeta descubierto gracias a cálculos matemáticos antes de ser observado por un telescopio en 1846.',
      'Órbita muy larga: Tarda 165 años terrestres en dar una vuelta completa alrededor del Sol',

      'No visible a simple vista: Es el único de los ocho planetas principales que no se puede ver desde la Tierra sin la ayuda de un telescopio.',
      '•  Su atmósfera contiene metano, un gas que absorbe la luz roja y refleja el característico color azul del planeta.',
      'La órbita de Tritón: Su luna más grande, Tritón, gira en dirección opuesta (retrógrada) a la rotación del planeta.',
      ],
      'videoUrl': 'hhttps://www.youtube.com/watch?v=boCOI-Rckp8',
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