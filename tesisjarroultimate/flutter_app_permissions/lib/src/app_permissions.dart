import 'dart:async';
import 'package:flutter/services.dart';

class AppPermissions {
  static const MethodChannel _channel =
      MethodChannel('flutter_app_permissions');

  /// Obtiene todas las apps instaladas con sus permisos básicos
  Future<List<dynamic>> getInstalledApps() async {
    try {
      final List<dynamic> apps = await _channel.invokeMethod('getInstalledApps');
      return apps;
    } on PlatformException catch (e) {
      throw Exception("Error al obtener apps: ${e.message}");
    }
  }

  /// Obtiene detalles detallados de una app específica
  Future<Map<String, dynamic>> getAppDetails(String packageName) async {
    try {
      final Map<dynamic, dynamic> details = await _channel.invokeMethod(
        'getAppDetails',
        {'packageName': packageName},
      );
      return _parseAppDetails(details.cast<String, dynamic>());
    } on PlatformException catch (e) {
      throw Exception("Error en detalles: ${e.message}");
    }
  }

  Map<String, dynamic> _parseAppDetails(Map<String, dynamic> data) {
    return {
      'packageName': data['packageName'] ?? 'Desconocido',
      'appName': data['appName'] ?? '',
      'version': data['version'] ?? '1.0.0',
      'permissions': _parsePermissions(data['permissions']),
      'activities': List<String>.from(data['activities'] ?? []),
      'isSystemApp': data['isSystemApp'] ?? false,
      'installDate': DateTime.fromMillisecondsSinceEpoch(
          data['installDate'] ?? DateTime.now().millisecondsSinceEpoch),
    };
  }

  Map<String, dynamic> _parsePermissions(dynamic permissions) {
    if (permissions is! Map) return {};
    
    return {
      'total': permissions['total'] ?? 0,
      'dangerous': permissions['dangerous'] ?? 0,
      'list': List<Map<String, dynamic>>.from(
          permissions['list']?.map((p) => p.cast<String, dynamic>()) ?? []),
    };
  }
}