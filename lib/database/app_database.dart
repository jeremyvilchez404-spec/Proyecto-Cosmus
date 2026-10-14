
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../data/quiz_data.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'cosmus.db');

    return openDatabase(
      path,
      version: 3,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await _createDatabase(db);
        await _seedQuizData(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await _seedQuizData(db);
        }

        if (oldVersion < 3) {
          await db.execute('''
            ALTER TABLE detalle_respuestas
            ADD COLUMN explicacion_guardada TEXT NOT NULL DEFAULT ''
          ''');
        }
      },
    );
  }

  Future<void> _createDatabase(Database db) async {
    await db.execute('''
      CREATE TABLE usuarios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        correo TEXT NOT NULL UNIQUE,
        password_hash TEXT NOT NULL,
        fecha_creacion TEXT NOT NULL,
        activo INTEGER NOT NULL DEFAULT 1
      )
    ''');

    await db.execute('''
      CREATE TABLE planetas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL UNIQUE
      )
    ''');

    await db.execute('''
      CREATE TABLE categorias (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        planeta_id INTEGER NOT NULL,
        nombre TEXT NOT NULL,
        orden INTEGER NOT NULL DEFAULT 0,
        UNIQUE (planeta_id, nombre),
        FOREIGN KEY (planeta_id)
          REFERENCES planetas(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE preguntas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        categoria_id INTEGER NOT NULL,
        enunciado TEXT NOT NULL,
        explicacion TEXT NOT NULL DEFAULT '',
        orden INTEGER NOT NULL DEFAULT 0,
        activa INTEGER NOT NULL DEFAULT 1,
        FOREIGN KEY (categoria_id)
          REFERENCES categorias(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE opciones_respuesta (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pregunta_id INTEGER NOT NULL,
        texto TEXT NOT NULL,
        es_correcta INTEGER NOT NULL DEFAULT 0,
        orden INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (pregunta_id)
          REFERENCES preguntas(id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE resultados_quiz (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        usuario_id INTEGER,
        planeta_id INTEGER NOT NULL,
        categoria_id INTEGER NOT NULL,
        puntuacion INTEGER NOT NULL,
        total_preguntas INTEGER NOT NULL,
        fecha TEXT NOT NULL,
        FOREIGN KEY (usuario_id)
          REFERENCES usuarios(id) ON DELETE SET NULL,
        FOREIGN KEY (planeta_id)
          REFERENCES planetas(id),
        FOREIGN KEY (categoria_id)
          REFERENCES categorias(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE detalle_respuestas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        resultado_id INTEGER NOT NULL,
        pregunta_id INTEGER,
        opcion_seleccionada_id INTEGER,
        es_correcta INTEGER NOT NULL,
        enunciado_guardado TEXT NOT NULL,
        opciones_guardadas TEXT NOT NULL,
        respuesta_correcta_guardada TEXT NOT NULL,
        respuesta_seleccionada_guardada TEXT,
        explicacion_guardada TEXT NOT NULL DEFAULT '',
        UNIQUE (resultado_id, pregunta_id),
        FOREIGN KEY (resultado_id)
          REFERENCES resultados_quiz(id) ON DELETE CASCADE,
        FOREIGN KEY (pregunta_id)
          REFERENCES preguntas(id) ON DELETE SET NULL,
        FOREIGN KEY (opcion_seleccionada_id)
          REFERENCES opciones_respuesta(id) ON DELETE SET NULL
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_resultados_usuario_fecha
      ON resultados_quiz(usuario_id, fecha)
    ''');

    await db.execute('''
      CREATE INDEX idx_preguntas_categoria
      ON preguntas(categoria_id, orden)
    ''');

    await db.execute('''
      CREATE INDEX idx_opciones_pregunta
      ON opciones_respuesta(pregunta_id, orden)
    ''');
  }

  Future<void> _seedQuizData(Database db) async {
    final existentes = await db.query(
      'planetas',
      columns: ['id'],
      limit: 1,
    );

    if (existentes.isNotEmpty) return;

    await db.transaction((txn) async {
      for (final planetaEntry in QuizData.quizzes.entries) {
        final planetaId = await txn.insert('planetas', {
          'nombre': planetaEntry.key,
        });

        var ordenCategoria = 0;

        for (final categoriaEntry in planetaEntry.value.entries) {
          final categoriaId = await txn.insert('categorias', {
            'planeta_id': planetaId,
            'nombre': categoriaEntry.key,
            'orden': ordenCategoria++,
          });

          var ordenPregunta = 0;

          for (final pregunta in categoriaEntry.value) {
            final preguntaId = await txn.insert('preguntas', {
              'categoria_id': categoriaId,
              'enunciado': pregunta.question,
              'explicacion': pregunta.explanation,
              'orden': ordenPregunta++,
              'activa': 1,
            });

            for (var i = 0; i < pregunta.options.length; i++) {
              await txn.insert('opciones_respuesta', {
                'pregunta_id': preguntaId,
                'texto': pregunta.options[i],
                'es_correcta':
                    i == pregunta.correctAnswer ? 1 : 0,
                'orden': i,
              });
            }
          }
        }
      }
    });
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
