import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionnaireScreen extends StatelessWidget {
  static const String id = 'questionnaire_screen';

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xffDDD3C7),
            ),
            padding: EdgeInsets.all(10.0),
            child: Text(
              '1회차 질문지',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: [
              questionBox(),
            ],
          ),
        ],
      ),
    ));
  }
}

class questionBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.green,
            // borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          child: Text(
            'Q1 : 어느 정도 진행 되었나요?',
          ),
        ),
        Container(
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Colors.green,
            // borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '80',
              isDense: true,
              contentPadding: EdgeInsets.all(8),
            ),
          ),
        ),
      ],
    );
  }
}
