import 'package:aura_app/core/utils/constants.dart';
import 'package:aura_app/core/utils/date_helper.dart';
import 'package:aura_app/data/database/database_helper.dart';
import 'package:aura_app/data/models/activity_log.dart';

class ActivityRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<int> insertActivity(ActivityLog activity) async {
    final db = await _dbHelper.database;
    return await db.insert(AppConstants.tableActivities, activity.toMap());
  }

  Future<int> moveToTrash(String id) async {
    final db = await _dbHelper.database;
    return await db.update(AppConstants.tableActivities, {AppConstants.columnIsActive: 0, AppConstants.columnDeletedAt: DateTime.now().toIso8601String()}, where: '${AppConstants.columnId} = ?', whereArgs: [id]);
  }

  Future<int> restoreActivity(String id) async {
    final db = await _dbHelper.database;
    return await db.update(AppConstants.tableActivities, {AppConstants.columnIsActive: 1, AppConstants.columnDeletedAt: null}, where: '${AppConstants.columnId} = ?', whereArgs: [id]);
  }

  Future<int> deletePermanently(String id) async {
    final db = await _dbHelper.database;
    return await db.delete(AppConstants.tableActivities, where: '${AppConstants.columnId} = ?', whereArgs: [id]);
  }

  Future<int> cleanupExpiredActivities() async {
    final db = await _dbHelper.database;
    final expiryDate = DateTime.now().subtract(Duration(days: AppConstants.trashRetentionDays)).toIso8601String();
    return await db.delete(AppConstants.tableActivities, where: '${AppConstants.columnIsActive} = 0 AND ${AppConstants.columnDeletedAt} < ?', whereArgs: [expiryDate]);
  }

  Future<List<ActivityLog>> getActivitiesByDate(DateTime date) async {
    final db = await _dbHelper.database;
    final result = await db.query(AppConstants.tableActivities, where: '${AppConstants.columnIsActive} = 1 AND ${AppConstants.columnTimestamp} BETWEEN ? AND ?', whereArgs: [DateHelper.startOfDay(date).toIso8601String(), DateHelper.endOfDay(date).toIso8601String()], orderBy: '${AppConstants.columnTimestamp} DESC');
    return result.map((m) => ActivityLog.fromMap(m)).toList();
  }

  Future<List<ActivityLog>> getTrashedActivities() async {
    final db = await _dbHelper.database;
    final result = await db.query(AppConstants.tableActivities, where: '${AppConstants.columnIsActive} = 0', orderBy: '${AppConstants.columnDeletedAt} DESC');
    return result.map((m) => ActivityLog.fromMap(m)).toList();
  }

  Future<Map<String, int>> getFolderStats(DateTime date) async {
    final db = await _dbHelper.database;
    final stats = <String, int>{};
    for (final type in [AppConstants.folderTypeStudio, AppConstants.folderTypeCommunication, AppConstants.folderTypeSystem, AppConstants.folderTypeEntertainment]) {
      final r = await db.rawQuery('SELECT SUM(${AppConstants.columnVisitCount}) as t FROM ${AppConstants.tableActivities} WHERE ${AppConstants.columnIsActive}=1 AND ${AppConstants.columnFolderType}=? AND ${AppConstants.columnTimestamp} BETWEEN ? AND ?', [type, DateHelper.startOfDay(date).toIso8601String(), DateHelper.endOfDay(date).toIso8601String()]);
      stats[type] = (r.first['t'] as int?) ?? 0;
    }
    return stats;
  }

  Future<int> getTotalActivitiesCount(DateTime date) async {
    final db = await _dbHelper.database;
    final r = await db.rawQuery('SELECT COUNT(*) as t FROM ${AppConstants.tableActivities} WHERE ${AppConstants.columnIsActive}=1 AND ${AppConstants.columnTimestamp} BETWEEN ? AND ?', [DateHelper.startOfDay(date).toIso8601String(), DateHelper.endOfDay(date).toIso8601String()]);
    return (r.first['t'] as int?) ?? 0;
  }

  Future<void> insertDemoData() async {
    final now = DateTime.now();
    final demos = [
      ActivityLog(appName: 'واتساب', action: 'مكالمة', timestamp: now.subtract(const Duration(hours: 2)), folderType: AppConstants.folderTypeCommunication),
      ActivityLog(appName: 'معرض الصور', action: 'فتح صورة', timestamp: now.subtract(const Duration(hours: 1)), folderType: AppConstants.folderTypeStudio),
      ActivityLog(appName: 'يوتيوب', action: 'مشاهدة', timestamp: now.subtract(const Duration(hours: 3)), folderType: AppConstants.folderTypeEntertainment),
    ];
    for (final a in demos) await insertActivity(a);
  }
}
