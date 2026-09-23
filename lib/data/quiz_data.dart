import '../models/quiz_question.dart';

class QuizData {
  static const Map<String, List<QuizQuestion>> quizzes = {
    'Mercurio': [
      QuizQuestion(
        question: '¿Cuál es el planeta más cercano al Sol?',
        options: ['Venus', 'Marte', 'Mercurio', 'Tierra'],
        correctAnswer: 2,
        explanation: 'Mercurio es el planeta más cercano al Sol.',
      ),
      QuizQuestion(
        question: '¿Cuál es el planeta más pequeño del Sistema Solar?',
        options: ['Marte', 'Mercurio', 'Venus', 'Neptuno'],
        correctAnswer: 1,
        explanation: 'Mercurio es el planeta más pequeño del Sistema Solar.',
      ),
      QuizQuestion(
        question:
            '¿Cuánto tarda aproximadamente Mercurio en dar una vuelta al Sol?',
        options: ['24 días', '88 días', '365 días', '687 días'],
        correctAnswer: 1,
        explanation:
            'Mercurio tarda aproximadamente 88 días terrestres en completar una órbita.',
      ),
      QuizQuestion(
        question: '¿Cuántas lunas tiene Mercurio?',
        options: ['Una', 'Dos', 'Muchas', 'Ninguna'],
        correctAnswer: 3,
        explanation: 'Mercurio no tiene lunas.',
      ),
      QuizQuestion(
        question: '¿Mercurio es un planeta rocoso?',
        options: ['Sí', 'No', 'Es gaseoso', 'Es de hielo'],
        correctAnswer: 0,
        explanation:
            'Mercurio es uno de los planetas rocosos del Sistema Solar.',
      ),
    ],

    'Venus': [
      QuizQuestion(
        question: '¿Cuál es el segundo planeta desde el Sol?',
        options: ['Marte', 'Venus', 'Tierra', 'Mercurio'],
        correctAnswer: 1,
        explanation: 'Venus es el segundo planeta desde el Sol.',
      ),
      QuizQuestion(
        question: '¿Cuál es el planeta más caliente del Sistema Solar?',
        options: ['Mercurio', 'Marte', 'Venus', 'Tierra'],
        correctAnswer: 2,
        explanation: 'Venus es el planeta más caliente del Sistema Solar.',
      ),
      QuizQuestion(
        question: '¿Cuántas lunas tiene Venus?',
        options: ['Una', 'Dos', 'Muchas', 'Ninguna'],
        correctAnswer: 3,
        explanation: 'Venus no tiene lunas.',
      ),
      QuizQuestion(
        question: '¿A qué planeta se parece Venus en tamaño?',
        options: ['Júpiter', 'La Tierra', 'Neptuno', 'Mercurio'],
        correctAnswer: 1,
        explanation: 'Venus tiene un tamaño parecido al de la Tierra.',
      ),
      QuizQuestion(
        question: '¿Venus es un planeta rocoso?',
        options: ['Sí', 'No', 'Es gaseoso', 'Es de hielo'],
        correctAnswer: 0,
        explanation: 'Venus es un planeta rocoso.',
      ),
    ],

    'Tierra': [
      QuizQuestion(
        question: '¿Qué posición ocupa la Tierra desde el Sol?',
        options: ['Primera', 'Segunda', 'Tercera', 'Cuarta'],
        correctAnswer: 2,
        explanation: 'La Tierra es el tercer planeta desde el Sol.',
      ),
      QuizQuestion(
        question: '¿Cómo se llama el satélite natural de la Tierra?',
        options: ['Europa', 'Luna', 'Titán', 'Fobos'],
        correctAnswer: 1,
        explanation: 'La Luna es el satélite natural de la Tierra.',
      ),
      QuizQuestion(
        question: '¿En qué planeta conocemos que existe vida?',
        options: ['Marte', 'Venus', 'Tierra', 'Júpiter'],
        correctAnswer: 2,
        explanation:
            'La Tierra es el único planeta donde conocemos que existe vida.',
      ),
      QuizQuestion(
        question: '¿La Tierra es un planeta rocoso?',
        options: ['Sí', 'No', 'Es gaseoso', 'Es de hielo'],
        correctAnswer: 0,
        explanation: 'La Tierra es un planeta rocoso.',
      ),
      QuizQuestion(
        question:
            '¿Cuánto tarda aproximadamente la Tierra en dar una vuelta al Sol?',
        options: ['24 horas', '88 días', '365 días', '687 días'],
        correctAnswer: 2,
        explanation:
            'La Tierra tarda aproximadamente 365 días en completar una órbita.',
      ),
    ],

    'Marte': [
      QuizQuestion(
        question: '¿Qué posición ocupa Marte desde el Sol?',
        options: ['Segunda', 'Tercera', 'Cuarta', 'Quinta'],
        correctAnswer: 2,
        explanation: 'Marte es el cuarto planeta desde el Sol.',
      ),
      QuizQuestion(
        question: '¿De qué color suele verse Marte?',
        options: ['Azul', 'Rojo', 'Verde', 'Amarillo'],
        correctAnswer: 1,
        explanation: 'Marte es conocido como el planeta rojo.',
      ),
      QuizQuestion(
        question: '¿Cómo se conoce comúnmente a Marte?',
        options: [
          'El planeta azul',
          'El planeta gigante',
          'El planeta rojo',
          'El planeta de los anillos',
        ],
        correctAnswer: 2,
        explanation:
            'Marte es conocido como el planeta rojo por su apariencia rojiza.',
      ),
      QuizQuestion(
        question: '¿Cuántas lunas tiene Marte?',
        options: ['Ninguna', 'Una', 'Dos', 'Ocho'],
        correctAnswer: 2,
        explanation: 'Marte tiene dos lunas: Fobos y Deimos.',
      ),
      QuizQuestion(
        question: '¿Marte es un planeta rocoso?',
        options: ['Sí', 'No', 'Es gaseoso', 'Es una estrella'],
        correctAnswer: 0,
        explanation: 'Marte es un planeta rocoso.',
      ),
    ],

    'Júpiter': [
      QuizQuestion(
        question: '¿Qué posición ocupa Júpiter desde el Sol?',
        options: ['Cuarta', 'Quinta', 'Sexta', 'Séptima'],
        correctAnswer: 1,
        explanation: 'Júpiter es el quinto planeta desde el Sol.',
      ),
      QuizQuestion(
        question: '¿Cuál es el planeta más grande del Sistema Solar?',
        options: ['Saturno', 'Neptuno', 'Júpiter', 'Urano'],
        correctAnswer: 2,
        explanation: 'Júpiter es el planeta más grande del Sistema Solar.',
      ),
      QuizQuestion(
        question: '¿Qué tipo de planeta es Júpiter?',
        options: [
          'Planeta rocoso',
          'Gigante gaseoso',
          'Gigante de hielo',
          'Estrella',
        ],
        correctAnswer: 1,
        explanation: 'Júpiter es un gigante gaseoso.',
      ),
      QuizQuestion(
        question: '¿Qué característica famosa tiene Júpiter?',
        options: [
          'Una gran mancha roja',
          'Un gran océano',
          'Un solo anillo',
          'Una gran montaña blanca',
        ],
        correctAnswer: 0,
        explanation:
            'Júpiter tiene una enorme tormenta conocida como la Gran Mancha Roja.',
      ),
      QuizQuestion(
        question: '¿Júpiter es más grande que la Tierra?',
        options: ['Sí', 'No', 'Tienen el mismo tamaño', 'Es más pequeño'],
        correctAnswer: 0,
        explanation: 'Júpiter es mucho más grande que la Tierra.',
      ),
    ],

    'Saturno': [
      QuizQuestion(
        question: '¿Qué posición ocupa Saturno desde el Sol?',
        options: ['Quinta', 'Sexta', 'Séptima', 'Octava'],
        correctAnswer: 1,
        explanation: 'Saturno es el sexto planeta desde el Sol.',
      ),
      QuizQuestion(
        question: '¿Por qué es famoso Saturno?',
        options: [
          'Por sus grandes anillos',
          'Por ser rojo',
          'Por no tener atmósfera',
          'Por estar cerca del Sol',
        ],
        correctAnswer: 0,
        explanation:
            'Saturno es famoso por su espectacular sistema de anillos.',
      ),
      QuizQuestion(
        question: '¿Qué tipo de planeta es Saturno?',
        options: [
          'Planeta rocoso',
          'Gigante gaseoso',
          'Gigante de hielo',
          'Estrella',
        ],
        correctAnswer: 1,
        explanation: 'Saturno es un gigante gaseoso.',
      ),
      QuizQuestion(
        question: '¿Saturno es más grande que la Tierra?',
        options: ['Sí', 'No', 'Son iguales', 'Es más pequeño'],
        correctAnswer: 0,
        explanation: 'Saturno es mucho más grande que la Tierra.',
      ),
      QuizQuestion(
        question: '¿Cuál es el segundo planeta más grande del Sistema Solar?',
        options: ['Marte', 'Venus', 'Saturno', 'Mercurio'],
        correctAnswer: 2,
        explanation:
            'Saturno es el segundo planeta más grande del Sistema Solar.',
      ),
    ],

    'Urano': [
      QuizQuestion(
        question: '¿Qué posición ocupa Urano desde el Sol?',
        options: ['Sexta', 'Séptima', 'Octava', 'Quinta'],
        correctAnswer: 1,
        explanation: 'Urano es el séptimo planeta desde el Sol.',
      ),
      QuizQuestion(
        question: '¿Qué tipo de planeta es Urano?',
        options: [
          'Planeta rocoso',
          'Gigante de hielo',
          'Estrella',
          'Planeta terrestre',
        ],
        correctAnswer: 1,
        explanation:
            'Urano es uno de los dos gigantes de hielo del Sistema Solar.',
      ),
      QuizQuestion(
        question: '¿Qué característica especial tiene Urano?',
        options: [
          'Gira prácticamente de lado',
          'No gira',
          'Está cerca del Sol',
          'No tiene atmósfera',
        ],
        correctAnswer: 0,
        explanation:
            'Urano tiene una inclinación extrema y parece girar de lado.',
      ),
      QuizQuestion(
        question: '¿Urano tiene anillos?',
        options: ['Sí', 'No', 'Solo uno', 'No se sabe'],
        correctAnswer: 0,
        explanation: 'Urano tiene un sistema de anillos.',
      ),
      QuizQuestion(
        question: '¿Urano es más grande que la Tierra?',
        options: ['Sí', 'No', 'Son iguales', 'Es más pequeño'],
        correctAnswer: 0,
        explanation: 'Urano es mucho más grande que la Tierra.',
      ),
    ],

    'Neptuno': [
      QuizQuestion(
        question: '¿Qué posición ocupa Neptuno desde el Sol?',
        options: ['Sexta', 'Séptima', 'Octava', 'Quinta'],
        correctAnswer: 2,
        explanation: 'Neptuno es el octavo planeta desde el Sol.',
      ),
      QuizQuestion(
        question: '¿Cuál es el planeta más lejano del Sol?',
        options: ['Saturno', 'Urano', 'Neptuno', 'Júpiter'],
        correctAnswer: 2,
        explanation: 'Neptuno es el planeta más lejano del Sol.',
      ),
      QuizQuestion(
        question: '¿Qué tipo de planeta es Neptuno?',
        options: [
          'Planeta rocoso',
          'Gigante de hielo',
          'Estrella',
          'Planeta terrestre',
        ],
        correctAnswer: 1,
        explanation: 'Neptuno es un gigante de hielo.',
      ),
      QuizQuestion(
        question: '¿De qué color suele verse Neptuno?',
        options: ['Azul', 'Rojo', 'Amarillo', 'Verde'],
        correctAnswer: 0,
        explanation: 'Neptuno presenta un característico color azul.',
      ),
      QuizQuestion(
        question: '¿Neptuno es más grande que la Tierra?',
        options: ['Sí', 'No', 'Son iguales', 'Es más pequeño'],
        correctAnswer: 0,
        explanation: 'Neptuno es más grande que la Tierra.',
      ),
    ],

    'Sol': [
      QuizQuestion(
        question: '¿Qué es el Sol?',
        options: [
          'Un planeta gaseoso',
          'Una estrella',
          'Un satélite natural',
          'Un cometa',
        ],
        correctAnswer: 1,
        explanation:
            'El Sol es la estrella situada en el centro del Sistema Solar.',
      ),
      QuizQuestion(
        question: '¿Qué posición ocupa el Sol en nuestro sistema planetario?',
        options: [
          'Está al final',
          'En el centro',
          'Gira con la Tierra',
          'En la orilla',
        ],
        correctAnswer: 1,
        explanation:
            'El Sol se encuentra en el centro del Sistema Solar y todos los planetas orbitan a su alrededor.',
      ),
      QuizQuestion(
        question: '¿De qué está compuesto principalmente el Sol?',
        options: [
          'Roca y agua',
          'Hierro y níquel',
          'Hidrógeno y helio',
          'Oxígeno y nitrógeno',
        ],
        correctAnswer: 2,
        explanation:
            'El Sol es una gran bola de plasma formada principalmente por hidrógeno y helio.',
      ),
      QuizQuestion(
        question: '¿El Sol produce su propia luz y calor?',
        options: ['Sí', 'No', 'Solo refleja la luz', 'Solo durante el día'],
        correctAnswer: 0,
        explanation:
            'El Sol genera su propia luz y energía mediante la fusión nuclear en su núcleo.',
      ),
      QuizQuestion(
        question: '¿Qué es el Sol en comparación con la Tierra?',
        options: [
          'Mucho más pequeño',
          'Del mismo tamaño',
          'Mucho más grande',
          'Un poco más pequeño',
        ],
        correctAnswer: 2,
        explanation:
            'El Sol es gigantesco; cabrían más de un millón de Tierras dentro de él.',
      ),
    ],
  };
}
