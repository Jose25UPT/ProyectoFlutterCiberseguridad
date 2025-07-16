import 'dart:typed_data';
import 'package:flutter/services.dart';

class NativeAppList {
  static const MethodChannel _channel = MethodChannel('native_app_list');

  // Método para obtener la lista de aplicaciones instaladas con sus iconos
  static Future<List<Map<String, dynamic>>> getInstalledApps() async {
  try {
    final List<dynamic> apps = await _channel.invokeMethod('getInstalledApps');
    return apps.map((app) {
      final map = Map<String, dynamic>.from(app as Map<dynamic, dynamic>);
      return {
        "packageName": map["packageName"] as String,
        "icon": map["icon"] as Uint8List,
      };
    }).toList();
  } catch (e) {
    throw Exception('Failed to get installed apps: $e');
  }
}
}