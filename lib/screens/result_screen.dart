import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eschlen_guide/auth.dart';
import 'package:eschlen_guide/models/recommend_data.dart';
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
  AuthManager authManager = AuthManager();
  bool isBookmark = false;
  var recommenedData = Map();

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
    recommenedData = Provider.of<RecommendedData>(context).recommenedData;
    checkBookmark(recommenedData);
  }

  void checkBookmark(Map resData) async {
    QuerySnapshot bookmarks = await _firestore
        .collection('users')
        .document(loggedInUserId)
        .collection('bookmarks')
        .where('restaurant_name', isEqualTo: resData['place_name'])
        .getDocuments();
    if (bookmarks.documents.length == 0) {
      setState(() {
        isBookmark = false;
      });
    } else {
      setState(() {
        isBookmark = true;
      });
    }
  }

  void addBookmark() async {
    if (!isBookmark) {
      _firestore
          .collection('users')
          .document(loggedInUserId)
          .collection('bookmarks')
          .document(recommenedData['place_name'])
          .setData({
        'restaurant_name': recommenedData['place_name'],
        'restaurant_url': recommenedData['place_url'],
        'phone': recommenedData['phone'],
        'road_address_name': recommenedData['road_address_name'],
        'user_id': loggedInUser.uid,
      });
      setState(() {
        isBookmark = true;
        print('북마크 목록에 음식점이 추가 되었습니다');
      });
    } else {
      _firestore
          .collection('users')
          .document(loggedInUserId)
          .collection('bookmarks')
          .document(recommenedData['place_name'])
          .delete();

      setState(() {
        isBookmark = false;
        print('북마크 목록에서 제거되었습니다');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MyWebView(
          url: recommenedData['place_url'],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(top: 120),
          child: SizedBox(
            height: 120,
            width: 120,
            child:FloatingActionButton(
                  onPressed: addBookmark,
                  child: Image.asset(
                    'images/bookmark.png',
                    color: isBookmark ? Colors.amberAccent : Colors.grey.withOpacity(0.7),
                    height: 120,
                  ),
                  backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    splashColor: Colors.transparent,
                    highlightElevation: 0.0
            ),
          ),
        ),
      ),
    );
  }
}

class MyWebView extends StatelessWidget {

  final String url;
  Completer<WebViewController> _controller = Completer<WebViewController>();
  MyWebView({@required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: url != ''
              ? WebView(
                  initialUrl: url,
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
    );
  }
}
