import 'package:flutter/cupertino.dart';

void showCustomCupertinoDialog(BuildContext context, String title, String body,
    Function action, Function action2) {
  showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('닫기'),
              onPressed: () {
                action();
                action2();
              },
            )
          ],
        );
      });
}
