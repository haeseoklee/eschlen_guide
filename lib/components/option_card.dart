import 'package:flutter/material.dart';
import 'package:spring_button/spring_button.dart';

class OptionCard extends StatelessWidget {

  final Color color;
  final Widget childContent;
  final Function onPress;
  OptionCard({this.color, this.childContent, this.onPress});

  @override
  Widget build(BuildContext context) {
    return SpringButton(
      SpringButtonType.OnlyScale,
      Container(
        child: childContent,
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: this.color,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onTap: onPress,
      useCache: false,
    );
  }
}
