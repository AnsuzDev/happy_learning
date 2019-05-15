
import 'package:flutter/material.dart';

import '../helpers/constants.dart';
import '../models/answer.dart';
import '../models/single_choice_question.dart';

class SingleChoiceQuestionWidget extends StatelessWidget {

  final SingleChoiceQuestion question;
  final OnAnswerPressedFunc onAnswer;
  final OnNextPressedFunc onNext;

  const SingleChoiceQuestionWidget({
    Key key,
    this.question,
    this.onAnswer,
    this.onNext
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var content = question.contentType == "None"
      ? _renderAnswers(context)
      : Row(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: _renderContent(),
          ),
          Expanded(
            flex: 4,
            child: _renderAnswers(context),
          )
        ],
      );

    return Container(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.close, size: 32.0,),
                  onPressed: () {
                    Navigator.pushNamed(context, "/");
                  },
                ),
                Expanded(
                  child: Text(
                    question.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward, size: 32.0,),
                  onPressed: () {
                    onNext();
                  },
                ),
              ],
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10),),
            Expanded(
              child: content,
            )
          ],
        ),
      ),
    );
  }

  _renderContent() {
    switch (question.contentType) {
      case "ImageUrl":
        return Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: NetworkImage(question.contentData)
            )
          ),
        );
      default:
        return Text(question.contentData);
    }
  }

  _renderAnswers(BuildContext context) {
    var length = question.answers.length;

    if (length < 4) {
      return Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: question.answers.map<Widget>((a) => _renderAnswer(context, a)).toList()
        ),
      );
    } else if (length == 4) {
      return Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: _renderAnswer(context, question.answers[0]),
                  ),
                  Expanded(
                    child: _renderAnswer(context, question.answers[1]),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: _renderAnswer(context, question.answers[2]),
                  ),
                  Expanded(
                    child: _renderAnswer(context, question.answers[3]),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
  }

  _renderAnswer(BuildContext context, Answer a) {
    if (a.type == "String") {
      return Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: RaisedButton(
            child: Text(
              a.data,
              style: TextStyle(
                fontSize: 20
              ),
            ),
            onPressed: () {
              if (a.isCorrect) {
                final snackBar = SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text('Yay! Your answer is correct!'),
                );

                Scaffold.of(context).showSnackBar(snackBar);
              } else {
                final snackBar = SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text('Ooops! Your answer is incorrect!'),
                );

                Scaffold.of(context).showSnackBar(snackBar);
              }

              onAnswer(a.isCorrect);
            },
          ),
        )
      );
    } else if (a.type == "ImageUrl") {
      return GestureDetector(
        onTap: () {
          if (a.isCorrect) {
            final snackBar = SnackBar(
              duration: Duration(seconds: 1),
              content: Text('Yay! Your answer is correct!'),
            );

            Scaffold.of(context).showSnackBar(snackBar);
          } else {
            final snackBar = SnackBar(
              duration: Duration(seconds: 1),
              content: Text('Ooops! Your answer is incorrect!'),
            );

            Scaffold.of(context).showSnackBar(snackBar);
          }

          onAnswer(a.isCorrect);
        },
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: NetworkImage(a.data)
            )
          ),
        )
      );
    }
  }
}
