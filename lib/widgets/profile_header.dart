import 'package:flutter/material.dart';

/// Custom widget that displays user profile picture, full name, and email.
class ProfileHeader extends StatelessWidget {
  final String fullName;
  final String email;
  final String? imageUrl;

  const ProfileHeader({
    super.key,
    required this.fullName,
    required this.email,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          foregroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
          child: imageUrl == null
              ? Icon(
                  Icons.person,
                  size: 60,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                )
              : null,
        ),
        const SizedBox(height: 16),
        Text(
          fullName,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          email,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
        ),
      ],
    );
  }
}
