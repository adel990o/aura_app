import 'package:sqflite/sqflite.dart';
import 'package:aura_app/core/utils/constants.dart';

class V1Migration {
  static Future<void> createTables(Database db) async {
    await db.execute('''
      CREATE TABLE ${AppConstants.tableActivities} (
        ${AppConstants.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${AppConstants.columnAppName} TEXT NOT NULL,
        ${AppConstants.columnAction} TEXT,
        ${AppConstants.columnTimestamp} TEXT NOT NULL,
        ${AppConstants.columnIsActive} INTEGER DEFAULT 1,
        ${AppConstants.columnDeletedAt} TEXT,
        ${AppConstants.columnFolderType} TEXT NOT NULL,
        ${AppConstants.columnVisitCount} INTEGER DEFAULT 1
      )
    ''');
    await db.execute('''
      CREATE TABLE ${AppConstants.tableFolders} (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        type TEXT NOT NULL,
        count INTEGER DEFAULT 0,
        last_updated TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE ${AppConstants.tableSnapshots} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        snapshot_date TEXT NOT NULL,
        data TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');
    await _insertDefaultFolders(db);
  }

  static Future<void> _insertDefaultFolders(Database db) async {
    final now = DateTime.now().toIso8601String();
    final folders = [
      {'id': '1', 'title': AppConstants.studioFolder, 'type': AppConstants.folderTypeStudio, 'count': 0, 'last_updated': now},
      {'id': '2', 'title': AppConstants.communicationFolder, 'type': AppConstants.folderTypeCommunication, 'count': 0, 'last_updated': now},
      {'id': '3', 'title': AppConstants.systemFolder, 'type': AppConstants.folderTypeSystem, 'count': 0, 'last_updated': now},
      {'id': '4', 'title': AppConstants.entertainmentFolder, 'type': AppConstants.folderTypeEntertainment, 'count': 0, 'last_updated': now},
    ];
    for (final f in folders) {
      await db.insert(AppConstants.tableFolders, f, conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }
}
