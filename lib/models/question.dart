
class Question {
  final String type;

  Question({this.type});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      type: json['type'] as String,
    );
  }
}
