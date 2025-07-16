import 'dart:convert';
import 'package:http/http.dart' as http;

class VirusTotalService {
  static const String _apiKey = '9dcc70ea07779195784e2c3597f0862689009c34380895b98ac72322363e90b0'; // Reemplaza con tu API Key
  static const String _baseUrl = 'https://www.virustotal.com/api/v3';

  Future<Map<String, dynamic>> getFileReport(String hash) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/files/$hash'),
      headers: {'x-apikey': _apiKey},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener el reporte');
    }
  }
}