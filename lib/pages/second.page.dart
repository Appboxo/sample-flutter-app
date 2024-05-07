/*CORE*/
import 'dart:async';
import 'package:flutter/material.dart';
/*APPBOXO_SDK*/
import 'package:appboxo_sdk/appboxo_sdk.dart';

class SecondPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late StreamSubscription<CustomEvent> subscription;

  @override
  void initState() {
    subscription = Appboxo.customEvents().listen((CustomEvent event) {
      if (event.appId == 'app36902') {
        Appboxo.sendEvent(
          CustomEvent(
            'event',
            event.appId,
            {},
            event.requestId
          ),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    print('Destroy second');
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
              'All purchases will be declined',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 24),
            MaterialButton(
              color: Colors.blue,
              onPressed: () {
                Appboxo.openMiniapp("app36902");
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
