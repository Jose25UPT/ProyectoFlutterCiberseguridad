// test/local_auth_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:local_auth/local_auth.dart';

import 'mocks/local_auth_mock.mocks.dart';
import 'package:tesisjarroultimate/local_auth.dart'; // Reemplaza con tu ruta real

void main() {
  late MockLocalAuthentication mockAuth;

  setUp(() {
    mockAuth = MockLocalAuthentication();
    LocalAuth.setAuthInstance(mockAuth);
  });

  test('Autenticación con huella digital', () async {
    when(mockAuth.getAvailableBiometrics())
        .thenAnswer((_) async => [BiometricType.fingerprint]);
    when(mockAuth.canCheckBiometrics).thenAnswer((_) async => true);
    when(mockAuth.isDeviceSupported()).thenAnswer((_) async => true);
    when(mockAuth.authenticate(
      localizedReason: anyNamed('localizedReason'),
      options: anyNamed('options'),
    )).thenAnswer((_) async => true);

    final result = await LocalAuth.authenticateWithFingerprint();
    expect(result, isTrue);
  });

  test('Autenticación con rostro', () async {
    when(mockAuth.getAvailableBiometrics())
        .thenAnswer((_) async => [BiometricType.face]);
    when(mockAuth.canCheckBiometrics).thenAnswer((_) async => true);
    when(mockAuth.isDeviceSupported()).thenAnswer((_) async => true);
    when(mockAuth.authenticate(
      localizedReason: anyNamed('localizedReason'),
      options: anyNamed('options'),
    )).thenAnswer((_) async => true);

    final result = await LocalAuth.authenticateWithFace();
    expect(result, isTrue);
  });

  test('Autenticación con PIN', () async {
    when(mockAuth.canCheckBiometrics).thenAnswer((_) async => true);
    when(mockAuth.isDeviceSupported()).thenAnswer((_) async => true);
    when(mockAuth.authenticate(
      localizedReason: anyNamed('localizedReason'),
      options: anyNamed('options'),
    )).thenAnswer((_) async => true);

    final result = await LocalAuth.authenticateWithDeviceCredential();
    expect(result, isTrue);
  });

  test('Falla si no hay huella disponible', () async {
    when(mockAuth.getAvailableBiometrics())
        .thenAnswer((_) async => [BiometricType.face]); // No fingerprint

    final result = await LocalAuth.authenticateWithFingerprint();
    expect(result, isFalse);
  });

  test('Falla si authenticate lanza excepción', () async {
    when(mockAuth.canCheckBiometrics).thenAnswer((_) async => true);
    when(mockAuth.isDeviceSupported()).thenAnswer((_) async => true);
    when(mockAuth.authenticate(
      localizedReason: anyNamed('localizedReason'),
      options: anyNamed('options'),
    )).thenThrow(Exception('Error'));

    final result = await LocalAuth.authenticateWithDeviceCredential();
    expect(result, isFalse);
  });
}
