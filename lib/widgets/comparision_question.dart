
import 'package:flutter/material.dart';

import '../helpers/constants.dart';
import '../models/comparision_question.dart';

class ComparisionQuestionWidget extends StatelessWidget {

  final ComparisionQuestion question;
  final OnAnswerPressedFunc onAnswer;
  final OnNextPressedFunc onNext;

  const ComparisionQuestionWidget({
    Key key,
    this.question,
    this.onAnswer,
    this.onNext
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: _renderAnswers(context),
            )
          ],
        ),
      ),
    );
  }

  _renderAnswers(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: question.answers.map((a) {
          if (a.type == "ImageUrl") {
            return Expanded(
              child: GestureDetector(
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
              )
            );
          } else {
            return Container();
          }
        }).toList()
      ),
    );
  }
}
