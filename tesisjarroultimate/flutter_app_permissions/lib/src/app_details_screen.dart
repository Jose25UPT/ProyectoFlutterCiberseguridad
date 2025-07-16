import 'package:flutter/material.dart';

class AppDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> appDetails;

  const AppDetailsScreen({super.key, required this.appDetails});

  @override
  Widget build(BuildContext context) {
    final permissions = appDetails['permissions'] as Map<String, dynamic>;
    final permList = permissions['list'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(appDetails['appName']?.toString() ?? 'Detalles'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildInfoTile('Paquete', appDetails['packageName']),
          _buildInfoTile('Versión', appDetails['version']),
          _buildInfoTile('Fecha instalación', 
              (appDetails['installDate'] as DateTime).toString()),
          _buildSectionTitle('Permisos (${permissions['total']})'),
          ...permList.map(_buildPermissionTile),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String title, String? value) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value ?? 'No disponible'),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildPermissionTile(dynamic permission) {
    final perm = permission as Map<String, dynamic>;
    return ExpansionTile(
      title: Text(perm['name']?.toString() ?? 'Permiso desconocido'),
      subtitle: Text(perm['group']?.toString() ?? 'Sin grupo'),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nivel: ${perm['protectionLevel']?.join(', ') ?? 'N/A'}'),
              const SizedBox(height: 8),
              Text('Peligroso: ${perm['isDangerous'] ?? false ? 'Sí' : 'No'}'),
              const SizedBox(height: 8),
              Text(perm['description']?.toString() ?? 'Sin descripción'),
            ],
          ),
        ),
      ],
    );
  }
}