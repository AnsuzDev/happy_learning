
import 'question.dart';

class Lesson {
  final int id;

  final List<Question> questions;

  Lesson({this.id, this.questions});

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as int,
      questions: json['questions'] as List<Question>,
    );
  }
}
