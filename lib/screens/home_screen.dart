import 'package:flutter/material.dart';
import 'package:flutter_device_features/screens/audio_recorder_screen.dart';
import 'package:flutter_device_features/screens/device_info_screen.dart';
import 'package:flutter_device_features/screens/google_map_screen.dart';
import 'package:flutter_device_features/screens/image_gallery_screen.dart';
import 'package:flutter_device_features/screens/profile_screen.dart';
import 'package:flutter_device_features/services/biometric_service.dart';
import 'package:flutter_device_features/widgets/feature_card.dart';

/// Main Home Screen featuring access to all device capability screens
/// and a biometric-protected profile icon at the top right of the AppBar.
class HomeScreen extends StatelessWidget {
  final BiometricService _biometricService = BiometricService();

  HomeScreen({super.key});

  /// Handles biometric authentication when the profile icon is tapped.
  /// Navigates to ProfileScreen only if biometric authentication succeeds.
  Future<void> _handleProfileAccess(BuildContext context) async {
    final bool isAuthenticated = await _biometricService.authenticate();

    if (!context.mounted) return;

    if (isAuthenticated) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Authentication failed or was cancelled.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Device Features'),
        actions: [
          // Profile Icon at top right of the home screen requiring biometric auth
          IconButton(
            icon: const Icon(Icons.account_circle, size: 28),
            tooltip: 'Profile (Biometric Protected)',
            onPressed: () => _handleProfileAccess(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: [
          FeatureCard(
            title: 'Phase 1: Device Info',
            subtitle: 'Display device model name and OS version',
            icon: Icons.phone_android,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DeviceInfoScreen(),
                ),
              );
            },
          ),
          FeatureCard(
            title: 'Phase 2: Image Gallery',
            subtitle: 'Pick multiple images from gallery and view in ListView',
            icon: Icons.photo_library,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ImageGalleryScreen(),
                ),
              );
            },
          ),
          FeatureCard(
            title: 'Phase 3: Google Map',
            subtitle: 'Display Google Map with Cairo Governorate marker',
            icon: Icons.map,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GoogleMapScreen(),
                ),
              );
            },
          ),
          FeatureCard(
            title: 'Phase 5: Audio Recorder',
            subtitle: 'Record voice audio and play it back',
            icon: Icons.mic,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AudioRecorderScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
