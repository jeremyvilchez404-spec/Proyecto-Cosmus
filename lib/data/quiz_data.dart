import '../models/quiz_question.dart';

class QuizData {
  static const Map<String, Map<String, List<QuizQuestion>>> quizzes = {
    // ============================================================
    // MERCURIO
    // ============================================================
    'Mercurio': {
      'Características': [
        QuizQuestion(
          question: '¿Cuál es el planeta más cercano al Sol?',
          options: ['Venus', 'Marte', 'Mercurio', 'Tierra'],
          correctAnswer: 2,
          explanation: 'Mercurio es el planeta más cercano al Sol.',
        ),
        QuizQuestion(
          question: '¿Cuál es el planeta más pequeño del Sistema Solar?',
          options: ['Marte', 'Mercurio', 'Venus', 'Urano'],
          correctAnswer: 1,
          explanation: 'Mercurio es el planeta más pequeño del Sistema Solar.',
        ),
        QuizQuestion(
          question:
              '¿Cuánto tarda aproximadamente Mercurio en completar una órbita (su año)?',
          options: ['88 días', '365 días', '225 días', '687 días'],
          correctAnswer: 0,
          explanation:
              'Mercurio completa una vuelta alrededor del Sol en aproximadamente 88 días terrestres.',
        ),
        QuizQuestion(
          question: '¿Cuál es la distancia aproximada de Mercurio al Sol?',
          options: [
            '58 millones de km',
            '108 millones de km',
            '150 millones de km',
            '778 millones de km',
          ],
          correctAnswer: 0,
          explanation:
              'La distancia de Mercurio al Sol es de 58 millones de km.',
        ),
      ],

      'Superficie': [
        QuizQuestion(
          question: '¿Cómo es principalmente la superficie de Mercurio?',
          options: [
            'Cubierta de océanos',
            'Rocosa y cubierta de cráteres',
            'Cubierta de hielo',
            'Formada principalmente por gas',
          ],
          correctAnswer: 1,
          explanation:
              'Mercurio es un planeta rocoso, con una superficie cubierta de cráteres y una atmósfera extremadamente delgada.',
        ),
        QuizQuestion(
          question:
              '¿Cuánto dura aproximadamente un día solar completo en Mercurio (de un amanecer al siguiente)?',
          options: [
            '24 horas',
            '59 días terrestres',
            '176 días terrestres',
            '365 días',
          ],
          correctAnswer: 2,
          explanation:
              'Debido a su rotación y órbita, un día solar completo dura aproximadamente 176 días terrestres.',
        ),
      ],

      'Curiosidades': [
        QuizQuestion(
          question: '¿Mercurio tiene lunas naturales o anillos?',
          options: [
            'Sí, tiene una luna y anillos',
            'Tiene dos lunas',
            'Tiene muchos anillos',
            'No tiene lunas ni anillos',
          ],
          correctAnswer: 3,
          explanation: 'Mercurio no tiene lunas ni anillos.',
        ),
        QuizQuestion(
          question:
              'A pesar de estar más cerca del Sol, ¿por qué Mercurio no es el planeta más caliente?',
          options: [
            'Porque está muy lejos',
            'Porque Venus alcanza mayores temperaturas por su efecto invernadero',
            'Porque tiene hielo permanente',
            'Porque su atmósfera de oxígeno lo enfría',
          ],
          correctAnswer: 1,
          explanation:
              'Venus alcanza temperaturas superficiales mayores debido a su densa atmósfera y al fuerte efecto invernadero.',
        ),
      ],
    },

    // ============================================================
    // VENUS
    // ============================================================
    'Venus': {
      'Características': [
        QuizQuestion(
          question: '¿Cuál es el segundo planeta desde el Sol?',
          options: ['Mercurio', 'Venus', 'Tierra', 'Marte'],
          correctAnswer: 1,
          explanation: 'Venus es el segundo planeta desde el Sol.',
        ),
        QuizQuestion(
          question:
              '¿Cuál es aproximadamente el tamaño de Venus comparado con la Tierra?',
          options: [
            'Mucho más pequeño',
            'Muy parecido al de la Tierra',
            'El doble de grande',
            'Mucho más grande',
          ],
          correctAnswer: 1,
          explanation: 'Venus tiene un tamaño muy parecido al de la Tierra.',
        ),
        QuizQuestion(
          question: '¿Cuál es el planeta más caliente del Sistema Solar?',
          options: ['Mercurio', 'Venus', 'Júpiter', 'Marte'],
          correctAnswer: 1,
          explanation:
              'El intenso efecto invernadero provocado por el dióxido de carbono convierte a Venus en el planeta más caliente.',
        ),
      ],

      'Atmósfera': [
        QuizQuestion(
          question:
              '¿Cómo está compuesta principalmente la atmósfera de Venus?',
          options: [
            'Oxígeno y nitrógeno',
            'Dióxido de carbono con nubes de ácido sulfúrico',
            'Hidrógeno y helio',
            'Metano puro',
          ],
          correctAnswer: 1,
          explanation:
              'Venus posee una atmósfera extremadamente densa compuesta principalmente por dióxido de carbono y nubes de ácido sulfúrico.',
        ),
      ],

      'Curiosidades': [
        QuizQuestion(
          question:
              '¿Qué particularidad tiene la dirección de rotación de Venus?',
          options: [
            'Gira en la misma dirección que la Tierra',
            'No gira sobre su eje',
            'Gira en dirección contraria a la mayoría de los planetas',
            'Gira extremadamente rápido',
          ],
          correctAnswer: 2,
          explanation:
              'Venus gira muy lentamente y en dirección contraria a la mayoría de los planetas.',
        ),
        QuizQuestion(
          question: '¿Venus tiene lunas o anillos?',
          options: [
            'Sí, una luna',
            'Sí, dos lunas',
            'Sí, un anillo',
            'No tiene lunas ni anillos',
          ],
          correctAnswer: 3,
          explanation: 'Venus no tiene lunas ni anillos.',
        ),
        QuizQuestion(
          question:
              '¿Cómo es la duración del día de rotación en Venus comparado con su año?',
          options: [
            'Su día dura menos que su año',
            'Su día de rotación dura más que su año venusiano',
            'Duración exacta de 24 horas',
            'Tardan exactamente lo mismo',
          ],
          correctAnswer: 1,
          explanation:
              'Su rotación dura 243 días terrestres y su año 225 días, por lo que un día de rotación dura más que su año.',
        ),
      ],
    },

    // ============================================================
    // TIERRA
    // ============================================================
    'Tierra': {
      'Características': [
        QuizQuestion(
          question: '¿En qué posición se encuentra la Tierra respecto al Sol?',
          options: ['Primera', 'Segunda', 'Tercera', 'Cuarta'],
          correctAnswer: 2,
          explanation: 'La Tierra es el tercer planeta desde el Sol.',
        ),
        QuizQuestion(
          question: '¿Cuál es aproximadamente la duración de un año terrestre?',
          options: ['24 horas', '88 días', '365 días', '687 días'],
          correctAnswer: 2,
          explanation:
              'La Tierra tarda alrededor de 365 días en completar una vuelta alrededor del Sol.',
        ),
        QuizQuestion(
          question:
              '¿Cuánto tarda la Tierra en completar una rotación sobre su eje?',
          options: ['12 horas', '24 horas', '48 horas', '365 días'],
          correctAnswer: 1,
          explanation:
              'La Tierra tarda aproximadamente 24 horas en completar una rotación.',
        ),
      ],

      'Superficie y Agua': [
        QuizQuestion(
          question:
              '¿Qué porcentaje aproximado de la superficie terrestre está cubierto por agua?',
          options: ['50%', '61%', '71%', '90%'],
          correctAnswer: 2,
          explanation:
              'Aproximadamente el 71% de la superficie terrestre está cubierta por agua.',
        ),
        QuizQuestion(
          question:
              '¿Cómo está compuesta principalmente la atmósfera de la Tierra?',
          options: [
            'Dióxido de carbono y ácido sulfúrico',
            'Hidrógeno y helio',
            'Nitrógeno y oxígeno',
            'Metano y amoníaco',
          ],
          correctAnswer: 2,
          explanation:
              'La Tierra posee una atmósfera rica en nitrógeno y oxígeno que permite la vida.',
        ),
      ],

      'Curiosidades': [
        QuizQuestion(
          question: '¿Cuántas lunas naturales tiene la Tierra?',
          options: ['Ninguna', 'Una', 'Dos', 'Muchas'],
          correctAnswer: 1,
          explanation: 'La Tierra tiene una luna natural: la Luna.',
        ),
        QuizQuestion(
          question:
              '¿Qué la hace única en el Sistema Solar según la información?',
          options: [
            'Es el planeta más grande',
            'Es el único con anillos visibles',
            'Es el único planeta conocido con grandes cantidades de agua líquida y vida',
            'Tiene dos soles',
          ],
          correctAnswer: 2,
          explanation:
              'Es el único planeta conocido que posee grandes cantidades de agua líquida estable y vida.',
        ),
      ],
    },

    // ============================================================
    // MARTE
    // ============================================================
    'Marte': {
      'Características': [
        QuizQuestion(
          question: '¿Qué posición ocupa Marte desde el Sol?',
          options: ['Segundo', 'Tercero', 'Cuarto', 'Quinto'],
          correctAnswer: 2,
          explanation: 'Marte es el cuarto planeta desde el Sol.',
        ),
        QuizQuestion(
          question: '¿Por qué Marte es conocido como el planeta rojo?',
          options: [
            'Por sus grandes océanos de lava',
            'Por el hierro oxidado presente en sus rocas y polvo superficial',
            'Por su cercanía al Sol',
            'Por su atmósfera de fuego',
          ],
          correctAnswer: 1,
          explanation:
              'Se le llama así debido al hierro oxidado presente en sus rocas y polvo superficial.',
        ),
        QuizQuestion(
          question: '¿Cómo se le llama a un día solar marciano?',
          options: ['Ciclo', 'Sol', 'Jornada', 'Rot'],
          correctAnswer: 1,
          explanation: 'Un día solar marciano recibe el nombre de sol.',
        ),
      ],

      'Lunas y Superficie': [
        QuizQuestion(
          question: '¿Cómo se llaman las dos pequeñas lunas de Marte?',
          options: [
            'Europa y Calisto',
            'Titán y Encélado',
            'Fobos y Deimos',
            'Tritón y Miranda',
          ],
          correctAnswer: 2,
          explanation:
              'Marte posee dos pequeñas lunas llamadas Fobos y Deimos.',
        ),
        QuizQuestion(
          question: '¿Cuánto dura aproximadamente un año en Marte?',
          options: [
            '365 días terrestres',
            '687 días terrestres',
            '88 días terrestres',
            '12 años',
          ],
          correctAnswer: 1,
          explanation: 'Su año dura aproximadamente 687 días terrestres.',
        ),
      ],

      'Curiosidades': [
        QuizQuestion(
          question:
              '¿Cuál es el nombre del volcán más grande conocido del Sistema Solar ubicado en Marte?',
          options: [
            'Monte Everest',
            'Olympus Mons',
            'Valles Marineris',
            'Mauna Kea',
          ],
          correctAnswer: 1,
          explanation:
              'Marte posee Olympus Mons, el volcán más grande conocido del sistema solar.',
        ),
      ],
    },

    // ============================================================
    // JÚPITER
    // ============================================================
    'Júpiter': {
      'Características': [
        QuizQuestion(
          question: '¿Cuál es el planeta más grande del Sistema Solar?',
          options: ['Saturno', 'Tierra', 'Júpiter', 'Neptuno'],
          correctAnswer: 2,
          explanation:
              'Júpiter es el planeta más grande del sistema solar y el quinto desde el Sol.',
        ),
        QuizQuestion(
          question: '¿Qué tipo de cuerpo celeste es Júpiter?',
          options: [
            'Planeta rocoso',
            'Gigante gaseoso',
            'Gigante de hielo',
            'Planeta enano',
          ],
          correctAnswer: 1,
          explanation:
              'Es un gigante gaseoso compuesto principalmente por hidrógeno y helio.',
        ),
        QuizQuestion(
          question: '¿Cuánto dura una rotación completa en Júpiter (su día)?',
          options: ['9,9 horas', '24 horas', '10,7 horas', '59 días'],
          correctAnswer: 0,
          explanation:
              'Una rotación completa tarda aproximadamente 9,9 horas, siendo el día más corto del sistema solar.',
        ),
      ],

      'Lunas y Tormentas': [
        QuizQuestion(
          question: '¿Qué es la Gran Mancha Roja de Júpiter?',
          options: [
            'Un cráter gigante',
            'Un volcán activo',
            'Una enorme tormenta atmosférica',
            'Un lago de lava',
          ],
          correctAnswer: 2,
          explanation:
              'La atmósfera de Júpiter presenta bandas de nubes y enormes tormentas, entre ellas la Gran Mancha Roja.',
        ),
        QuizQuestion(
          question:
              'Según los datos de la NASA, ¿cuántas lunas reconocidas oficialmente tiene Júpiter?',
          options: ['1', '12', '79', '115'],
          correctAnswer: 3,
          explanation:
              'Actualmente la NASA indica que Júpiter tiene 115 lunas reconocidas oficialmente.',
        ),
        QuizQuestion(
          question: '¿Cómo se llaman las lunas más destacadas de Júpiter?',
          options: [
            'Lunas galileanas (Ío, Europa, Ganímedes y Calisto)',
            'Fobos y Deimos',
            'Titán y Encélado',
            'Tritón y Proteo',
          ],
          correctAnswer: 0,
          explanation:
              'Destacan Ío, Europa, Ganímedes y Calisto, conocidas como las lunas galileanas.',
        ),
      ],

      'Curiosidades': [
        QuizQuestion(
          question:
              '¿Cuál es el satélite natural más grande del Sistema Solar?',
          options: ['La Luna', 'Titán', 'Ganímedes', 'Europa'],
          correctAnswer: 2,
          explanation:
              'Ganímedes, una de las lunas de Júpiter, es el satélite natural más grande del sistema solar.',
        ),
      ],
    },

    // ============================================================
    // SATURNO
    // ============================================================
    'Saturno': {
      'Características': [
        QuizQuestion(
          question:
              '¿Qué posición ocupa Saturno desde el Sol y qué lugar en tamaño ocupa?',
          options: [
            'Séptimo planeta y el más pequeño',
            'Sexto planeta y el segundo más grande del sistema solar',
            'Quinto planeta y el primero en tamaño',
            'Octavo planeta y gigante de hielo',
          ],
          correctAnswer: 1,
          explanation:
              'Saturno es el sexto planeta desde el Sol y el segundo planeta más grande del sistema solar.',
        ),
        QuizQuestion(
          question:
              '¿De qué están formados principalmente los famosos anillos de Saturno?',
          options: [
            'Gas y fuego',
            'Fragmentos de hielo y roca',
            'Puro metal líquido',
            'Polvo estelar magnético',
          ],
          correctAnswer: 1,
          explanation:
              'Sus anillos están formados principalmente por fragmentos de hielo y roca de diferentes tamaños.',
        ),
      ],

      'Rotación y Lunas': [
        QuizQuestion(
          question: '¿Cuánto dura un día en Saturno (su rotación)?',
          options: ['9,9 horas', '10,7 horas', '17 horas', '24 horas'],
          correctAnswer: 1,
          explanation:
              'Saturno completa una rotación en aproximadamente 10,7 horas.',
        ),
        QuizQuestion(
          question:
              '¿Cuántas lunas confirmadas tenía Saturno según el reporte de la NASA en marzo de 2025?',
          options: ['15', '82', '115', '274'],
          correctAnswer: 3,
          explanation:
              'Según NASA, Saturno tenía 274 lunas confirmadas en marzo de 2025.',
        ),
        QuizQuestion(
          question: '¿Cuáles son dos de las lunas más conocidas de Saturno?',
          options: [
            'Fobos y Deimos',
            'Titán y Encélado',
            'Ío y Europa',
            'Tritón y Miranda',
          ],
          correctAnswer: 1,
          explanation:
              'Entre sus lunas más conocidas se encuentran Titán y Encélado.',
        ),
      ],

      'Curiosidades': [
        QuizQuestion(
          question:
              '¿Qué estructura inusual existe en el polo norte de Saturno?',
          options: [
            'Una tormenta cuadrada',
            'Una enorme estructura atmosférica con forma hexagonal',
            'Un anillo interior brillante',
            'Un cráter de impacto gigante',
          ],
          correctAnswer: 1,
          explanation:
              'En el polo norte de Saturno existe una enorme estructura atmosférica con forma hexagonal.',
        ),
      ],
    },

    // ============================================================
    // URANO
    // ============================================================
    'Urano': {
      'Características': [
        QuizQuestion(
          question: '¿Qué tipo de planeta es Urano?',
          options: [
            'Planeta rocoso',
            'Gigante gaseoso',
            'Gigante de hielo',
            'Planeta enano',
          ],
          correctAnswer: 2,
          explanation:
              'Urano es el séptimo planeta desde el Sol y uno de los dos gigantes de hielo del sistema solar.',
        ),
        QuizQuestion(
          question:
              '¿Qué elemento químico en su atmósfera absorbe luz roja y le da su color azul verdoso?',
          options: ['Metano', 'Helio', 'Oxígeno', 'Amoníaco'],
          correctAnswer: 0,
          explanation:
              'El metano absorbe parte de la luz roja y contribuye al color azul verdoso característico de Urano.',
        ),
      ],

      'Inclinación y Lunas': [
        QuizQuestion(
          question:
              '¿Cuál es la inclinación axial de Urano que lo hace girar de lado?',
          options: ['23,5 grados', '45 grados', '97,8 grados', '180 grados'],
          correctAnswer: 2,
          explanation:
              'Urano tiene una inclinación axial de aproximadamente 97,8 grados y parece girar prácticamente de lado.',
        ),
        QuizQuestion(
          question: '¿Cuántas lunas conocidas tiene Urano?',
          options: ['16', '28', '115', '274'],
          correctAnswer: 1,
          explanation:
              'Urano tiene 28 lunas conocidas y un sistema de anillos tenues.',
        ),
        QuizQuestion(
          question: '¿Cuánto dura un año en Urano?',
          options: [
            '29,4 años terrestres',
            '84 años terrestres',
            '165 años terrestres',
            '12 años terrestres',
          ],
          correctAnswer: 1,
          explanation:
              'Urano tarda unos 84 años terrestres en completar una vuelta alrededor del Sol.',
        ),
      ],

      'Curiosidades': [
        QuizQuestion(
          question: '¿Qué nave espacial visitó de cerca a Urano en 1986?',
          options: ['Voyager 1', 'Voyager 2', 'Cassini', 'New Horizons'],
          correctAnswer: 1,
          explanation:
              'Urano fue visitado de cerca por la sonda Voyager 2 en 1986.',
        ),
      ],
    },

    // ============================================================
    // NEPTUNO
    // ============================================================
    'Neptuno': {
      'Características': [
        QuizQuestion(
          question:
              '¿Cuál es el octavo y más lejano de los ocho planetas del Sistema Solar?',
          options: ['Urano', 'Saturno', 'Neptuno', 'Júpiter'],
          correctAnswer: 2,
          explanation:
              'Neptuno es el octavo y más lejano de los ocho planetas del sistema solar.',
        ),
        QuizQuestion(
          question: '¿Qué tipo de planeta es Neptuno?',
          options: [
            'Planeta rocoso',
            'Gigante de hielo',
            'Gigante gaseoso',
            'Estrella enana',
          ],
          correctAnswer: 1,
          explanation:
              'Es un gigante de hielo, oscuro, frío y conocido por sus fuertes vientos.',
        ),
        QuizQuestion(
          question:
              '¿Cuánto tarda Neptuno en completar una vuelta alrededor del Sol?',
          options: [
            '84 años terrestres',
            '165 años terrestres',
            '365 años terrestres',
            '12 años terrestres',
          ],
          correctAnswer: 1,
          explanation:
              'Neptuno necesita aproximadamente 165 años terrestres para completar una órbita.',
        ),
      ],

      'Lunas y Atmósfera': [
        QuizQuestion(
          question:
              '¿Cómo se llama la luna más grande de Neptuno que posee órbita retrógrada?',
          options: ['Titán', 'Tritón', 'Europa', 'Ganímedes'],
          correctAnswer: 1,
          explanation:
              'La más grande es Tritón, que posee una órbita retrógrada (se mueve en dirección opuesta a la rotación del planeta).',
        ),
        QuizQuestion(
          question: '¿Cuántas lunas conocidas tiene Neptuno?',
          options: ['8', '16', '28', '274'],
          correctAnswer: 1,
          explanation: 'Neptuno tiene 16 lunas conocidas.',
        ),
      ],

      'Curiosidades': [
        QuizQuestion(
          question: '¿De qué forma particular fue descubierto Neptuno?',
          options: [
            'Por casualidad con un telescopio casero',
            'Mediante predicciones matemáticas antes de su observación visual',
            'Visto por primera vez desde la Luna',
            'Detectado por sondas espaciales automáticas',
          ],
          correctAnswer: 1,
          explanation:
              'Neptuno fue el primer planeta descubierto mediante predicciones matemáticas antes de su observación.',
        ),
      ],
    },
  };

  // ============================================================
  // CATEGORÍAS
  // ============================================================

  static List<String> getCategories(String planet) {
    return quizzes[planet]?.keys.toList() ?? [];
  }

  // ============================================================
  // PREGUNTAS
  // ============================================================

  static List<QuizQuestion> getQuestions(String planet, String category) {
    return quizzes[planet]?[category] ?? [];
  }
}
