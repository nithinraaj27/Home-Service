import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../sizeconfig.dart';

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
          appBar: AppBar(
            backgroundColor: Color(0xff23ADE8),
            title: Text(
              "Register as Service Provider",
              style: GoogleFonts.poppins(
                  fontSize: SizeConfig.height! * 2.5, fontWeight: FontWeight.w500),
            ),
          ),
          body: Center(
            child: Container(
              alignment: Alignment.center,
              child: Text("Service Provider Registration"),
            ),
          ),
        ));
  }
}
