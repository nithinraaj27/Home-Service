import 'package:flutter/material.dart';

class rate extends StatefulWidget {
  const rate({Key? key}) : super(key: key);

  @override
  _rateState createState() => _rateState();
}

class _rateState extends State<rate> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Text("Rate Company"),
        ),
      ),
    ));
  }
}
