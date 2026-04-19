import 'package:aura_app/core/utils/constants.dart';

class DateHelper {
  static DateTime startOfDay(DateTime date) => DateTime(date.year, date.month, date.day);
  static DateTime endOfDay(DateTime date) => DateTime(date.year, date.month, date.day, 23, 59, 59);
  static String formatTime(DateTime time) => '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  static String formatDate(DateTime date) {
    final now = DateTime.now();
    final today = startOfDay(now);
    final yesterday = today.subtract(const Duration(days: 1));
    final target = startOfDay(date);
    if (target == today) return 'اليوم';
    if (target == yesterday) return 'أمس';
    return '${date.day}/${date.month}';
  }
  static String formatDateTime(DateTime dt) => '${formatDate(dt)} ${formatTime(dt)}';
  static int daysUntilPermanentDelete(DateTime deletedAt) => AppConstants.trashRetentionDays - DateTime.now().difference(deletedAt).inDays;
  static bool isExpired(DateTime deletedAt) => DateTime.now().difference(deletedAt).inDays > AppConstants.trashRetentionDays;
  static String toIsoString(DateTime date) => date.toIso8601String();
  static DateTime fromIsoString(String iso) => DateTime.parse(iso);
}
