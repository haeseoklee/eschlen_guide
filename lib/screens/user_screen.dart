import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class UserPage extends StatefulWidget {

  static const String id = 'user_screen';

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(100.0),
              child: Image.asset('images/traffic-cone.png'),
            ),
          )
      ),
    );
  }
}
