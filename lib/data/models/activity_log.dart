import 'package:aura_app/core/utils/constants.dart';
import 'package:aura_app/core/utils/date_helper.dart';

class ActivityLog {
  final String? id;
  final String appName;
  final String? action;
  final DateTime timestamp;
  final bool isActive;
  final DateTime? deletedAt;
  final String folderType;
  final int visitCount;
  ActivityLog({this.id, required this.appName, this.action, required this.timestamp, this.isActive = true, this.deletedAt, required this.folderType, this.visitCount = 1});
  Map<String, dynamic> toMap() => {
    AppConstants.columnId: id, AppConstants.columnAppName: appName, AppConstants.columnAction: action,
    AppConstants.columnTimestamp: timestamp.toIso8601String(), AppConstants.columnIsActive: isActive ? 1 : 0,
    AppConstants.columnDeletedAt: deletedAt?.toIso8601String(), AppConstants.columnFolderType: folderType,
    AppConstants.columnVisitCount: visitCount
  };
  factory ActivityLog.fromMap(Map<String, dynamic> map) => ActivityLog(
    id: map[AppConstants.columnId]?.toString(), appName: map[AppConstants.columnAppName], action: map[AppConstants.columnAction],
    timestamp: DateTime.parse(map[AppConstants.columnTimestamp]), isActive: map[AppConstants.columnIsActive] == 1,
    deletedAt: map[AppConstants.columnDeletedAt] != null ? DateTime.parse(map[AppConstants.columnDeletedAt]) : null,
    folderType: map[AppConstants.columnFolderType], visitCount: map[AppConstants.columnVisitCount] ?? 1
  );
  String get formattedTime => DateHelper.formatTime(timestamp);
}

class AISummary {
  final String text;
  final DateTime generatedAt;
  final int totalActivities;
  AISummary({required this.text, required this.generatedAt, required this.totalActivities});
  factory AISummary.empty() => AISummary(text: 'لا توجد أنشطة كافية', generatedAt: DateTime.now(), totalActivities: 0);
  factory AISummary.demo() => AISummary(text: AppConstants.defaultAISummary, generatedAt: DateTime.now(), totalActivities: 28);
}
