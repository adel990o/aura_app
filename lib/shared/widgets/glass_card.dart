import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:aura_app/core/theme/app_theme.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final bool hasGlow;
  const GlassCard({super.key, required this.child, this.width, this.height, this.padding, this.margin, this.borderRadius, this.onTap, this.hasGlow = false});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width, height: height, margin: margin,
        child: ClipRRect(
          borderRadius: borderRadius ?? AppTheme.largeBorderRadius,
          child: BackdropFilter(
            filter: AppTheme.cardBlur,
            child: Container(
              padding: padding ?? const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppTheme.cardBackground70, borderRadius: borderRadius ?? AppTheme.largeBorderRadius, border: Border.all(color: AppTheme.goldOpacity20, width: 1.0), boxShadow: hasGlow ? AppTheme.goldenGlow : AppTheme.blackShadow),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class AuraAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  const AuraAppBar({super.key, required this.title, this.actions, this.leading});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: AppTheme.goldTitleStyle.copyWith(shadows: [Shadow(color: AppTheme.primaryGold.withOpacity(0.5), blurRadius: 10)])),
      leading: leading,
      actions: actions,
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
