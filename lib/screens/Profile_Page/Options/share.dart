import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../sizeconfig.dart';

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
          appBar: AppBar(
            backgroundColor: Color(0xff23ADE8),
            title: Text(
              "Share",
              style: GoogleFonts.poppins(
                  fontSize: SizeConfig.height! * 2.5, fontWeight: FontWeight.w500),
            ),
          ),
          body: Center(
            child: Container(
              alignment: Alignment.center,
              child: Text("Share Company"),
            ),
          ),
        ));
  }
}
