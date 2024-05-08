/*CORE*/
import 'dart:async';

import 'package:appboxo_sdk/appboxo_sdk.dart';
import 'package:flutter/material.dart';
/*ROUTES*/
import 'package:appboxo_flutter_sample_app/common/routes.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late StreamSubscription<MiniappsResult> subscription;
  List<MiniappData> miniapps = List.empty();

  @override
  void initState() {
    subscription = Appboxo.miniapps().listen((MiniappsResult result) {
      setState(() {
        miniapps = result.miniapps ?? List.empty();
      });
    });
    Appboxo.getMiniapps();
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Appboxo flutter test app'),
        ),
        body: Column(children: [
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 180,
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.FirstPage);
                  },
                  child: Text(
                    'First screen',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 180,
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.SecondPage);
                  },
                  child: Text(
                    'Second screen',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              )
            ],
          )),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: miniapps.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          Appboxo.openMiniapp(miniapps[index].appId);
                        },
                        child: Container(
                          height: 60,
                          child: Row(children: [
                            if (miniapps[index].logo.isNotEmpty)
                              Image.network(
                                miniapps[index].logo,
                                width: 40,
                                height: 40,
                              ),
                            Text('${miniapps[index].name}')
                          ]),
                        ));
                  }))
        ]));
  }
}
