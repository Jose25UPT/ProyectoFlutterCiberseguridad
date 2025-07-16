import 'package:flutter/material.dart';
import 'package:tesisjarroultimate/local_auth.dart';
import 'package:tesisjarroultimate/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({
    super.key,
    this.logoWidth = 250,  // Ancho predeterminado
    this.logoHeight = 250, // Alto predeterminado
  });

  final double logoWidth;
  final double logoHeight;

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isAuthenticated = false;

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF05808C),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isAuthenticated 
        ? const HomeScreen() 
        : Scaffold(
            backgroundColor: const Color(0xFF9AD4CC),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo con tamaño ajustable
                    Container(
                      width: widget.logoWidth,   // Usa el ancho proporcionado
                      height: widget.logoHeight, // Usa el alto proporcionado
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: Image.asset(
                        './imagesciber1.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Autenticación requerida',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      height: 60,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.phone_android, 
                            size: 30, 
                            color: Colors.black),
                        label: const Text(
                          'Autenticar con Código',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF279DA4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                        ),
                        onPressed: () async {
                          final authenticated = await LocalAuth.authenticateWithDeviceCredential();
                          if (authenticated) {
                            setState(() {
                              _isAuthenticated = true;
                            });
                          } else {
                            _showSnackBar('Autenticación fallida');
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
  }
}