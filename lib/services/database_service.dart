import 'package:weathernews_app/models/saved_news_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'saved_news.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE saved_news (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        url TEXT,
        urlToImage TEXT,
        publishedAt TEXT
      )
    ''');
  }

 Future<void> insertNews(SavedNewsModel news) async {
  final db = await database;
  await db.insert(
    'saved_news',
    news.toJson()..remove('id'), // Remove id before insertion
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

 Future<List<SavedNewsModel>> getSavedNews() async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query('saved_news');
  return List.generate(maps.length, (i) {
    return SavedNewsModel.fromJson(maps[i]);
  });
}

  Future<void> deleteNews(int id) async {
    final db = await database;
    await db.delete('saved_news', where: 'id = ?', whereArgs: [id]);
  }
}