import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschlen_guide/auth.dart';
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
            progressIndicator: SpinKitCircle(
              color: Colors.amberAccent,
              size: 120.0,
            ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BookmarkStream()
            ],
          ),
      )),
    );
  }
}

class BookmarkStream extends StatelessWidget {

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
              child: SpinKitCircle(
                color: Colors.amberAccent,
                size: 120.0,
              ),
            );
          }
          final bookmarks = snapshot.data.documents;
          List<Text> tiles = [];
          for (DocumentSnapshot bookmark in bookmarks) {
            tiles.add(Text(
                bookmark['restaurant_name'],
              style: TextStyle(fontSize: 20.0),
            ));
          }
          if (tiles.length == 0){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('데이터가 없습니다',
                style: TextStyle(fontSize: 100.0),),
            );
          }else{
            return Expanded(
                child: ListView(
                  children: tiles,
                )
            );
          }

        });
  }
}
