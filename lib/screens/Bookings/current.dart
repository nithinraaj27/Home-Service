import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_service/screens/Bookings/current%20card.dart';
import 'package:home_service/sizeconfig.dart';

class current extends StatefulWidget {
  const current({Key? key}) : super(key: key);

  @override
  _currentState createState() => _currentState();
}

class _currentState extends State<current> {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection("userdetails").doc(FirebaseAuth.instance.currentUser!.uid).collection("orders").doc("current").collection("orders").get(),
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
                child: ListView(
                  children: snapshot.data!.docs.map((document){
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: SizeConfig.width! * 2,horizontal: SizeConfig.height! * 1.5),
                      child: current_card(
                        name: document["Name"],
                        id: document["ID"],
                        mobile: document["Mobile"],
                        subservice: document["Sub-Service"],
                        service: document["Service"],
                        date: document["Date"],
                        time: document["Time"],
                        image: document["Image"],
                        DocId: document["DocId"],
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
    );
    }
}
