import 'package:flutter/material.dart';
import 'package:aura_app/core/utils/constants.dart';

class SmartFolder {
  final String id;
  final String title;
  final String type;
  final IconData icon;
  final int count;
  final DateTime lastUpdated;
  SmartFolder({required this.id, required this.title, required this.type, required this.icon, required this.count, required this.lastUpdated});
  SmartFolder copyWith({String? id, String? title, String? type, IconData? icon, int? count, DateTime? lastUpdated}) {
    return SmartFolder(id: id ?? this.id, title: title ?? this.title, type: type ?? this.type, icon: icon ?? this.icon, count: count ?? this.count, lastUpdated: lastUpdated ?? this.lastUpdated);
  }
}

class DefaultFolders {
  static List<SmartFolder> get all => [
    SmartFolder(id: '1', title: AppConstants.studioFolder, type: AppConstants.folderTypeStudio, icon: Icons.photo_library_outlined, count: 0, lastUpdated: DateTime.now()),
    SmartFolder(id: '2', title: AppConstants.communicationFolder, type: AppConstants.folderTypeCommunication, icon: Icons.call_outlined, count: 0, lastUpdated: DateTime.now()),
    SmartFolder(id: '3', title: AppConstants.systemFolder, type: AppConstants.folderTypeSystem, icon: Icons.settings_outlined, count: 0, lastUpdated: DateTime.now()),
    SmartFolder(id: '4', title: AppConstants.entertainmentFolder, type: AppConstants.folderTypeEntertainment, icon: Icons.music_note_outlined, count: 0, lastUpdated: DateTime.now()),
  ];
}
