
class Answer {
  final String type;

  final String data;

  final bool isCorrect;

  Answer({this.type, this.data, this.isCorrect});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      type: json['type'] as String,
      data: json['data'] as String,
      isCorrect: json['isCorrect'] as bool,
    );
  }
}
