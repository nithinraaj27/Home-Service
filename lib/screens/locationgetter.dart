import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../sizeconfig.dart';
import 'main.dart';

class Locationgetter extends StatefulWidget {

  @override
  _LocationgetterState createState() => _LocationgetterState();
}

class _LocationgetterState extends State<Locationgetter> {

  String? location;
  final _formKey = GlobalKey<FormState>();

  Future<void> _alertDialogBox(String error) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Error",
              style: TextStyle(color: Theme.of(context).focusColor),
            ),
            content: Container(
              child: Text(
                error,
                style: TextStyle(color: Theme.of(context).focusColor),
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Close Dialog",
                    style: TextStyle(color: Colors.blue),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Form(
                key: _formKey,
                child: Container(
                  //color: Colors.green,
                  height: SizeConfig.height! * 40,
                  width: SizeConfig.width! * 80,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(width: 0.5,color: Colors.black54)
                              ),
                              child: TextFormField(
                                onChanged: (val){
                                  setState(() {
                                    location = val;
                                  });
                                },

                                validator: (val){
                                  if(val!.isEmpty || val == "")
                                  {
                                    return "Please enter a valid location";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: SizeConfig.width! * 4),
                                  hintText: "Location",
                                  hintStyle: Theme.of(context).textTheme.headline3!.merge(TextStyle(fontSize: SizeConfig.height! * 2,color: Colors.black54)),
                                  border: InputBorder.none,
                                ),
                                style: GoogleFonts.poppins(
                                  fontSize: SizeConfig.height! * 2,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                          ),
                        ),
                      ),
                      Text("OR",style: GoogleFonts.poppins(fontSize: SizeConfig.height! * 3,color: Colors.blue,fontWeight: FontWeight.w800),),
                      Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            child: Container(
                              height: SizeConfig.height! * 6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.blue,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: SizeConfig.width! * 4,),
                                  Expanded(
                                      child: Container(
                                          alignment: Alignment.centerRight,
                                          child: Icon(Icons.gps_fixed,color: Colors.black,size: SizeConfig.height! * 3,))),
                                  Expanded(
                                      flex: 6,
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: Text("Choose your location",style: Theme.of(context).textTheme.headline3!.merge(TextStyle(fontSize: SizeConfig.height! * 2)),)))
                                ],
                              ),
                            )
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: (){
                              if(!_formKey.currentState!.validate())
                              {
                                _alertDialogBox("Enter Location");
                              }
                              else
                              {
                                FirebaseFirestore.instance.collection("userlocations").doc(FirebaseAuth.instance.currentUser!.uid).set({
                                  "Location" : location,
                                }).whenComplete(() => {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => mainPage()))
                                });
                              }
                            },
                            child: Container(
                              height: SizeConfig.height! * 6,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.blue,
                              ),
                              child: Text("👉 Go Next ",style: Theme.of(context).textTheme.subtitle2,),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
        )
    );
  }
}


