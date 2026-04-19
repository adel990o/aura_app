# (الصق الكود، ثم Ctrl+X، ثم Y، ثم Enter للحفظ) 
# 4. بعد الانتهاء من كل الملفات، ارفع التغييرات
git add . git commit -m "Week 2: Database layer 
- SQLite with migrations"
git push origin mainimport 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:aura_app/data/database/migrations/v1_initial.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  static const String _dbName = 'aura_database.db';
  static const int _dbVersion = 1;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await V1Migration.createTables(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // للاستخدام المستقبلي
  }

  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
