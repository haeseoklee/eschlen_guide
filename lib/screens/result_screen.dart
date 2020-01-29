import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschlen_guide/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;
String loggedInUserId;

class ResultPage extends StatefulWidget {
  static const String id = 'result_screen';

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Map arguments;
  Completer<WebViewController> _controller = Completer<WebViewController>();
  AuthManager authManager = AuthManager();
  bool isBookmark = false;

  void getUser() async {
    FirebaseUser user = await authManager.getCurrentUser();
    loggedInUser = user;
    loggedInUserId = user.uid;
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    arguments = ModalRoute.of(context).settings.arguments;
    checkBookmark();
  }

  void checkBookmark() async{
    QuerySnapshot bookmarks = await _firestore
        .collection('users')
        .document(loggedInUserId)
        .collection('bookmarks')
        .where('restaurant_name', isEqualTo: arguments['recommendedRes']['place_name'])
        .getDocuments();
    if (bookmarks.documents.length == 0){
      setState(() {
        isBookmark = false;
      });
    }else{
      setState(() {
        isBookmark = true;
      });
    }
  }

  void addBookmark() async{

    if (!isBookmark){
      await _firestore
          .collection('users')
          .document(loggedInUserId)
          .collection('bookmarks')
          .document(arguments['recommendedRes']['place_name'])
          .setData({
            'restaurant_name': arguments['recommendedRes']['place_name'],
            'restaurant_url': arguments['recommendedRes']['place_url'],
            'distance': arguments['recommendedRes']['distance'],
            'user_id': loggedInUser.uid,
          });
      setState(() {
        isBookmark = true;
        print('북마크 목록에 음식점이 추가 되었습니다');
      });
    }
    else{
      await _firestore
          .collection('users')
          .document(loggedInUserId)
          .collection('bookmarks')
          .document(arguments['recommendedRes']['place_name'])
          .delete();

      setState(() {
        isBookmark = false;
        print('북마크 목록에서 제거되었습니다');
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: arguments['recommendedRes'] != {}
              ? WebView(
                  initialUrl: arguments['recommendedRes']['place_url'],
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController controller) {
                    _controller.complete(controller);
                  },
                )
              : Center(
                  child: Text(
                  '검색결과가 없습니다',
                  style: TextStyle(fontSize: 50.0),
                ))),
      floatingActionButton: FloatingActionButton(
        onPressed: addBookmark,
        child: Icon(Icons.bookmark),
        backgroundColor: isBookmark ? Colors.amberAccent : Colors.grey,
      ),
    );
  }
}
