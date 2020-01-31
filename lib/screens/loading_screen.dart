import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {

  static const id = 'loading_screen';
  final Function doSomething;

  LoadingScreen({this.doSomething});

  @override
  _LoadingScreenState createState() => _LoadingScreenState(doSomething: doSomething);
}

class _LoadingScreenState extends State<LoadingScreen> {

  final Function doSomething;
  _LoadingScreenState({this.doSomething});

  @override
  void initState() {
    super.initState();
    doSomething();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Hero(
              tag: 'food',
              child: Center(
                child: Container(
                  child: Image.asset('images/food.png'),
                  height: 200.0,
                ),
              ),
            ),
            SpinKitDoubleBounce(
              color: Colors.amberAccent,
              size: 120.0,
            ),
          ],
        ),
      ),
    );
  }
}
