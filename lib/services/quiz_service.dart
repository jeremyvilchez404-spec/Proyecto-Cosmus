
import 'dart:convert';

import 'package:sqflite/sqflite.dart';

import '../database/app_database.dart';

class QuizService {
  QuizService._();

  static final QuizService instance = QuizService._();

  Future<List<String>> getCategories(String planetName) async {
    final db = await AppDatabase.instance.database;

    final rows = await db.rawQuery(
      '''
      SELECT c.nombre
      FROM categorias c
      INNER JOIN planetas p ON p.id = c.planeta_id
      WHERE p.nombre = ?
      ORDER BY c.orden
      ''',
      [planetName],
    );

    return rows.map((row) => row['nombre'] as String).toList();
  }

  Future<List<Map<String, dynamic>>> getQuestions(
    String planetName,
    String categoryName,
  ) async {
    final db = await AppDatabase.instance.database;

    final questions = await db.rawQuery(
      '''
      SELECT q.id, q.enunciado, q.explicacion, q.orden
      FROM preguntas q
      INNER JOIN categorias c ON c.id = q.categoria_id
      INNER JOIN planetas p ON p.id = c.planeta_id
      WHERE p.nombre = ?
        AND c.nombre = ?
        AND q.activa = 1
      ORDER BY q.orden
      ''',
      [planetName, categoryName],
    );

    final result = <Map<String, dynamic>>[];

    for (final question in questions) {
      final options = await db.query(
        'opciones_respuesta',
        where: 'pregunta_id = ?',
        whereArgs: [question['id']],
        orderBy: 'orden',
      );

      result.add({
        'id': question['id'],
        'question': question['enunciado'],
        'explanation': question['explicacion'],
        'options': options.map((option) {
          return option['texto'] as String;
        }).toList(),
        'correctAnswer': options.indexWhere(
          (option) => option['es_correcta'] == 1,
        ),
      });
    }

    return result;
  }

  Future<int> saveQuizResult({
    required int? usuarioId,
    required String planetName,
    required String categoryName,
    required int score,
    required int totalQuestions,
  }) async {
    if (totalQuestions <= 0 ||
        score < 0 ||
        score > totalQuestions) {
      throw ArgumentError('La puntuación no es válida.');
    }

    final db = await AppDatabase.instance.database;

    return db.transaction<int>((txn) async {
      final ids = await _getQuizIds(
        txn,
        planetName,
        categoryName,
        usuarioId,
      );

      final now = DateTime.now().toIso8601String();

      final existing = await _getLatestResult(
        txn,
        usuarioId,
        ids['planetId']!,
        ids['categoryId']!,
      );

      if (existing != null) {
        final resultId = existing['id'] as int;

        await txn.update(
          'resultados_quiz',
          {
            'puntuacion': score,
            'total_preguntas': totalQuestions,
            'fecha': now,
          },
          where: 'id = ?',
          whereArgs: [resultId],
        );

        return resultId;
      }

      return txn.insert('resultados_quiz', {
        'usuario_id': usuarioId,
        'planeta_id': ids['planetId'],
        'categoria_id': ids['categoryId'],
        'puntuacion': score,
        'total_preguntas': totalQuestions,
        'fecha': now,
      });
    });
  }

  Future<void> saveAnswerDetails({
    required int resultadoId,
    required List<Map<String, dynamic>> respuestas,
  }) async {
    final db = await AppDatabase.instance.database;

    await db.transaction<void>((txn) async {
      await txn.delete(
        'detalle_respuestas',
        where: 'resultado_id = ?',
        whereArgs: [resultadoId],
      );

      for (final respuesta in respuestas) {
        await _insertAnswerDetail(txn, resultadoId, respuesta);
      }
    });
  }

  Future<int> saveQuizAttempt({
    required int? usuarioId,
    required String planetName,
    required String categoryName,
    required int score,
    required int totalQuestions,
    required List<Map<String, dynamic>> respuestas,
  }) async {
    if (totalQuestions <= 0 ||
        score < 0 ||
        score > totalQuestions ||
        respuestas.length != totalQuestions) {
      throw ArgumentError(
        'Los datos del cuestionario no son válidos.',
      );
    }

    final db = await AppDatabase.instance.database;

    return db.transaction<int>((txn) async {
      final ids = await _getQuizIds(
        txn,
        planetName,
        categoryName,
        usuarioId,
      );

      final planetId = ids['planetId']!;
      final categoryId = ids['categoryId']!;

      final existing = await _getLatestResult(
        txn,
        usuarioId,
        planetId,
        categoryId,
      );

      final now = DateTime.now().toIso8601String();
      late final int resultadoId;

      if (existing != null) {
        resultadoId = existing['id'] as int;

        // Actualiza el resultado existente.
        await txn.update(
          'resultados_quiz',
          {
            'puntuacion': score,
            'total_preguntas': totalQuestions,
            'fecha': now,
          },
          where: 'id = ?',
          whereArgs: [resultadoId],
        );

        // Elimina únicamente los detalles del resultado actualizado.
        // Se insertarán de nuevo con las respuestas más recientes.
        await txn.delete(
          'detalle_respuestas',
          where: 'resultado_id = ?',
          whereArgs: [resultadoId],
        );
      } else {
        resultadoId = await txn.insert('resultados_quiz', {
          'usuario_id': usuarioId,
          'planeta_id': planetId,
          'categoria_id': categoryId,
          'puntuacion': score,
          'total_preguntas': totalQuestions,
          'fecha': now,
        });
      }

      for (final respuesta in respuestas) {
        await _insertAnswerDetail(
          txn,
          resultadoId,
          respuesta,
        );
      }

      return resultadoId;
    });
  }

  Future<Map<String, int>> _getQuizIds(
    Transaction txn,
    String planetName,
    String categoryName,
    int? usuarioId,
  ) async {
    final planetRows = await txn.query(
      'planetas',
      columns: ['id'],
      where: 'nombre = ?',
      whereArgs: [planetName],
      limit: 1,
    );

    if (planetRows.isEmpty) {
      throw StateError('No se encontró el planeta: $planetName');
    }

    final planetId = planetRows.first['id'] as int;

    final categoryRows = await txn.query(
      'categorias',
      columns: ['id'],
      where: 'planeta_id = ? AND nombre = ?',
      whereArgs: [planetId, categoryName],
      limit: 1,
    );

    if (categoryRows.isEmpty) {
      throw StateError('No se encontró la categoría: $categoryName');
    }

    final categoryId = categoryRows.first['id'] as int;

    if (usuarioId != null) {
      final userRows = await txn.query(
        'usuarios',
        columns: ['id'],
        where: 'id = ? AND activo = ?',
        whereArgs: [usuarioId, 1],
        limit: 1,
      );

      if (userRows.isEmpty) {
        throw StateError('No se encontró el usuario activo.');
      }
    }

    return {
      'planetId': planetId,
      'categoryId': categoryId,
    };
  }

  Future<Map<String, Object?>?> _getLatestResult(
    Transaction txn,
    int? usuarioId,
    int planetId,
    int categoryId,
  ) async {
    final rows = await txn.query(
      'resultados_quiz',
      where: usuarioId == null
          ? 'usuario_id IS NULL AND planeta_id = ? AND categoria_id = ?'
          : 'usuario_id = ? AND planeta_id = ? AND categoria_id = ?',
      whereArgs: usuarioId == null
          ? [planetId, categoryId]
          : [usuarioId, planetId, categoryId],
      orderBy: 'fecha DESC, id DESC',
      limit: 1,
    );

    if (rows.isEmpty) return null;

    return rows.first;
  }

  Future<void> _insertAnswerDetail(
    Transaction txn,
    int resultadoId,
    Map<String, dynamic> respuesta,
  ) async {
    final opciones = List<String>.from(
      respuesta['opciones'] as List,
    );

    await txn.insert('detalle_respuestas', {
      'resultado_id': resultadoId,
      'pregunta_id': respuesta['preguntaId'],
      'opcion_seleccionada_id': null,
      'es_correcta': respuesta['esCorrecta'] == true ? 1 : 0,
      'enunciado_guardado': respuesta['enunciado'] ?? '',
      'opciones_guardadas': jsonEncode(opciones),
      'respuesta_correcta_guardada':
          respuesta['respuestaCorrecta'] ?? '',
      'respuesta_seleccionada_guardada':
          respuesta['respuestaSeleccionada'],
      'explicacion_guardada': respuesta['explicacion'] ?? '',
    });
  }

  Future<Map<String, dynamic>?> getUserById(int userId) async {
    final db = await AppDatabase.instance.database;

    final rows = await db.query(
      'usuarios',
      columns: ['id', 'nombre', 'correo'],
      where: 'id = ? AND activo = ?',
      whereArgs: [userId, 1],
      limit: 1,
    );

    if (rows.isEmpty) return null;

    return rows.first;
  }

  Future<int> getQuizCount(int userId) async {
    final db = await AppDatabase.instance.database;

    final rows = await db.rawQuery(
      '''
      SELECT COUNT(*) AS total
      FROM (
        SELECT planeta_id, categoria_id
        FROM resultados_quiz
        WHERE usuario_id = ?
        GROUP BY planeta_id, categoria_id
      )
      ''',
      [userId],
    );

    return (rows.first['total'] as int?) ?? 0;
  }

  Future<List<Map<String, dynamic>>> getQuizHistory(
    int userId,
  ) async {
    final db = await AppDatabase.instance.database;

    return db.rawQuery(
      '''
      SELECT
        r.id,
        p.nombre AS planeta,
        c.nombre AS categoria,
        r.puntuacion,
        r.total_preguntas,
        r.fecha
      FROM resultados_quiz r
      INNER JOIN planetas p ON p.id = r.planeta_id
      INNER JOIN categorias c ON c.id = r.categoria_id
      WHERE r.usuario_id = ?
        AND r.id = (
          SELECT r2.id
          FROM resultados_quiz r2
          WHERE r2.usuario_id = r.usuario_id
            AND r2.planeta_id = r.planeta_id
            AND r2.categoria_id = r.categoria_id
          ORDER BY r2.fecha DESC, r2.id DESC
          LIMIT 1
        )
      ORDER BY r.fecha DESC, r.id DESC
      ''',
      [userId],
    );
  }

  Future<List<Map<String, dynamic>>> getQuizResultDetails({
    required int resultadoId,
    required int userId,
  }) async {
    final db = await AppDatabase.instance.database;

    final resultRows = await db.query(
      'resultados_quiz',
      columns: ['id'],
      where: 'id = ? AND usuario_id = ?',
      whereArgs: [resultadoId, userId],
      limit: 1,
    );

    if (resultRows.isEmpty) {
      throw StateError(
        'No se encontró el cuestionario para esta cuenta.',
      );
    }

    final rows = await db.query(
      'detalle_respuestas',
      columns: [
        'id',
        'enunciado_guardado',
        'opciones_guardadas',
        'respuesta_correcta_guardada',
        'respuesta_seleccionada_guardada',
        'es_correcta',
        'explicacion_guardada',
      ],
      where: 'resultado_id = ?',
      whereArgs: [resultadoId],
      orderBy: 'id ASC',
    );

    return rows.map((row) {
      List<String> opciones = [];

      try {
        opciones = List<String>.from(
          jsonDecode(row['opciones_guardadas'] as String) as List,
        );
      } catch (_) {
        opciones = [];
      }

      return {
        'enunciado': row['enunciado_guardado'] ?? '',
        'opciones': opciones,
        'respuestaCorrecta':
            row['respuesta_correcta_guardada'] ?? '',
        'respuestaSeleccionada':
            row['respuesta_seleccionada_guardada'],
        'esCorrecta': row['es_correcta'] == 1,
        'explicacion': row['explicacion_guardada'] ?? '',
      };
    }).toList();
  }
}
