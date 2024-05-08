/*CORE*/
import 'package:flutter/material.dart';
/*APPBOXO_SDK*/
import 'package:appboxo_sdk/appboxo_sdk.dart';
/*ROUTeS*/
import 'common/routes.dart';
/*PAGES*/
import 'pages/main.page.dart';
import 'pages/first.page.dart';
import 'pages/second.page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<void> Function() subscription;

  @override
  void initState() {
    Appboxo.setConfig("[CLIENT_ID]", multitaskMode: false, theme: 'light');
    subscription = Appboxo.lifecycleHooksListener(
      onLaunch: (appId) {
        print(appId);
        print('onLaunch');
      },
      onResume: (appId) {
        print(appId);
        print('onResume');
      },
      onPause: (appId) {
        print(appId);
        print('onPause');
      },
      onClose: (appId) {
        print(appId);
        print('onClose');
      },
      onError: (appId, error) {
        print(appId);
        print(error);
        print('onError');
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    subscription();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Routes.Main: (BuildContext context) => MainPage(),
        Routes.FirstPage: (BuildContext context) => FirstPage(),
        Routes.SecondPage: (BuildContext context) => SecondPage(),
      },
    );
  }
}
