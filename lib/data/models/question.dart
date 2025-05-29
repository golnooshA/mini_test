// lib/data/models/question.dart

class Question {
  final String id;
  final String prompt;
  final Map<String, String> options;
  final String correctAnswer;
  final String explanation;

  Question({
    required this.id,
    required this.prompt,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    // options come in as Map<dynamic,dynamic> so we cast safely:
    final opts = (json['options'] as Map<dynamic, dynamic>)
        .map((key, value) => MapEntry(key as String, value as String));

    return Question(
      id: json['id'] as String,
      prompt: json['prompt'] as String,
      options: opts,
      correctAnswer: json['correctAnswer'] as String,
      explanation: json['explanation'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'prompt': prompt,
    'options': options,
    'correctAnswer': correctAnswer,
    'explanation': explanation,
  };
}
