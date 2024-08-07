/*CORE*/
import 'dart:async';

import 'package:appboxo_sdk/appboxo_sdk.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late StreamSubscription<MiniappsResult> subscription;
  late StreamSubscription<PaymentEvent> paymentSubscription;

  List<MiniappData> miniapps = List.empty();
  final miniappIdController = TextEditingController();

  @override
  void initState() {
    subscription = Appboxo.miniapps().listen((MiniappsResult result) {
      setState(() {
        miniapps = result.miniapps ?? List.empty();
        miniapps.forEach((data) {
          print(data.appId);
          print(data.name);
          print(data.description);
          print(data.logo);
          print(data.category);
        });
      });
    });
    Appboxo.getMiniapps();

    paymentSubscription =
        Appboxo.paymentEvents().listen((PaymentEvent payment) async {
      Appboxo
          .hideMiniapps(); // need to hide the miniapp before showing the payment page or popup
      NDialog(
        dialogStyle: DialogStyle(titleDivider: true),
        title: Text("Payment"),
        content: Text("Confirm payment"),
        actions: <Widget>[
          TextButton(
              child: Text("Confirm"),
              onPressed: () {
                Navigator.pop(context);
                //.. send request to confirm payment to your backend
                payment.status = 'success'; // change the payment status
                Appboxo.sendPaymentEvent(
                    payment); // send payment result to miniapp
                Appboxo.openMiniapp(payment.appId); // need to open the miniapp
              }),
          TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
                payment.status = 'cancelled';
                Appboxo.sendPaymentEvent(payment);
                Appboxo.openMiniapp(payment.appId);
              }),
        ],
      ).show(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    paymentSubscription.cancel();
    miniappIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Flutter Boxo Demo'),
        ),
        body: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: miniappIdController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'app ID',
              ),
            ),
          ),
          SizedBox(
            width: 180,
            child: MaterialButton(
              color: Colors.blue,
              onPressed: () {
                Appboxo.openMiniapp(miniappIdController.text);
              },
              child: Text(
                'Open miniapp',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
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
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: Text('${miniapps[index].name}'))
                          ]),
                        ));
                  }))
        ]));
  }
}
