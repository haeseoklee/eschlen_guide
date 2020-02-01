import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschlen_guide/auth.dart';
import 'package:eschlen_guide/open_graph_parser.dart';
import 'package:eschlen_guide/screens/result_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;
String loggedInUserId;

class StarPage extends StatefulWidget {
  static const String id = 'star_screen';

  @override
  _StarPageState createState() => _StarPageState();
}

class _StarPageState extends State<StarPage> {

  AuthManager authManager = AuthManager();
  bool showSpinner = false;

  Future<void> getUser() async {
    setState(() {
      showSpinner = true;
    });
    FirebaseUser user = await authManager.getCurrentUser();
    if (user == null){
      FirebaseUser newUser = await authManager.signInAnon();
      if (newUser == null) {
        print('로그인 실패');
      } else {
        loggedInUser = newUser;
        loggedInUserId = newUser.uid;
      }
    }else {
      loggedInUser = user;
      loggedInUserId = user.uid;
    }
    setState(() {
      showSpinner = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
          child: ModalProgressHUD(
          inAsyncCall: showSpinner,
            progressIndicator: SpinKitRing(
              color: Colors.amberAccent,
              size: 120.0,
            ),
          child: BookmarkStream(),
      )),
    );
  }
}

class BookmarkStream extends StatelessWidget {

  Future<Image> getImage(String url) async{
    var data = await OpenGraphParser.getOpenGraphData(url);
    return Image.network(
        data['image'],
        fit: BoxFit.fitWidth,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('users')
            .document(loggedInUserId)
            .collection('bookmarks')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData){
            return Center(
              child: SpinKitRing(
                color: Colors.amberAccent,
                size: 120.0,
              ),
            );
          }
          final bookmarks = snapshot.data.documents;
          List<Widget> cards = [];
          for (DocumentSnapshot bookmark in bookmarks) {
            cards.add(
                GestureDetector(
                  onTap: () => {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => MyWebView(url: bookmark['restaurant_url'],)))
                  },
                  child: MyCard(
                    getImage: getImage,
                    data: bookmark,
                  )
                )
            );
          }
          if (cards.length == 0){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Image.asset(
                  'images/cheese.png',
                  height: 200.0,
                ),
              ),
            );
          }else{
            return GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.all(18.0),
                childAspectRatio: 9.0 / 10.0,
                children: cards
            );
          }

        });
  }
}

class MyCard extends StatelessWidget {

  final Function getImage;
  final DocumentSnapshot data;

  MyCard({this.getImage, this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
              aspectRatio: 2.0 / 1.0,
              child: FutureBuilder(
                future: getImage(data['restaurant_url']),
                builder: (BuildContext context, AsyncSnapshot<Image> image){
                  if (!image.hasData) {
                    return Center(
                      child: SpinKitRing(
                        color: Colors.amberAccent,
                        size: 50.0,
                      ),
                    );// image is ready
                  }
                  return image.data;  // placeholder
                },
              )
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      data['restaurant_name'],
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                      data['phone'] != "" ? data['phone'] : "전화번호 없음",
                    style: TextStyle(
                      color: Colors.grey[700]
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                      data['road_address_name'],
                    style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey[700]
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
