import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

/// Helper service for biometric and fingerprint authentication using local_auth package.
class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  /// Checks if the device has hardware support for biometrics and can authenticate.
  Future<bool> isBiometricAvailable() async {
    try {
      final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
      return canAuthenticate;
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Prompts the user to authenticate using biometrics (fingerprint/Face ID).
  /// Returns `true` if authentication is successful, `false` otherwise.
  Future<bool> authenticate() async {
    try {
      final bool isAvailable = await isBiometricAvailable();
      if (!isAvailable) {
        return false;
      }

      return await _auth.authenticate(
        localizedReason: 'Please scan your fingerprint to access your profile',
        biometricOnly: true,
      );
    } on PlatformException catch (_) {
      return false;
    }
  }
}
