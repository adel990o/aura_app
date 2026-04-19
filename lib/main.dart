import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aura_app/core/theme/app_theme.dart';
import 'package:aura_app/data/repositories/activity_repository.dart';
import 'package:aura_app/modules/dashboard/dashboard_screen.dart';

void main() => runApp(const AuraApp());

class AuraApp extends StatelessWidget {
  const AuraApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider(create: (_) => ActivityRepository())],
      child: MaterialApp(title: 'Aura | أورا', debugShowCheckedModeBanner: false, theme: AppTheme.darkTheme, home: const DashboardScreen()),
    );
  }
}
