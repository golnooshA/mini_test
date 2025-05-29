// lib/presentation/widgets/bottomButton.dart
import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class BottomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onTap;      // ← allow null

  const BottomButton({
    super.key,
    required this.buttonText,
    this.onTap,                   // ← make optional
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: DesignConfig.buttonColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onTap,           // null disables the button automatically
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 16, color: DesignConfig.textColor),
        ),
      ),
    );
  }
}
