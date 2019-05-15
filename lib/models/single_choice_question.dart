
import 'question.dart';
import 'answer.dart';

class SingleChoiceQuestion extends Question {

  final String title;

  final String contentType;

  final String contentData;

  final List<Answer> answers;

  SingleChoiceQuestion({
    this.title,
    this.contentType,
    this.contentData,
    this.answers
  }) : super(type: "SingleChoiceQuestion");

  factory SingleChoiceQuestion.fromJson(Map<String, dynamic> json) {
    var list = json['answers'] as List;
    List<Answer> answers = list.map((json) {
      return Answer.fromJson(json);
    }).toList();

    return SingleChoiceQuestion(
      title: json['title'] as String,
      contentType: json['contentType'] as String,
      contentData: json['contentData'] as String,
      answers: answers,
    );
  }
}
