import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tesisjarroultimate/local_auth.dart';
import 'package:tesisjarroultimate/screens/apps_screen.dart';
import 'package:tesisjarroultimate/screens/malware_detection.dart';
import 'package:tesisjarroultimate/screens/permissions_screen.dart';
import 'package:tesisjarroultimate/screens/system_monitor_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BiometricType> availableBiometrics = [];
  bool hasFingerprint = false;
  bool hasFaceId = false;
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const AppsScreen(),
    const PermissionsDatabaseScreen(),
    const MalwareDetectionScreen(),
    SystemMonitorScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    final biometrics = await LocalAuth.getAvailableBiometrics();
    setState(() {
      availableBiometrics = biometrics;
      hasFingerprint = biometrics.contains(BiometricType.fingerprint);
      hasFaceId = biometrics.contains(BiometricType.face);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
        backgroundColor: const Color(0xFF05808C), // Color oscuro para el appbar
        foregroundColor: Colors.white, // Texto blanco para contraste
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: const Color(0xFFCEEce3), // Fondo claro
          selectedItemColor: const Color(0xFF05808C), // Color oscuro para seleccionado
          unselectedItemColor: const Color(0xFF279DA4), // Color intermedio para no seleccionado
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _selectedIndex == 0 
                      ? const Color(0xFF9AD4CC).withOpacity(0.3)
                      : Colors.transparent,
                ),
                child: const Icon(Icons.apps),
              ),
              label: 'Aplicaciones',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _selectedIndex == 1
                      ? const Color(0xFF9AD4CC).withOpacity(0.3)
                      : Colors.transparent,
                ),
                child: const Icon(Icons.security),
              ),
              label: 'Permisos',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _selectedIndex == 2
                      ? const Color(0xFF9AD4CC).withOpacity(0.3)
                      : Colors.transparent,
                ),
                child: const Icon(Icons.bug_report),
              ),
              label: 'Malware',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _selectedIndex == 3
                      ? const Color(0xFF9AD4CC).withOpacity(0.3)
                      : Colors.transparent,
                ),
                child: const Icon(Icons.monitor_heart),
              ),
              label: 'Monitor',
            ),
          ],
        ),
      ),
    );
  }
}