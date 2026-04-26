


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isActive;
  const AuthButton({super.key, required this.onPressed, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      label: const Text('Login with Spotify'),
      icon: SvgPicture.asset('assets/svg/spotify_logo.svg', height: 30, width: 30),
    );
  }
}