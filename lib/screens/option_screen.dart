import 'package:app_settings/app_settings.dart';
import 'package:eschlen_guide/models/option_data.dart';
import 'package:eschlen_guide/models/recommended_data.dart';
import 'package:eschlen_guide/screens/result_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:spring_button/spring_button.dart';

import 'loading_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/option_card.dart';
import 'dart:io' show Platform;
import '../components/cupertino_dialog.dart';
import '../components/dialog.dart';

class SelectionPage extends StatefulWidget {

  static const String id = 'random_screen';

  @override
  _SelectionPageState createState() => _SelectionPageState();
}


class _SelectionPageState extends State<SelectionPage> {

  bool isGpsAble = false;

  @override
  void initState() {
    super.initState();
    checkGps();
  }


  void checkGps() async{
    Geolocator geolocator = Geolocator();
    bool geolocationStatus  = await geolocator.isLocationServiceEnabled();
    setState(() {
      isGpsAble = geolocationStatus;
    });
  }

  void getRecommendedRestaurant() async {
    Map options = Provider.of<OptionData>(context).getFilteredOptions();

    if (await Provider.of<RecommendedData>(context).getRestaurants(options)) {
      await Navigator.pushReplacementNamed(context, ResultPage.id);
    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(30.0),
        child: Consumer<OptionData>(
          builder: (context, optionData, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: OptionCard(
                          onPress: () {
                            optionData.switchOptions(0, 0);
                          },
                          color: optionData.isChecked[0][0]
                              ? Colors.amberAccent
                              : Colors.grey[200],
                          childContent: Padding(
                            padding: const EdgeInsets.all(33.0),
                            child: Image.asset(
                                'images/question.png',
                                color: optionData.isChecked[0][0] ? null : Colors.grey[300]
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: OptionCard(
                          onPress: () {
                            optionData.switchOptions(0, 1);
                          },
                          color: optionData.isChecked[0][1]
                              ? Colors.amberAccent
                              : Colors.grey[200],
                          childContent: Padding(
                            padding: const EdgeInsets.all(33.0),
                            child: Image.asset('images/map.png',
                                color: optionData.isChecked[0][1] ? null : Colors.grey[300]),
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
                            optionData.switchOptions(1, 0);
                          },
                          color: optionData.isChecked[1][0]
                              ? Colors.amberAccent
                              : Colors.grey[200],
                          childContent: Padding(
                            padding: const EdgeInsets.all(33.0),
                            child: Image.asset('images/china.png',
                                color: optionData.isChecked[1][0] ? null : Colors.grey[300]),
                          ),
                        ),
                      ),
                      Expanded(
                        child: OptionCard(
                          onPress: () {
                            optionData.switchOptions(1, 1);
                          },
                          color: optionData.isChecked[1][1]
                              ? Colors.amberAccent
                              : Colors.grey[200],
                          childContent: Padding(
                            padding: const EdgeInsets.all(33.0),
                            child: Image.asset('images/sushi.png',
                                color: optionData.isChecked[1][1] ? null : Colors.grey[300]),
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
                            optionData.switchOptions(2, 0);
                          },
                          color: optionData.isChecked[2][0]
                              ? Colors.amberAccent
                              : Colors.grey[200],
                          childContent: Padding(
                            padding: const EdgeInsets.all(33.0),
                            child: Image.asset('images/pint.png',
                                color: optionData.isChecked[2][0] ? null : Colors.grey[300]),
                          ),
                        ),
                      ),
                      Expanded(
                        child: OptionCard(
                          onPress: () {
                            optionData.switchOptions(2, 1);
                          },
                          color: optionData.isChecked[2][1]
                              ? Colors.amberAccent
                              : Colors.grey[200],
                          childContent: Padding(
                            padding: const EdgeInsets.all(33.0),
                            child: Image.asset('images/tea-cup.png',
                                color: optionData.isChecked[2][1] ? null : Colors.grey[300]),
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
                      checkGps();
                      if(optionData.getCheckedNum() > 0){
                        if(!isGpsAble){
                          AppSettings.openLocationSettings();
                          Platform.isAndroid ?
                          showCustomDialog(context, "알림", "GPS를 연결해주세요", () => Navigator.pop(context), checkGps) :
                          showCustomCupertinoDialog(context, '알림', 'GPS를 연결해주세요', () => Navigator.pop(context), checkGps);
                        }else{
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return LoadingScreen(doSomething: getRecommendedRestaurant);
                          }));
                        }
                      }else{
                        Platform.isAndroid ?
                        showCustomDialog(context, "알림", "옵션을 선택해주세요", () => Navigator.pop(context), checkGps) :
                        showCustomCupertinoDialog(context, "알림", "옵션을 선택해주세요", () => Navigator.pop(context), checkGps);
                      }
                    },
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
