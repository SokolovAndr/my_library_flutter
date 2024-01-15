import 'package:my_library_flutter/models/book_model.dart';
import 'package:my_library_flutter/models/genre_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const int _version = 2;
  static const String _dbName = "Library.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async {
          await db.execute(
              "CREATE TABLE Book(id INTEGER PRIMARY KEY, title TEXT NOT NULL, description TEXT NOT NULL, image TEXT NOT NULL)"
          );
          await db.execute(
              "CREATE TABLE Genre(id INTEGER PRIMARY KEY, name TEXT NOT NULL)"
          );
        },
        version: _version);
  }

  static Future<int> addBook(Book book) async {
    final db = await _getDB();
    return await db.insert("Book", book.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateBook(Book book) async {
    final db = await _getDB();
    return await db.update("Book", book.toJson(),
        where: 'id = ?',
        whereArgs: [book.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteBook(Book book) async {
    final db = await _getDB();
    return await db.delete("Book",
        where: 'id = ?',
        whereArgs: [book.id]);
  }

  static Future<List<Book>?> getAllBooks() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("Book");
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => Book.fromJson(maps[index]));
  }

  static Future<int> addGenre (Genre genre) async {
      final db = await _getDB();
      return await db.insert("Genre", genre.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateGenre(Genre genre) async {
    final db = await _getDB();
    return await db.update("Genre", genre.toJson(),
        where: 'id = ?',
        whereArgs: [genre.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteGenre(Genre genre) async {
    final db = await _getDB();
    return await db.delete("Genre",
        where: 'id = ?',
        whereArgs: [genre.id]);
  }


  static Future<List<Genre>?> getAllGenres() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("Genre");
    if(maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => Genre.fromJson(maps[index]));
  }
}
