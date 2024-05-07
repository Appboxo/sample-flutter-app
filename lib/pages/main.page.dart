/*CORE*/
import 'package:flutter/material.dart';
/*ROUTES*/
import 'package:appboxo_flutter_sample_app/common/routes.dart';

class MainPage extends StatelessWidget {
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
            ),
          ],
        ),
      ),
    );
  }
}
