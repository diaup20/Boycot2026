import 'package:flutter/material.dart';

import '../../../../../Core/constants/color_constants.dart';

class CustomToggleButton extends StatelessWidget {
  const CustomToggleButton({
    super.key, required this.label, required this.image, required this.icon, required this.active, required this.onTap, required this.activeColors, required this.inactiveColor, required this.context,
  });
  final String label;
  final String image;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;
  final List<Color> activeColors;
  final Color inactiveColor;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          height: 109,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
            gradient: active
                ? LinearGradient(colors: activeColors)
                : LinearGradient(
                    colors: [
                      kPrimaryColor.withOpacity(0.10),
                      Theme.of(context).colorScheme.primaryContainer,
                      Theme.of(context).colorScheme.secondaryContainer,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            boxShadow: active
                ? [
                    BoxShadow(
                      color: kPrimaryColor.withOpacity(0.09),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
            border: Border.all(
              color: kPrimaryColor.withOpacity(0.18),
              width: 1.1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(image, height: 70, width: 75, fit: BoxFit.cover),
              Text(
                label,
                style: TextStyle(
                  color: active ? Colors.white : inactiveColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: active ? 22 : 12,
                height: 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: active
                      ? Colors.white.withOpacity(0.7)
                      : inactiveColor.withOpacity(0.13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
