import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:aura_app/core/theme/app_theme.dart';
import 'package:aura_app/core/utils/constants.dart';
import 'package:aura_app/data/models/smart_folder.dart';
import 'package:aura_app/data/models/activity_log.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late List<SmartFolder> _folders;
  late AISummary _aiSummary;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _folders = DefaultFolders.all.map((f) {
      int c = 0;
      if (f.type == AppConstants.folderTypeStudio) c = 12;
      if (f.type == AppConstants.folderTypeCommunication) c = 8;
      if (f.type == AppConstants.folderTypeSystem) c = 4;
      if (f.type == AppConstants.folderTypeEntertainment) c = 15;
      return f.copyWith(count: c);
    }).toList();
    _aiSummary = AISummary.demo();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppConstants.appName, style: AppTheme.goldTitleStyle.copyWith(shadows: [Shadow(color: AppTheme.primaryGold.withOpacity(0.5), blurRadius: 10)]))),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 20),
            _buildAICard(),
            const SizedBox(height: 30),
            Text(AppConstants.smartFoldersTitle, style: AppTheme.goldSubtitleStyle),
            const SizedBox(height: 16),
            Expanded(child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 1.2),
              itemCount: _folders.length,
              itemBuilder: (c, i) => _buildFolderCard(_folders[i]),
            )),
          ]),
        ),
      ),
    );
  }

  Widget _buildAICard() {
    return ClipRRect(
      borderRadius: AppTheme.xLargeBorderRadius,
      child: BackdropFilter(
        filter: AppTheme.glassBlur,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(gradient: AppTheme.goldCardGradient, border: Border.all(color: AppTheme.goldOpacity40, width: 1.5), borderRadius: AppTheme.xLargeBorderRadius, boxShadow: AppTheme.goldenGlow),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [const Icon(Icons.auto_awesome, color: AppTheme.textGold, size: 22), const SizedBox(width: 8), Text(AppConstants.aiSummaryTitle, style: AppTheme.goldSubtitleStyle)]),
            const SizedBox(height: 16),
            Text(_aiSummary.text, style: AppTheme.whiteBodyStyle),
            const SizedBox(height: 12),
            Align(alignment: Alignment.bottomLeft, child: Text(AppConstants.updatedNow, style: AppTheme.secondaryTextStyle)),
          ]),
        ),
      ),
    );
  }

  Widget _buildFolderCard(SmartFolder f) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(color: AppTheme.cardBackground70, borderRadius: AppTheme.largeBorderRadius, border: Border.all(color: AppTheme.goldOpacity20), boxShadow: AppTheme.blackShadow),
        child: ClipRRect(
          borderRadius: AppTheme.largeBorderRadius,
          child: BackdropFilter(
            filter: AppTheme.cardBlur,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppTheme.goldOpacity10, borderRadius: AppTheme.mediumBorderRadius, border: Border.all(color: AppTheme.goldOpacity20)), child: Icon(f.icon, color: AppTheme.textGold, size: 24)),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(f.title, style: const TextStyle(color: AppTheme.textWhite, fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text('${f.count} ${AppConstants.activityCount}', style: AppTheme.goldSubtitleStyle.copyWith(fontSize: 14)),
                ]),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
