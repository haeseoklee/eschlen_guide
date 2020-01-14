import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {

  final Color color;
  final Widget childContent;
  Function onPress;
  OptionCard({this.color, this.childContent, this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: childContent,
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: this.color,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
