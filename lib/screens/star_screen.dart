import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class StarPage extends StatefulWidget {

  static const String id = 'star_screen';

  @override
  _StarPageState createState() => _StarPageState();
}

class _StarPageState extends State<StarPage> {
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
