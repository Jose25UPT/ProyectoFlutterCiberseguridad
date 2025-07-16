import 'package:flutter/services.dart';

class NativeMethods {
  static const MethodChannel _channel = MethodChannel('com.example.system_monitor/native');

  // Obtener información de la RAM
  static Future<Map<String, dynamic>> getRamInfo() async {
    try {
      final result = await _channel.invokeMethod('getRamInfo');
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      print("Error: ${e.message}");
      return {};
    }
  }

  // Obtener uso de la GPU
  static Future<double> getGpuUsage() async {
    try {
      final result = await _channel.invokeMethod('getGpuUsage');
      return result;
    } on PlatformException catch (e) {
      print("Error: ${e.message}");
      return 0.0;
    }
  }

  // Obtener información del almacenamiento
  static Future<Map<String, dynamic>> getStorageInfo() async {
    try {
      final result = await _channel.invokeMethod('getStorageInfo');
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      print("Error: ${e.message}");
      return {};
    }
  }

  // Obtener información de la batería
  static Future<Map<String, dynamic>> getBatteryInfo() async {
    try {
      final result = await _channel.invokeMethod('getBatteryInfo');
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      print("Error: ${e.message}");
      return {};
    }
  }

  // Obtener uso de la CPU por núcleo
  static Future<List<double>> getCpuUsage() async {
    try {
      final result = await _channel.invokeMethod('getCpuUsage');
      return List<double>.from(result);
    } on PlatformException catch (e) {
      print("Error: ${e.message}");
      return [];
    }
  }
}