import 'package:flutter/material.dart';

void showCustomDialog(BuildContext context, String title, String body, Function action, Function action2) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: <Widget>[
          FlatButton(
            child: Text("닫기"),
            onPressed: () {
              action();
              action2();
            },
          ),
        ],
      );
    },
  );
}