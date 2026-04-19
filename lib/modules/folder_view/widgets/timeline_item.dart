import 'package:flutter/material.dart';
import 'package:aura_app/core/theme/app_theme.dart';
import 'package:aura_app/data/models/activity_log.dart';

class TimelineItem extends StatelessWidget {
  final ActivityLog activity;
  const TimelineItem({super.key, required this.activity});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(width: 60, child: Text(activity.formattedTime, style: TextStyle(color: AppTheme.textGold.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w500))),
        Column(children: [Container(width: 12, height: 12, decoration: BoxDecoration(color: AppTheme.primaryGold.withOpacity(0.3), shape: BoxShape.circle, border: Border.all(color: AppTheme.textGold, width: 2))), Container(width: 2, height: 60, color: AppTheme.goldOpacity20)]),
        const SizedBox(width: 16),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(activity.appName, style: const TextStyle(color: AppTheme.textWhite, fontSize: 16, fontWeight: FontWeight.w600)), if (activity.action != null) ...[const SizedBox(height: 4), Text(activity.action!, style: TextStyle(color: AppTheme.textSecondary, fontSize: 14))]])),
      ]),
    );
  }
}
