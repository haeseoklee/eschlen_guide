import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschlen_guide/auth.dart';
import 'package:eschlen_guide/models/recommended_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;
String loggedInUserId;

class ResultPage extends StatefulWidget {
  static const String id = 'result_screen';

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  AuthManager authManager = AuthManager();
  bool isBookmark = false;
  var resData = Map();


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
    checkBookmark();
    resData = Provider.of<RecommendedData>(context).recommenedData;
  }


  void checkBookmark() async{
    QuerySnapshot bookmarks = await _firestore
        .collection('users')
        .document(loggedInUserId)
        .collection('bookmarks')
        .where('restaurant_name', isEqualTo: resData['place_name'])
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
          .document(resData['place_name'])
          .setData({
            'restaurant_name': resData['place_name'],
            'restaurant_url': resData['place_url'],
            'distance': resData['distance'],
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
          .document(resData['place_name'])
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
          child: resData != {}
              ? WebView(
                  initialUrl: resData['place_url'],
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
