import 'package:flutter/material.dart';
import 'package:native_app_list/native_app_list.dart';
import 'dart:typed_data'; // Importa Uint8List

class AppsScreen extends StatefulWidget {
  const AppsScreen({super.key});

  @override
  State<AppsScreen> createState() => _AppsScreenState();
}

class _AppsScreenState extends State<AppsScreen> {
  List<Map<String, dynamic>> installedApps = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadInstalledApps();
  }

  Future<void> _loadInstalledApps() async {
    setState(() {
      isLoading = true;
    });

    try {
      final List<Map<String, dynamic>> apps = await NativeAppList.getInstalledApps();
      setState(() {
        installedApps = apps;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener la lista de aplicaciones: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : installedApps.isEmpty
              ? const Center(child: Text('No se encontraron aplicaciones.'))
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Número de columnas en la cuadrícula
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: installedApps.length,
                  itemBuilder: (context, index) {
                    final app = installedApps[index];
                    final packageName = app['packageName']?.toString() ?? "Nombre no disponible";
                    final iconBytes = app['icon'] is Uint8List ? app['icon'] as Uint8List? : null;

                    return Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (iconBytes != null)
                            Image.memory(
                              iconBytes,
                              width: 48,
                              height: 48,
                            ),
                          const SizedBox(height: 8),
                          Text(
                            packageName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}