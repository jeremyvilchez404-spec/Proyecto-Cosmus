
import 'package:bcrypt/bcrypt.dart';

import '../database/app_database.dart';

class UserService {
  UserService._();

  static final UserService instance = UserService._();

  /// Registra un usuario en SQLite.
  /// Devuelve el ID del usuario creado.
  Future<int> registerUser({
    required String nombre,
    required String correo,
    required String password,
  }) async {
    final nombreLimpio = nombre.trim();
    final correoLimpio = correo.trim().toLowerCase();

    if (nombreLimpio.isEmpty ||
        correoLimpio.isEmpty ||
        password.isEmpty) {
      throw ArgumentError('Todos los campos son obligatorios.');
    }

    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
        .hasMatch(correoLimpio)) {
      throw ArgumentError('El correo electrónico no es válido.');
    }

    if (password.length < 8) {
      throw ArgumentError(
        'La contraseña debe tener al menos 8 caracteres.',
      );
    }

    final db = await AppDatabase.instance.database;

    final existentes = await db.query(
      'usuarios',
      columns: ['id'],
      where: 'correo = ?',
      whereArgs: [correoLimpio],
      limit: 1,
    );

    if (existentes.isNotEmpty) {
      throw StateError('EMAIL_EXISTS');
    }

    // Hash seguro de la contraseña mediante bcrypt.
    final passwordHash = BCrypt.hashpw(
      password,
      BCrypt.gensalt(),
    );

    return db.insert('usuarios', {
      'nombre': nombreLimpio,
      'correo': correoLimpio,
      'password_hash': passwordHash,
      'fecha_creacion': DateTime.now().toIso8601String(),
      'activo': 1,
    });
  }

  /// Comprueba las credenciales.
  /// Devuelve los datos del usuario si son correctos.
  /// Devuelve null si las credenciales no son válidas.
  Future<Map<String, dynamic>?> login({
    required String correo,
    required String password,
  }) async {
    if (correo.trim().isEmpty || password.isEmpty) {
      return null;
    }

    final db = await AppDatabase.instance.database;

    final usuarios = await db.query(
      'usuarios',
      where: 'correo = ? AND activo = ?',
      whereArgs: [correo.trim().toLowerCase(), 1],
      limit: 1,
    );

    if (usuarios.isEmpty) {
      return null;
    }

    final usuario = usuarios.first;
    final passwordHash = usuario['password_hash'] as String;

    final coincide = BCrypt.checkpw(password, passwordHash);

    if (!coincide) {
      return null;
    }

    // Nunca devolver el hash de la contraseña.
    return {
      'id': usuario['id'],
      'nombre': usuario['nombre'],
      'correo': usuario['correo'],
    };
  }
}
