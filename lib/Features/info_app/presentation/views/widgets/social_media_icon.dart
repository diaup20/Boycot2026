import 'package:flutter/material.dart';

class SocialMediaIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const SocialMediaIcon({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      elevation: 4,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(icon, size: 24, color: Colors.blueGrey),
        ),
      ),
    );
  }
}
