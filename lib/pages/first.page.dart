/*CORE*/
import 'dart:async';
import 'package:flutter/material.dart';
/*APPBOXO_SDK*/
import 'package:appboxo_sdk/appboxo_sdk.dart';

class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  StreamSubscription<CustomEvent> subscription;

  @override
  void initState() {
    subscription = AppboxoSdk.customEvents().listen((CustomEvent event) {
      if (event.appId == 'app36902') {
        AppboxoSdk.sendEvent(
          CustomEvent(
            type: 'event',
            appId: event.appId,
            payload: {},
            requestId: event.requestId,
          ),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    print('Destroy first');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Appboxo flutter test app'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'All purchases will be success',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 24),
            RaisedButton(
              color: Colors.blue,
              onPressed: () {
                AppboxoSdk.openMiniApp("app36902", "");
              },
              child: Text(
                'Run miniapp',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
