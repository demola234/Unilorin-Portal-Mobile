import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthApi {
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> isDeviceSupported() async {
    try {
      return await _auth.isDeviceSupported();
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    final supportedDevice = await isDeviceSupported();
    if (!isAvailable && !supportedDevice) return false;

    try {
      return await _auth.authenticate(
          localizedReason: 'Please authenticate to show results',
          options: const AuthenticationOptions(biometricOnly: true));
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }
}
