import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_service/screens/Profile_Page/Options/saved%20card.dart';

import '../../../sizeconfig.dart';

class saved extends StatefulWidget {
  const saved({Key? key}) : super(key: key);

  @override
  _savedState createState() => _savedState();
}

class _savedState extends State<saved> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff23ADE8),
            title: Text(
              "Saved Bookings",
              style: GoogleFonts.poppins(
                  fontSize: SizeConfig.height! * 2.5, fontWeight: FontWeight.w500),
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection("userdetails").doc(FirebaseAuth.instance.currentUser!.uid).collection("Saved").get(),
              builder: (context , snapshot) {
                if(snapshot.hasError)
                {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }

                if(snapshot.connectionState == ConnectionState.done){
                  return Container(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(top: SizeConfig.height! * 1),
                        child: snapshot.data!.docs.isEmpty ? Center(child: Text("No Saved Service"),) :
                        ListView(
                          children: snapshot.data!.docs.map((document){
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: SizeConfig.width! * 2,horizontal: SizeConfig.height! * 1.5),
                              child: savedCard(
                                name: document["Name"],
                                uid: document["Uid"],
                                mobile: document["Mobile"],
                                subservice: document["SubService"],
                                service: document["service"],
                                image: document["Image"],
                                desc: document["Description"],
                                experience: document["experience"],
                                location: document["location"],
                                mail: document["Mail"],
                                qualification: document["Qualification"],
                                status: document["status"],
                              ),
                            );
                          }).toList(),
                        ),
                      )
                  );
                }

                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
          )
        ));
  }
}
