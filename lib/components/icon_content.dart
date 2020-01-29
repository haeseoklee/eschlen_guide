import 'package:flutter/material.dart';

class IconContent extends StatelessWidget {

  final Widget childContent;
  final Color color;

  IconContent({@required this.childContent, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        childContent
      ],
    );
  }
}
