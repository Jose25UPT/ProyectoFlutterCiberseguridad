import 'package:local_auth/local_auth.dart';

class LocalAuth {
  static final _auth = LocalAuthentication();

  // Obtener biometrías disponibles
  static Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } catch (e) {
      print('Error al obtener biometrías: $e');
      return [];
    }
  }

  // Verificar si el dispositivo soporta autenticación biométrica
  static Future<bool> _canAuth() async =>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  // Autenticación biométrica general
  static Future<bool> authenticate({String reason = 'Necesito tu confirmación', bool biometricOnly = false}) async {
    try {
      if (!await _canAuth()) return false;

      return await _auth.authenticate(
        localizedReason: reason,
        options: AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: biometricOnly,
        ),
      );
    } catch (e) {
      print('Error en autenticación: $e');
      return false;
    }
  }

  // Autenticación específica por huella digital
  static Future<bool> authenticateWithFingerprint() async {
    final biometrics = await getAvailableBiometrics();
    if (!biometrics.contains(BiometricType.fingerprint)) {
      return false;
    }

    return await authenticate(reason: 'Autenticación por huella digital', biometricOnly: true);
  }

  // Autenticación específica por rostro
  static Future<bool> authenticateWithFace() async {
    final biometrics = await getAvailableBiometrics();
    if (!biometrics.contains(BiometricType.face)) {
      return false;
    }

    return await authenticate(reason: 'Autenticación por reconocimiento facial', biometricOnly: true);
  }

  // Autenticación con código del celular
  static Future<bool> authenticateWithDeviceCredential() async {
    return await authenticate(reason: 'Autenticación con código del celular', biometricOnly: false);
  }
}