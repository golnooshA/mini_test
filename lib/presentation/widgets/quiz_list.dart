// lib/presentation/widgets/quiz_list.dart

import 'package:flutter/material.dart';
import 'package:min_test/core/config/design_config.dart';

class QuizList extends StatelessWidget {
  final String title;
  final String buttonText;
  final String videoLength;
  final int questionCount;
  final String imagePath;
  final VoidCallback onTap;

  const QuizList({
    super.key,
    required this.title,
    required this.imagePath,
    required this.videoLength,
    required this.questionCount,
    required this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: DesignConfig.cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: imagePath.startsWith('http')
                  ? Image.network(
                      imagePath,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      imagePath,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12, right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: DesignConfig.textColor,
                      fontSize: DesignConfig.textSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$videoLength • $questionCount questions',
                    style: const TextStyle(
                      color: DesignConfig.textColor,
                      fontSize: DesignConfig.subTextSize,
                    ),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: DesignConfig.buttonColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      minimumSize: const Size(double.infinity, 30),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: onTap,
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        color: DesignConfig.buttonColor,
                        fontSize: DesignConfig.buttonTextSize,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
