import 'package:flutter/material.dart';

class service_provider extends StatefulWidget {
  const service_provider({Key? key}) : super(key: key);

  @override
  _service_providerState createState() => _service_providerState();
}

class _service_providerState extends State<service_provider> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: Container(
              alignment: Alignment.center,
              child: Text("Service Provider"),
            ),
          ),
        ));
  }
}
