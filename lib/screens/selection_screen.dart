import 'package:app_settings/app_settings.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spring_button/spring_button.dart';

import 'loading_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../option_card.dart';
import 'dart:io' show Platform;

class SelectionPage extends StatefulWidget {

  static const String id = 'random_screen';

  @override
  _SelectionPageState createState() => _SelectionPageState();
}


class _SelectionPageState extends State<SelectionPage> {


  int checkedNum = 0;
  bool isGpsAble = false;
  List _isChecked = [
    [false, false],
    [false, false],
    [false, false]
  ];

  @override
  void initState() {
    super.initState();
    checkGps();
  }


  String getProperty(i, j){
    String property;
    if (i == 0 && j == 0){
      property = 'random';
    }else if(i == 0 && j == 1) {
      property = 'nearest';
    }else if(i == 1 && j == 0){
      property = 'chinese';
    }else if(i == 1 && j == 1){
      property = 'japanese';
    }else if(i == 2 && j == 0){
      property = 'liquor';
    }else if(i == 2 && j == 1){
      property = 'cafe';
    }
    return property;
  }

  Map getFilteredOptions(options) {
    checkedNum = 0;
    var filteredOptions = new Map();
    for(var i=0;i<options.length;i++){
      for(var j=0;j<options[i].length;j++){
        String property = getProperty(i, j);
        if(_isChecked[i][j]){
          checkedNum++;
          filteredOptions[property] = true;
        }else{
          filteredOptions[property] = false;
        }
      }
    }
    return filteredOptions;
  }

  void _showCupertinoDialog(String title, String body, Function action){
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context){
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(body),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('닫기'),
                onPressed: (){
                  action();
                  checkGps();
                },
              )
            ],
          );
        });
  }

  void _showDialog(String title, String body, Function action) {
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
                checkGps();
              },
            ),
          ],
        );
      },
    );
  }


  Future<bool> checkGps() async{
    Geolocator geolocator = Geolocator();
    bool geolocationStatus  = await geolocator.isLocationServiceEnabled();
    setState(() {
      isGpsAble = geolocationStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: OptionCard(
                      onPress: () {
                        setState(() {
                          _isChecked[0][0] = !_isChecked[0][0];
                        });
                      },
                      color: _isChecked[0][0]
                          ? Colors.amberAccent
                          : Colors.grey[200],
                      childContent: Padding(
                        padding: const EdgeInsets.all(33.0),
                        child: Image.asset(
                          'images/question.png',
                          color: _isChecked[0][0] ? null : Colors.grey[300]
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: OptionCard(
                      onPress: () {
                        setState(() {
                          _isChecked[0][1] = !_isChecked[0][1];
                        });
                      },
                      color: _isChecked[0][1]
                          ? Colors.amberAccent
                          : Colors.grey[200],
                      childContent: Padding(
                        padding: const EdgeInsets.all(33.0),
                        child: Image.asset('images/map.png',
                            color: _isChecked[0][1] ? null : Colors.grey[300]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: OptionCard(
                      onPress: () {
                        setState(() {
                          _isChecked[1][0] = !_isChecked[1][0];
                        });
                      },
                      color: _isChecked[1][0]
                          ? Colors.amberAccent
                          : Colors.grey[200],
                      childContent: Padding(
                        padding: const EdgeInsets.all(33.0),
                        child: Image.asset('images/yin-yang.png',
                            color: _isChecked[1][0] ? null : Colors.grey[300]),
                      ),
                    ),
                  ),
                  Expanded(
                    child: OptionCard(
                      onPress: () {
                        setState(() {
                          _isChecked[1][1] = !_isChecked[1][1];
                        });
                      },
                      color: _isChecked[1][1]
                          ? Colors.amberAccent
                          : Colors.grey[200],
                      childContent: Padding(
                        padding: const EdgeInsets.all(33.0),
                        child: Image.asset('images/flower.png',
                            color: _isChecked[1][1] ? null : Colors.grey[300]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: OptionCard(
                      onPress: () {
                        setState(() {
                          _isChecked[2][0] = !_isChecked[2][0];
                        });
                      },
                      color: _isChecked[2][0]
                          ? Colors.amberAccent
                          : Colors.grey[200],
                      childContent: Padding(
                        padding: const EdgeInsets.all(33.0),
                        child: Image.asset('images/pint.png',
                            color: _isChecked[2][0] ? null : Colors.grey[300]),
                      ),
                    ),
                  ),
                  Expanded(
                    child: OptionCard(
                      onPress: () {
                        setState(() {
                          _isChecked[2][1] = !_isChecked[2][1];
                        });
                      },
                      color: _isChecked[2][1]
                          ? Colors.amberAccent
                          : Colors.grey[200],
                      childContent: Padding(
                        padding: const EdgeInsets.all(33.0),
                        child: Image.asset('images/tea-cup.png',
                            color: _isChecked[2][1] ? null : Colors.grey[300]),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SpringButton(
                SpringButtonType.OnlyScale,
                Hero(
                  tag: 'food',
                  child: Container(
                    margin: EdgeInsets.only(top: 30.0, bottom: 30.0),
                    child: Image.asset('images/food.png'),
                    height: 130.0,
                  ),
                ),
                onTap: (){
                  Map options = getFilteredOptions(_isChecked);
                  checkGps();
                  if(checkedNum > 0){
                    if(!isGpsAble){
                      AppSettings.openLocationSettings();
                      Platform.isAndroid ?
                      _showDialog("알림", "GPS를 연결해주세요", () => Navigator.pop(context)) :
                      _showCupertinoDialog('알림', 'GPS를 연결해주세요', () => Navigator.pop(context));
                    }else{
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return LoadingScreen(
                          options: options,
                        );
                      }));
                    }
                  }else{
                    Platform.isAndroid ?
                    _showDialog("알림", "옵션을 선택해주세요", () => Navigator.pop(context)) :
                    _showCupertinoDialog("알림", "옵션을 선택해주세요", () => Navigator.pop(context));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
