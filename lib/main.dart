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
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      onAuth: (appId){
        http
            .get(Uri.parse(
            'https://demo-hostapp.appboxo.com/api/get_auth_code/'))
            .then((response) {
          if (response.statusCode >= 400) {
            print('Error fetching auth code: ${response.body}');
            Appboxo.setAuthCode(appId, "");
          } else {
            Appboxo.setAuthCode(appId, json.decode(response.body)["auth_code"]);
          }
        });
      },
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
