import 'package:flutter/material.dart';

class share extends StatefulWidget {
  const share({Key? key}) : super(key: key);

  @override
  _shareState createState() => _shareState();
}

class _shareState extends State<share> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: Container(
              alignment: Alignment.center,
              child: Text("Share Company"),
            ),
          ),
        ));
  }
}
