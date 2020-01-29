import 'package:eschlen_guide/recommendation.dart';
import 'package:eschlen_guide/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {

  static const id = 'loading_screen';
  final Map options;

  LoadingScreen({this.options});

  @override
  _LoadingScreenState createState() => _LoadingScreenState(options: options);
}

class _LoadingScreenState extends State<LoadingScreen> {

  Map options;
  _LoadingScreenState({this.options});

  @override
  void initState() {
    super.initState();
    getRecommendedRestaurant();
  }

  void getRecommendedRestaurant() async{

    Map recommendedRes = await Recommendation(options).getRestaurants();

    Navigator.pushReplacementNamed(context, ResultPage.id, arguments: {
      'recommendedRes': recommendedRes
    });
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
