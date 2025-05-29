import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../../core/config/design_config.dart';
import '../../data/models/quiz.dart';
import '../widgets/quiz_list.dart';
import 'video_player_page.dart';

class QuizListPage extends StatelessWidget {
  const QuizListPage({Key? key}) : super(key: key);

  Future<List<Quiz>> _loadQuizzes() async {
    final jsonStr = await rootBundle.loadString('assets/quizzes.json');
    final data = json.decode(jsonStr) as Map<String, dynamic>;
    return (data['quizzes'] as List)
        .map((e) => Quiz.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignConfig.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'QUIZ',
          style: TextStyle(fontSize: DesignConfig.appBarTitleFontSize),
        ),
        centerTitle: true,
        backgroundColor: DesignConfig.backgroundColor,
        elevation: 0,
      ),
      body: FutureBuilder<List<Quiz>>(
        future: _loadQuizzes(),
        builder: (ctx, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(
                color: DesignConfig.progressColor,
              ),
            );
          }
          if (snap.hasError) {
            return Center(
              child: Text(
                'Error loading quizzes:\n${snap.error}',
                style: const TextStyle(color: DesignConfig.errorColor),
                textAlign: TextAlign.center,
              ),
            );
          }

          final quizzes = snap.data!;
          if (quizzes.isEmpty) {
            return const Center(
              child: Text(
                'No quizzes available',
                style: TextStyle(color: DesignConfig.noDataColor),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            itemCount: quizzes.length,
            itemBuilder: (ctx, i) {
              final quiz = quizzes[i];
              return QuizList(
                title: quiz.title,
                imagePath: quiz.photo,
                videoLength: quiz.duration,
                questionCount: quiz.questions.length,
                buttonText: 'Continue now',
                onTap: () {
                  Navigator.of(ctx).push(
                    MaterialPageRoute(
                      builder: (_) => VideoPlayerPage(quiz: quiz),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
