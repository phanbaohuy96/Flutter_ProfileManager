import 'package:flutter/material.dart';
import 'package:profile_manager/models/user_noted.dart';

final Color backgroundColor = Colors.grey;

class UserNotedView extends StatelessWidget {
  final UserNoted note =
      UserNoted(date: ' - 20/05/2019 - ', content: 'content');

  UserNotedView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: backgroundColor,
          ),
          child: Text(
            note.date,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                note.content,
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
            ],
          ),
        )
      ],
    );
  }
}
