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
              '¿Cuánto tarda aproximadamente Mercurio en completar una órbita?',
          options: ['88 días', '365 días', '225 días', '687 días'],
          correctAnswer: 0,
          explanation:
              'Mercurio tarda aproximadamente 88 días terrestres en orbitar el Sol.',
        ),
      ],

      'Superficie': [
        QuizQuestion(
          question: '¿Cómo es principalmente la superficie de Mercurio?',
          options: [
            'Cubierta de océanos',
            'Rocosa y llena de cráteres',
            'Cubierta de hielo',
            'Formada principalmente por gas',
          ],
          correctAnswer: 1,
          explanation:
              'Mercurio tiene una superficie rocosa con numerosos cráteres.',
        ),
      ],

      'Curiosidades': [
        QuizQuestion(
          question: '¿Mercurio tiene lunas naturales?',
          options: ['Sí, una', 'Sí, dos', 'Sí, muchas', 'No'],
          correctAnswer: 3,
          explanation: 'Mercurio no posee lunas naturales conocidas.',
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
            'Similar',
            'El doble',
            'Mucho más grande',
          ],
          correctAnswer: 1,
          explanation: 'Venus tiene un tamaño similar al de la Tierra.',
        ),
      ],

      'Atmósfera': [
        QuizQuestion(
          question: '¿Cómo es la atmósfera de Venus?',
          options: [
            'Muy delgada',
            'Muy densa',
            'No tiene atmósfera',
            'Está formada principalmente por oxígeno',
          ],
          correctAnswer: 1,
          explanation: 'Venus posee una atmósfera muy densa.',
        ),
      ],

      'Curiosidades': [
        QuizQuestion(
          question: '¿Venus tiene lunas?',
          options: ['Sí, una', 'Sí, dos', 'Sí, tres', 'No'],
          correctAnswer: 3,
          explanation: 'Venus no tiene lunas naturales conocidas.',
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
              'La Tierra tarda aproximadamente 365 días en completar una vuelta al Sol.',
        ),
      ],

      'Fauna': [
        QuizQuestion(
          question: '¿Cuál de estos animales es un mamífero?',
          options: ['Tiburón', 'Águila', 'Delfín', 'Cocodrilo'],
          correctAnswer: 2,
          explanation: 'El delfín es un mamífero marino.',
        ),
        QuizQuestion(
          question: '¿Cuál es el animal terrestre más grande?',
          options: ['Jirafa', 'Elefante africano', 'Rinoceronte', 'Hipopótamo'],
          correctAnswer: 1,
          explanation:
              'El elefante africano es el animal terrestre más grande.',
        ),
      ],

      'Flora': [
        QuizQuestion(
          question:
              '¿Qué proceso utilizan las plantas para producir su alimento?',
          options: ['Digestión', 'Fotosíntesis', 'Evaporación', 'Condensación'],
          correctAnswer: 1,
          explanation:
              'Las plantas producen su alimento mediante la fotosíntesis.',
        ),
      ],

      'Luna': [
        QuizQuestion(
          question: '¿Cuál es el satélite natural de la Tierra?',
          options: ['Europa', 'Titán', 'La Luna', 'Fobos'],
          correctAnswer: 2,
          explanation: 'La Luna es el satélite natural de la Tierra.',
        ),
        QuizQuestion(
          question: '¿La Luna es un planeta?',
          options: ['Sí', 'No', 'Solo algunas veces', 'Es una estrella'],
          correctAnswer: 1,
          explanation: 'La Luna es un satélite natural, no un planeta.',
        ),
      ],

      'Curiosidades': [
        QuizQuestion(
          question:
              '¿Qué porcentaje aproximado de la superficie terrestre está cubierta por agua?',
          options: ['10%', '30%', '71%', '95%'],
          correctAnswer: 2,
          explanation:
              'Aproximadamente el 71% de la superficie terrestre está cubierta por agua.',
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
            'Por sus océanos',
            'Por el hierro oxidado de su superficie',
            'Por sus anillos',
            'Por sus volcanes azules',
          ],
          correctAnswer: 1,
          explanation:
              'El óxido de hierro presente en su superficie le da su apariencia rojiza.',
        ),
      ],

      'Lunas': [
        QuizQuestion(
          question: '¿Cuántas lunas conocidas tiene Marte?',
          options: ['Una', 'Dos', 'Cuatro', 'Ninguna'],
          correctAnswer: 1,
          explanation: 'Marte tiene dos lunas: Fobos y Deimos.',
        ),
      ],

      'Superficie': [
        QuizQuestion(
          question: '¿Cómo es principalmente la superficie de Marte?',
          options: [
            'Rocosa',
            'Completamente líquida',
            'Gaseosa',
            'Cubierta completamente de hielo',
          ],
          correctAnswer: 0,
          explanation:
              'Marte posee una superficie rocosa y presenta volcanes, valles y cráteres.',
        ),
      ],

      'Curiosidades': [
        QuizQuestion(
          question: '¿Cómo se llaman las dos lunas de Marte?',
          options: [
            'Europa y Titán',
            'Fobos y Deimos',
            'Ío y Calisto',
            'Tritón y Miranda',
          ],
          correctAnswer: 1,
          explanation: 'Las lunas de Marte se llaman Fobos y Deimos.',
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
          explanation: 'Júpiter es el planeta más grande del Sistema Solar.',
        ),
        QuizQuestion(
          question: '¿Qué tipo de planeta es Júpiter?',
          options: ['Rocoso', 'Gigante gaseoso', 'Planeta enano', 'Satélite'],
          correctAnswer: 1,
          explanation: 'Júpiter es un gigante gaseoso.',
        ),
      ],

      'Lunas': [
        QuizQuestion(
          question: '¿Cuál de estas es una luna de Júpiter?',
          options: ['Europa', 'Fobos', 'Luna', 'Caronte'],
          correctAnswer: 0,
          explanation: 'Europa es una de las lunas de Júpiter.',
        ),
      ],

      'Gran Mancha Roja': [
        QuizQuestion(
          question: '¿Qué es la Gran Mancha Roja de Júpiter?',
          options: [
            'Un océano',
            'Una tormenta gigante',
            'Un volcán',
            'Una luna',
          ],
          correctAnswer: 1,
          explanation:
              'La Gran Mancha Roja es una enorme tormenta en la atmósfera de Júpiter.',
        ),
      ],

      'Curiosidades': [
        QuizQuestion(
          question: '¿Júpiter tiene anillos?',
          options: ['No', 'Sí', 'Solo uno', 'Solo durante el verano'],
          correctAnswer: 1,
          explanation:
              'Júpiter posee un sistema de anillos, aunque son poco visibles.',
        ),
      ],
    },

    // ============================================================
    // SATURNO
    // ============================================================
    'Saturno': {
      'Características': [
        QuizQuestion(
          question: '¿Por qué es conocido Saturno?',
          options: [
            'Por sus grandes anillos',
            'Por ser el planeta más pequeño',
            'Por no tener atmósfera',
            'Por ser el más cercano al Sol',
          ],
          correctAnswer: 0,
          explanation:
              'Saturno destaca por su impresionante sistema de anillos.',
        ),
      ],

      'Anillos': [
        QuizQuestion(
          question:
              '¿De qué están formados principalmente los anillos de Saturno?',
          options: [
            'De fuego',
            'De rocas y partículas de hielo',
            'De agua líquida',
            'De gas caliente',
          ],
          correctAnswer: 1,
          explanation:
              'Los anillos están formados principalmente por partículas de hielo y roca.',
        ),
      ],

      'Lunas': [
        QuizQuestion(
          question: '¿Cuál de estas es una luna de Saturno?',
          options: ['Titán', 'Europa', 'Fobos', 'Luna'],
          correctAnswer: 0,
          explanation: 'Titán es una de las lunas más conocidas de Saturno.',
        ),
      ],

      'Curiosidades': [
        QuizQuestion(
          question: '¿Saturno es un planeta gigante?',
          options: ['Sí', 'No', 'Es un planeta enano', 'Es una estrella'],
          correctAnswer: 0,
          explanation: 'Saturno es un gigante gaseoso.',
        ),
      ],
    },

    // ============================================================
    // URANO
    // ============================================================
    'Urano': {
      'Características': [
        QuizQuestion(
          question: '¿Qué posición ocupa Urano desde el Sol?',
          options: ['Sexta', 'Séptima', 'Octava', 'Quinta'],
          correctAnswer: 1,
          explanation: 'Urano es el séptimo planeta desde el Sol.',
        ),
      ],

      'Atmósfera': [
        QuizQuestion(
          question: '¿Qué elemento contribuye al color azul verdoso de Urano?',
          options: ['Metano', 'Hierro', 'Oxígeno líquido', 'Carbono sólido'],
          correctAnswer: 0,
          explanation:
              'El metano de su atmósfera absorbe luz roja y contribuye a su color azul verdoso.',
        ),
      ],

      'Lunas': [
        QuizQuestion(
          question: '¿Urano posee lunas?',
          options: ['Sí', 'No', 'Solo una', 'Solo dos'],
          correctAnswer: 0,
          explanation: 'Urano posee numerosas lunas conocidas.',
        ),
      ],

      'Curiosidades': [
        QuizQuestion(
          question: '¿Qué característica especial tiene la rotación de Urano?',
          options: [
            'Gira casi de lado',
            'No gira',
            'Gira en sentido contrario al Sol',
            'No tiene movimiento',
          ],
          correctAnswer: 0,
          explanation:
              'Urano tiene una inclinación axial extrema y parece girar de lado.',
        ),
      ],
    },

    // ============================================================
    // NEPTUNO
    // ============================================================
    'Neptuno': {
      'Características': [
        QuizQuestion(
          question: '¿Cuál es el planeta más alejado del Sol?',
          options: ['Urano', 'Saturno', 'Neptuno', 'Júpiter'],
          correctAnswer: 2,
          explanation: 'Neptuno es el octavo y más distante planeta del Sol.',
        ),
      ],

      'Atmósfera': [
        QuizQuestion(
          question: '¿Qué característica destaca en la atmósfera de Neptuno?',
          options: [
            'Vientos muy rápidos',
            'Ausencia total de gases',
            'Océanos de agua líquida',
            'Temperaturas similares a la Tierra',
          ],
          correctAnswer: 0,
          explanation:
              'Neptuno presenta algunos de los vientos más rápidos del Sistema Solar.',
        ),
      ],

      'Lunas': [
        QuizQuestion(
          question: '¿Cuál es la luna más grande de Neptuno?',
          options: ['Titán', 'Tritón', 'Europa', 'Fobos'],
          correctAnswer: 1,
          explanation: 'Tritón es la luna más grande de Neptuno.',
        ),
      ],

      'Curiosidades': [
        QuizQuestion(
          question: '¿Qué tipo de planeta es Neptuno?',
          options: [
            'Planeta rocoso',
            'Gigante de hielo',
            'Planeta enano',
            'Estrella',
          ],
          correctAnswer: 1,
          explanation: 'Neptuno es clasificado como un gigante de hielo.',
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
