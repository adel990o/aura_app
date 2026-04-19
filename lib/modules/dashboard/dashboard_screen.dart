import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aura_app/core/theme/app_theme.dart';
import 'package:aura_app/core/utils/constants.dart';
import 'package:aura_app/data/models/smart_folder.dart';
import 'package:aura_app/data/models/activity_log.dart';
import 'package:aura_app/data/repositories/activity_repository.dart';
import 'package:aura_app/shared/widgets/glass_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late ActivityRepository _repository;
  List<SmartFolder> _folders = [];
  AISummary _aiSummary = AISummary.empty();
  bool _isLoading = true;
  final DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _repository = context.read<ActivityRepository>();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final stats = await _repository.getFolderStats(_selectedDate);
      _folders = DefaultFolders.all.map((f) => f.copyWith(count: stats[f.type] ?? 0)).toList();
      final total = await _repository.getTotalActivitiesCount(_selectedDate);
      _aiSummary = total > 0 ? AISummary(text: 'قمت بـ $total نشاطاً اليوم', generatedAt: DateTime.now(), totalActivities: total) : AISummary.empty();
    } catch (e) {
      _folders = DefaultFolders.all;
      _aiSummary = AISummary.demo();
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppConstants.appName, style: AppTheme.goldTitleStyle)),
      body: _isLoading ? const Center(child: CircularProgressIndicator(color: AppTheme.primaryGold)) : RefreshIndicator(
        onRefresh: _loadData,
        color: AppTheme.primaryGold,
        child: SafeArea(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 20),
          GlassCard(hasGlow: true, padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [const Icon(Icons.auto_awesome, color: AppTheme.textGold, size: 22), const SizedBox(width: 8), Text(AppConstants.aiSummaryTitle, style: AppTheme.goldSubtitleStyle)]),
            const SizedBox(height: 16), Text(_aiSummary.text, style: AppTheme.whiteBodyStyle), const SizedBox(height: 12),
            Text('⏺︎ ${_aiSummary.totalActivities} نشاط', style: AppTheme.secondaryTextStyle),
          ])),
          const SizedBox(height: 30),
          Text(AppConstants.smartFoldersTitle, style: AppTheme.goldSubtitleStyle), const SizedBox(height: 16),
          Expanded(child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 1.2), itemCount: _folders.length, itemBuilder: (c, i) => GlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppTheme.goldOpacity10, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.goldOpacity20)), child: Icon(_folders[i].icon, color: AppTheme.textGold, size: 24)),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(_folders[i].title, style: const TextStyle(color: AppTheme.textWhite, fontSize: 16, fontWeight: FontWeight.w600)), const SizedBox(height: 4), Text('${_folders[i].count} نشاط', style: AppTheme.goldSubtitleStyle.copyWith(fontSize: 14))]),
          ])))),
        ]))),
      ),
    );
  }
}
