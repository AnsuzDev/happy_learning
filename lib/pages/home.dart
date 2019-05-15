
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Happy learning',
              style: TextStyle(fontSize: 40),
            ),
            Padding(padding: EdgeInsets.all(10)),
            RaisedButton(
              child: const Text(
                'Start',
                style: TextStyle(fontSize: 20)
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/lesson");
              },
            )
          ],
        ),
      )
    );
  }
}
