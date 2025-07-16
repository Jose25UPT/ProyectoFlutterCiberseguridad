import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tesisjarroultimate/monitoring/native_methods.dart';

class SystemMonitorScreen extends StatefulWidget {
  @override
  _SystemMonitorScreenState createState() => _SystemMonitorScreenState();
}

class _SystemMonitorScreenState extends State<SystemMonitorScreen> {
  Map<String, dynamic> ramInfo = {};
  double gpuUsage = 0.0;
  Map<String, dynamic> storageInfo = {};
  Map<String, dynamic> batteryInfo = {};
  List<double> cpuUsage = List.generate(8, (index) => 0.0);

  @override
  void initState() {
    super.initState();
    _loadSystemInfo();
    _startCpuUsageTimer();
  }

  Future<void> _loadSystemInfo() async {
    final ram = await NativeMethods.getRamInfo();
    final gpu = await NativeMethods.getGpuUsage();
    final storage = await NativeMethods.getStorageInfo();
    final battery = await NativeMethods.getBatteryInfo();
    final cpuUsage = await NativeMethods.getCpuUsage();

    setState(() {
      ramInfo = ram;
      gpuUsage = gpu;
      storageInfo = storage;
      batteryInfo = battery;
      this.cpuUsage = cpuUsage;
    });
  }

  void _startCpuUsageTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      final simulatedCpuUsage = List.generate(8, (index) => 20.0 + (DateTime.now().millisecond % 80));
      setState(() {
        cpuUsage = simulatedCpuUsage;
      });
    });
  }

  void _generateReport() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Reporte del Sistema", style: TextStyle(color: Colors.black)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("RAM: ${ramInfo["available"]?.toStringAsFixed(2) ?? "0.0"} GB libres de ${ramInfo["total"]?.toStringAsFixed(2) ?? "0.0"} GB", style: TextStyle(color: Colors.black)),
            Text("Almacenamiento: ${storageInfo["free"]?.toStringAsFixed(2) ?? "0.0"} GB libres de ${storageInfo["total"]?.toStringAsFixed(2) ?? "0.0"} GB", style: TextStyle(color: Colors.black)),
            Text("Batería: ${batteryInfo["level"]}%", style: TextStyle(color: Colors.black)),
            Text("GPU: ${gpuUsage.toStringAsFixed(2)}%", style: TextStyle(color: Colors.black)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cerrar", style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monitor del Sistema", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Gráfico de CPU
            Container(
              height: 200,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("CPU", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 8),
                  Expanded(
                    child: SfCartesianChart(
                      primaryXAxis: NumericAxis(isVisible: false),
                      primaryYAxis: NumericAxis(minimum: 0, maximum: 100, interval: 20),
                      series: <CartesianSeries<CpuData, int>>[ // Cambio aquí
                        LineSeries<CpuData, int>(
                          dataSource: cpuUsage.asMap().entries.map((e) => CpuData(e.key, e.value)).toList(),
                          xValueMapper: (CpuData data, _) => data.core,
                          yValueMapper: (CpuData data, _) => data.usage,
                          color: Colors.amber,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: List.generate(
                      cpuUsage.length,
                      (index) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: _getCoreColor(index),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text('Core ${index + 1}', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Almacenamiento y RAM
            Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    title: "Almacenamiento",
                    value: "${storageInfo["free"]?.toStringAsFixed(2) ?? "0.0"} GB",
                    total: "${storageInfo["total"]?.toStringAsFixed(2) ?? "0.0"} GB",
                    color: Colors.amber,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildInfoCard(
                    title: "RAM",
                    value: "${ramInfo["available"]?.toStringAsFixed(2) ?? "0.0"} GB",
                    total: "${ramInfo["total"]?.toStringAsFixed(2) ?? "0.0"} GB",
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Batería y GPU
            Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    title: "Batería",
                    value: "${batteryInfo["level"]?.toString() ?? "0"}%",
                    subtitle: batteryInfo["isCharging"] == true ? "Cargando" : "Descargando",
                    color: Colors.green,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildInfoCard(
                    title: "GPU",
                    value: "${gpuUsage.toStringAsFixed(2)}%",
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Botón para generar reporte
            ElevatedButton(
              onPressed: _generateReport,
              child: Text("Generar Reporte"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.amber,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String value,
    String? subtitle,
    required Color color,
    String? total,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          if (subtitle != null) Text(subtitle, style: TextStyle(color: Colors.white)),
          SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          if (total != null) Text("de $total", style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Color _getCoreColor(int index) {
    final colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.purple,
      Colors.amber,
      Colors.teal,
      Colors.pink,
      Colors.orange,
    ];
    return colors[index % colors.length];
  }
}

class CpuData {
  final int core;
  final double usage;

  CpuData(this.core, this.usage);
}