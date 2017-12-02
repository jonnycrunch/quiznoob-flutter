import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quizcircle/model/Quiz.dart';

class QuizListItem extends StatelessWidget {
  final Quiz quiz;

  QuizListItem(this.quiz);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.all(16.0),
      child: new Row(children: [
        new Expanded(
            child: new ListTile(
              title: new Text(quiz.name,
                  style: new TextStyle(fontWeight: FontWeight.w500)),
              subtitle: new Text(quiz.description,
                  style: new TextStyle(fontWeight: FontWeight.w500)),
              leading: new Icon(
                Icons.contact_phone,
                color: Colors.blue[500],
              ),
              trailing: new Icon(
                Icons.contact_phone,
                color: Colors.blue[500],
              ),
	      onTap: () { print("tapped ${quiz.id}"); }
            ))
      ]),
    );
  }
}
