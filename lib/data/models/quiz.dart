// lib/data/models/quiz.dart

import 'question.dart';

class Quiz {
  final String id;
  final String title;
  final String duration;
  final String photo;
  final String video;
  final List<Question> questions;

  Quiz({
    required this.id,
    required this.title,
    required this.duration,
    required this.photo,
    required this.video,
    required this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'] as String,
      title: json['title'] as String,
      duration: json['duration'] as String,
      photo: json['photo'] as String,
      video: json['video'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((q) => Question.fromJson(q as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'duration': duration,
    'photo': photo,
    'video': video,
    'questions': questions.map((q) => q.toJson()).toList(),
  };
}
