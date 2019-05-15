
import 'question.dart';
import 'answer.dart';

class ComparisionQuestion extends Question {

  final String title;

  final List<Answer> answers;

  ComparisionQuestion({
    this.title,
    this.answers
  }) : super(type: "ComparisionQuestion");

  factory ComparisionQuestion.fromJson(Map<String, dynamic> json) {
    var list = json['answers'] as List;
    List<Answer> answers = list.map((json) {
      return Answer.fromJson(json);
    }).toList();

    return ComparisionQuestion(
      title: json['title'] as String,
      answers: answers,
    );
  }
}
