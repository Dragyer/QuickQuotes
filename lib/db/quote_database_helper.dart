import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/quote.dart';

class QuoteDatabaseHelper {
  static final QuoteDatabaseHelper instance = QuoteDatabaseHelper._internal();

  factory QuoteDatabaseHelper() => instance;

  static Database? _database;

  QuoteDatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'quotes.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE quotes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        quote TEXT NOT NULL,
        author TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertQuote(QuoteModel quote) async {
    final db = await database;
    return await db.insert('quotes', quote.toMap());
  }

  Future<List<QuoteModel>> getAllQuotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('quotes');
    return List.generate(maps.length, (i) {
      return QuoteModel.fromMap(maps[i]);
    });
  }

  Future<void> deleteAll() async {
    final db = await database;
    await db.delete('quotes');
  }
}
