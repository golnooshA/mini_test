// lib/presentation/pages/quiz_page.dart

import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';
import '../../data/models/quiz.dart';
import '../widgets/bottomButton.dart';
import 'quiz_result_page.dart';

class QuizPage extends StatefulWidget {
  final Quiz quiz;
  const QuizPage({Key? key, required this.quiz}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentIndex = 0;
  String? _selectedKey;
  bool _answered = false;
  int _correctCount = 0;

  void _onChoiceTap(String key) {
    if (_answered) return;
    setState(() {
      _selectedKey = key;
      _answered = true;
      if (key == widget.quiz.questions[_currentIndex].correctAnswer) {
        _correctCount++;
      }
    });
  }

  void _onNext() {
    if (!_answered) return;
    final isLast = _currentIndex == widget.quiz.questions.length - 1;
    if (!isLast) {
      setState(() {
        _currentIndex++;
        _selectedKey = null;
        _answered = false;
      });
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => QuizResultPage(
            correctCount: _correctCount,
            totalCount: widget.quiz.questions.length,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question   = widget.quiz.questions[_currentIndex];
    final totalCount = widget.quiz.questions.length;

    Color _bgColor(String key) {
      if (!_answered) return DesignConfig.inactiveButton;
      if (key == question.correctAnswer) return DesignConfig.correctColor;
      if (key == _selectedKey && _selectedKey != question.correctAnswer) {
        return DesignConfig.incorrectColor;
      }
      return DesignConfig.inactiveButton;
    }

    return Scaffold(
      backgroundColor: DesignConfig.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Question ${_currentIndex + 1}/$totalCount'),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            Text(
              question.prompt,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Answer options
            ...question.options.entries.map((entry) {
              final key  = entry.key;
              final text = entry.value;
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Material(
                  color: _bgColor(key),
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    onTap: () => _onChoiceTap(key),
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        '$key. $text',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),

            const Spacer(),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: BottomButton(
                  buttonText: _currentIndex < totalCount - 1 ? 'Next' : 'Finish',
                  onTap: _answered ? _onNext : null,
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
