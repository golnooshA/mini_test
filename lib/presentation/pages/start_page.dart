import 'package:flutter/material.dart';
import 'package:min_test/presentation/pages/quiz_page.dart';
import 'package:min_test/presentation/widgets/bottomButton.dart';
import '../../core/config/design_config.dart';
import '../../data/models/quiz.dart';

class QuizStartPage extends StatelessWidget {
  final Quiz quiz;

  const QuizStartPage({super.key, required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignConfig.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 16,
              left: 16,
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: DesignConfig.backButtonCircleColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: DesignConfig.backColor,
                  ),
                ),
              ),
            ),

            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'QUIZ',
                    style: TextStyle(
                      color: DesignConfig.textColor,
                      fontSize: DesignConfig.bigTitle,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 24),

                  Text(
                    quiz.title,
                    style: const TextStyle(
                      color: DesignConfig.textColor,
                      fontSize: DesignConfig.bigText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${quiz.questions.length} questions',
                    style: const TextStyle(
                      color: DesignConfig.textColor,
                      fontSize: DesignConfig.bigSubtitle,
                    ),
                  ),
                ],
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: BottomButton(
                  buttonText: 'Start Quiz',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => QuizPage(quiz: quiz),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
