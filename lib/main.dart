import 'package:eschlen_guide/models/option_data.dart';
import 'package:eschlen_guide/models/recommended_data.dart';
import 'package:eschlen_guide/screens/loading_screen.dart';
import 'package:eschlen_guide/screens/result_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/option_screen.dart';
import 'screens/bookmark_screen.dart';
import 'screens/user_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OptionData(),),
        ChangeNotifierProvider(create: (context) => RecommendedData())
      ],
      child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.amber,
          ),
          initialRoute: HomePage.id,
          routes: {
            HomePage.id: (context) => HomePage(),
            SelectionPage.id: (context) => SelectionPage(),
            LoadingScreen.id: (context) => LoadingScreen(),
            StarPage.id: (context) => StarPage(),
            UserPage.id: (context) => UserPage(),
            ResultPage.id: (context) => ResultPage(),
          },
      ),
    );
  }
}

class HomePage extends StatefulWidget {

  static const String id = 'home_screen';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;
  bool showSpinner = true;

  final List<Widget> _children = [
    SelectionPage(),
    StarPage(),
    UserPage()
  ];

  List<Color> _colors = [
    Colors.amberAccent,
    Colors.grey[300],
    Colors.grey[300]
  ];

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _children[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Image.asset('images/turkey_leg.png',
                  width: 35.0,
                  color: _colors[0],
                ),
              ),
              title: Text('')
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Image.asset('images/star.png',
                    width: 35.0,
                  color: _colors[1],),
              ),
                title: Text('')
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Image.asset('images/user_shape.png',
                    width: 35.0,
                  color: _colors[2],),
              ),
                title: Text('')
            )
          ],
          currentIndex: _selectedIndex,
          //selectedItemColor: Colors.amberAccent,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
              for(int i=0;i<3;i++){
                if (i==_selectedIndex){
                  _colors[i] = Colors.amberAccent;
                }else{
                  _colors[i] = Colors.grey[300];
                }
              }
            });
          },
        ),
    );
  }
}
