import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ResultPage extends StatefulWidget {

  static const String id = 'result_screen';

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  Map arguments;
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    arguments = ModalRoute.of(context).settings.arguments;
    // print(arguments['recommendedRes']);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child:
        arguments['recommendedRes'] != {} ?
        WebView(
          initialUrl: arguments['recommendedRes']['place_url'],
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController controller){
            _controller.complete(controller);
          },
        )
            :
            Center(
                child: Text('검색결과가 없습니다',
                  style: TextStyle(
                    fontSize: 50.0
                  ),
                )
            )
      ),
    );
  }
}
