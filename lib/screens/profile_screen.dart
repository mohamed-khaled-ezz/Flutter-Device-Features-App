import 'package:flutter/material.dart';
import 'package:flutter_device_features/widgets/profile_header.dart';

/// Secure profile screen displaying user info after successful biometric authentication.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: ProfileHeader(
            fullName: 'Mohamed Ahmed',
            email: 'mohamed.ahmed@example.com',
          ),
        ),
      ),
    );
  }
}
