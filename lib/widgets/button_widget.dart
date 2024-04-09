import 'package:flutter/material.dart';
import 'package:codeland/theme/colors.dart';

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const ButtonWidget({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: buttonBackgroundColor,
            borderRadius: BorderRadius.circular(10)),
        child: Center(child: Icon(icon)),
      ),
    );
  }
}
