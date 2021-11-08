import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_service/Animation/animation.dart';

import '../../sizeconfig.dart';

class serviceProviderProfile extends StatefulWidget {

  final String? name;
  final String? email;
  final String? expirence;
  final String? location;
  final String? qualification;
  final String? service;
  final String? subservice;
  final String? mobile;
  final String? image;
  final String? desc;
  final String? id;
  final String? status;
  final String? block;

  const serviceProviderProfile({Key? key,  required this.name, required this.email, required this.expirence, required this.location, required this.qualification, required this.service, required this.subservice, required this.mobile, required this.image, required this.desc, required this.id, required this.status, required this.block}) : super(key: key);

  @override
  _serviceProviderProfileState createState() => _serviceProviderProfileState();
}

class _serviceProviderProfileState extends State<serviceProviderProfile> {

  String? id;
  Future<void> findid() async{
    await FirebaseFirestore.instance.collection("services").get().then((value){
      value.docs.forEach((element) {
        if(element['name'] == widget.service)
        {
          setState(() {
            id = element.id;
          });
        }
      });
    });



  }

  Future<void> add_to_block() async{
    await FirebaseFirestore.instance.collection("services").doc(id).collection(widget.service!).doc(widget.subservice).collection("blocked").doc(widget.id).set({
      "name" : widget.name,
      "mobile" : widget.mobile,
      "mail" : widget.email,
      "service" : widget.service,
      "subService" : widget.subservice,
      "location" : widget.location,
      "qualification" : widget.qualification,
      "experience" : widget.expirence,
      "description" : widget.desc,
      "image" : widget.image,
      "status" : widget.status,
      "blocked" : "true",
    }).whenComplete(() async {
      await FirebaseFirestore.instance.collection("services").doc(id).collection(widget.service!).doc(widget.subservice).collection("unblocked").doc(widget.id).delete();
    }).whenComplete(() {
      Navigator.of(context).pop();
      print("done bosss");
      _alertDialogBox("Moved To Blocked Successfully");
    });
    await FirebaseFirestore.instance.collection("Service Providers").doc(widget.id!).update(
        {
          "blocked" : "true",
        });
  }

  Future<void> add_to_unblock() async{
    await FirebaseFirestore.instance.collection("services").doc(id).collection(widget.service!).doc(widget.subservice).collection("unblocked").doc(widget.id).set({
      "name" : widget.name,
      "mobile" : widget.mobile,
      "mail" : widget.email,
      "service" : widget.service,
      "subService" : widget.subservice,
      "location" : widget.location,
      "qualification" : widget.qualification,
      "experience" : widget.expirence,
      "description" : widget.desc,
      "image" : widget.image,
      "status" : widget.status,
      "blocked" : "false",
    }).whenComplete(() async {
      await FirebaseFirestore.instance.collection("services").doc(id).collection(widget.service!).doc(widget.subservice).collection("blocked").doc(widget.id).delete();
    }).whenComplete(() {
      Navigator.of(context).pop();
      print("done bosss");
      _alertDialogBox("Moved To UnBlocked Successfully");
    });

    await FirebaseFirestore.instance.collection("Service Providers").doc(widget.id!).update(
        {
          "blocked" : "false",
        });

  }

  Future<void> _alertDialogBox(String error) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(

            content: Container(
              child: Text(
                error,
                style: TextStyle(color: Colors.black54,fontSize: SizeConfig.height!*2),
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Close",
                    style: TextStyle(color: Colors.blue),
                  )),
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findid();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(
                "Provider Profile",
                style: Theme.of(context).textTheme.subtitle2!.merge(
                    GoogleFonts.amaranth(fontSize: SizeConfig.height! * 3)),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(1),
              child: SingleChildScrollView(
                child: Container(
                  height: SizeConfig.height! * 90,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: FadeAnimation(
                          1,Container(
                          margin: EdgeInsets.only(
                            left: SizeConfig.width! * 4,
                            right: SizeConfig.width! * 4,
                            top: SizeConfig.height! * 3,
                            bottom: SizeConfig.height! * 1,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                topLeft: Radius.circular(25),
                              ),
                              color: Colors.blue.shade100
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: SizeConfig.height! * 1,
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  height: SizeConfig.height! * 15,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                      image: new DecorationImage(
                                          image: widget.image != null
                                              ? NetworkImage(widget.image!)
                                              : NetworkImage(
                                              "https://firebasestorage.googleapis.com/v0/b/homeservice-c4162.appspot.com/o/noimage.jpg?alt=media&token=a1dd2c1b-0db5-4203-a24e-56f5ee497af3"),
                                          fit: BoxFit.contain),
                                      border: Border.all(width: 3,color: widget.status == "Open" ? Colors.green : Colors.red)
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${widget.name!}".toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .merge(TextStyle(
                                        fontSize: SizeConfig.height! * 2.5,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black)),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${widget.service!}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .merge(GoogleFonts.amaranth(
                                      fontSize: SizeConfig.height! * 2.5,
                                      color: Colors.lightBlue.shade900,)),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      SizedBox(width: SizeConfig.width! * 1.5,),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          child: GestureDetector(
                                            onTap: ()async{
                                              var number = widget.mobile!; //set the number here
                                              bool? res = await FlutterPhoneDirectCaller.callNumber(number);
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(Icons.call,size: SizeConfig.height! * 2.6,color: Colors.green.shade900,),
                                                SizedBox(width: SizeConfig.width! * 1,),
                                                Text(
                                                  widget.mobile!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2!
                                                      .merge(TextStyle(
                                                      fontSize:
                                                      SizeConfig.height! * 1.5,
                                                      color: Colors
                                                          .black)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.mail,size: SizeConfig.height! * 2.6,color: Colors.green.shade900,),
                                            SizedBox(width: SizeConfig.width! * 1,),
                                            Text(
                                              widget.email!.toLowerCase(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .merge(TextStyle(
                                                  fontSize:
                                                  SizeConfig.height! * 1.5,
                                                  color: Colors
                                                      .black)),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: FadeAnimation(
                          1.1,
                          SingleChildScrollView(
                            child: Container(
                              height: SizeConfig.height! * 50,
                              margin: EdgeInsets.only(
                                left: SizeConfig.width! * 3.9,
                                right: SizeConfig.width! * 3.9,
                                bottom: SizeConfig.height! * 1,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(25),
                                      bottomLeft: Radius.circular(25)),
                                  color: Colors.blue.shade100),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.width! * 3,vertical: SizeConfig.height!*3),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: Container(
                                                    alignment:
                                                    Alignment.topLeft,
                                                    child: Text(
                                                      "SUB-SERVICE",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline3!
                                                          .merge(TextStyle(
                                                          color: Colors
                                                              .lightBlue
                                                              .shade900,fontSize: SizeConfig.height!*1.8)),
                                                    ))),
                                            Expanded(
                                                flex: 2,
                                                child: Container(
                                                    alignment:
                                                    Alignment.topLeft,
                                                    margin: EdgeInsets.only(
                                                        left:
                                                        SizeConfig.width! *
                                                            1),
                                                    child: Text(
                                                      "    " +
                                                          widget.subservice!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline3!.merge(TextStyle(fontSize: SizeConfig.height!*1.8)),
                                                    ))),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: Container(
                                                    alignment:
                                                    Alignment.topLeft,
                                                    child: Text(
                                                      "LOCATION",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline3!
                                                          .merge(TextStyle(
                                                          color: Colors
                                                              .lightBlue
                                                              .shade900,fontSize: SizeConfig.height!*1.8)),
                                                    ))),
                                            Expanded(
                                                flex: 2,
                                                child: Container(
                                                    alignment:
                                                    Alignment.topLeft,
                                                    child: Text(
                                                      "    " + widget.location!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline3!.merge(TextStyle(fontSize: SizeConfig.height!*1.8)),
                                                    ))),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: Container(
                                                    alignment:
                                                    Alignment.topLeft,
                                                    child: Text(
                                                      "QUALIF.",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline3!
                                                          .merge(TextStyle(
                                                          color: Colors
                                                              .lightBlue
                                                              .shade900,fontSize: SizeConfig.height!*1.8
                                                      )),
                                                    ))),
                                            Expanded(
                                                flex: 2,
                                                child: Container(
                                                    alignment:
                                                    Alignment.topLeft,
                                                    child: Text(
                                                      "    ${widget.qualification!}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline3!.merge(TextStyle(fontSize: SizeConfig.height!*1.8)),
                                                    ))),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: Container(
                                                    alignment:
                                                    Alignment.topLeft,
                                                    child: Text(
                                                      "EXPERIENCE",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline3!
                                                          .merge(TextStyle(
                                                          color: Colors
                                                              .lightBlue
                                                              .shade900,fontSize: SizeConfig.height!*1.8)),
                                                    ))),
                                            Expanded(
                                                flex: 2,
                                                child: Container(
                                                    alignment:
                                                    Alignment.topLeft,
                                                    child: Text(
                                                      "    ${widget.expirence!}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline3!.merge(TextStyle(fontSize: SizeConfig.height!*1.8)),
                                                    ))),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: Container(
                                                    alignment:
                                                    Alignment.topLeft,
                                                    child: Text(
                                                      "DESCRIPTION",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline3!
                                                          .merge(TextStyle(
                                                          color: Colors
                                                              .lightBlue
                                                              .shade900,fontSize: SizeConfig.height!*1.8)),
                                                    ))),
                                            Expanded(
                                                flex: 3,
                                                child: Padding(
                                                  padding: EdgeInsets.all(1),
                                                  child: SingleChildScrollView(
                                                    child: Container(
                                                        child: Text(
                                                          "${widget.desc!}",
                                                          textAlign:
                                                          TextAlign.justify,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headline3!.merge(TextStyle(fontSize: SizeConfig.height!*1.8)),
                                                        )),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      widget.block != "true"? Expanded(
                        child: FadeAnimation(
                          1.2,Container(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: (){
                              add_to_block();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red.shade100,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              alignment: Alignment.center,
                              height: SizeConfig.height! * 5,
                              width: SizeConfig.width! * 40,
                              child: Text("Block",style: GoogleFonts.poppins(color: Colors.red.shade900,fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ),
                        ),
                      ) :
                      Expanded(
                        child: FadeAnimation(
                          1.2,Container(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: (){
                              add_to_unblock();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              alignment: Alignment.center,
                              height: SizeConfig.height! * 5,
                              width: SizeConfig.width! * 40,
                              child: Text("Unblock",style: GoogleFonts.poppins(color: Colors.green.shade900,fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
