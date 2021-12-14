import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_service/screens/Bookings/historyfulldetails.dart';

import '../../sizeconfig.dart';
import 'current card.dart';

class history extends StatefulWidget {
  const history({Key? key}) : super(key: key);

  @override
  _historyState createState() => _historyState();
}

class _historyState extends State<history> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection("userdetails")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("orders")
            .doc("history")
            .collection("orders")
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Error: ${snapshot.error}"),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: SizeConfig.height! * 1),
                  child: ListView(
                    children: snapshot.data!.docs.map((document) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.width! * 2,
                            horizontal: SizeConfig.height! * 1.5),
                        child: historyfulldetails(
                          name: document["Name"],
                          id: document["ID"],
                          mobile: document["Mobile"],
                          subservice: document["Sub-Service"],
                          service: document["Service"],
                          date: document["Date"],
                          time: document["Time"],
                          image: document["Image"],
                          status: document["status"],
                          DocId: document["DocId"],
                        ),
                      );
                    }).toList(),
                  ),
                ));
          }

          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
