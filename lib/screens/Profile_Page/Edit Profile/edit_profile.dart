import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_service/Animation/animation.dart';
import 'package:home_service/screens/Main_Page/forgetpassword.dart';
import 'package:home_service/service/user_details.dart';
import 'package:home_service/sizeconfig.dart';
import 'package:provider/provider.dart';


class edit_profile extends StatefulWidget {
  const edit_profile({Key? key}) : super(key: key);

  @override
  _edit_profileState createState() => _edit_profileState();
}

class _edit_profileState extends State<edit_profile> {
  String new_email = "";
  String new_Mobile_Number = "";
  String new_Name = "";
  String new_loc = "";

  bool _autovalidate = false;


  final _formKey = GlobalKey<FormState>();

  User? user = FirebaseAuth.instance.currentUser;

  final CollectionReference _collectionReference =
  FirebaseFirestore.instance.collection("userdetails");



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

  Future<void> _submitform() async {
    String? feedback = await Provider.of<user_details>(context,listen: false).update();
    _alertDialogBox(feedback);
    Navigator.pop(context);
  }

  Future<void> _Data() async{
    new_Name = Provider.of<user_details>(context).Name;
    new_Mobile_Number = Provider.of<user_details>(context).Mobile;
    new_email = Provider.of<user_details>(context).Email;
}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    _Data();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xff23ADE8),
    title: Text(
    "Edit Profile",
    style: GoogleFonts.poppins(
    fontSize: SizeConfig.height! * 2.5,
    fontWeight: FontWeight.w500),
      ),),
      body: SingleChildScrollView(
        child: FadeAnimation(
          1, Container(
            height: SizeConfig.height!*60,
            margin: EdgeInsets.symmetric(vertical: SizeConfig.height!*4),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                        padding:EdgeInsets.symmetric(horizontal: SizeConfig.width! * 6),
                        height: SizeConfig.height! * 4,
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 0.5,color: Colors.grey.shade500),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextFormField(
                            onChanged: (val) {
                              if(val.isEmpty || val == ""){
                                print(new_Name+" Text");
                                context.read<user_details>().update_name(new_Name) as String;
                              }
                              else{
                               context.read<user_details>().update_name(val) as String;
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty || value == "") {
                                return "Name should not be left empty";
                              }
                              return null;
                            },
                            autovalidate: _autovalidate,
                            decoration:
                            InputDecoration(
                                hintText: context.watch<user_details>().Name,
                                errorMaxLines: 1,
                                prefixIcon: Icon(Icons.person,size: SizeConfig.height! * 3,),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                hintStyle: GoogleFonts.poppins(
                                    fontSize: SizeConfig.height! * 2.3,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                                border: InputBorder.none
                            ),
                            style: GoogleFonts.poppins(
                                fontSize: SizeConfig.height! * 2,
                                color: Colors.black),
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      child: Container(
                        padding:EdgeInsets.symmetric(horizontal: SizeConfig.width! * 6),
                        height: SizeConfig.height! * 4,
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 0.5,color: Colors.grey.shade500),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextFormField(
                            onChanged: (val) {
                              if(val.isEmpty || val == ""){
                                context.read<user_details>().update_mobile(new_Mobile_Number) as String;
                              }
                              else{
                                context.read<user_details>().update_mobile(val) as String;
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty || value == "") {
                                return "Mobile Number should not be left empty";
                              }
                              return null;
                            },

                            autovalidate: _autovalidate,
                            decoration:
                            InputDecoration(
                                hintText: context.watch<user_details>().Mobile,
                                errorMaxLines: 1,
                                prefixIcon: Icon(Icons.phone_android,size: SizeConfig.height! * 3,),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                hintStyle: GoogleFonts.poppins(
                                    fontSize: SizeConfig.height! * 2.3,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                                border: InputBorder.none
                            ),
                            style: GoogleFonts.poppins(
                                fontSize: SizeConfig.height! * 2,
                                color: Colors.black),
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      child: Container(
                        padding:EdgeInsets.symmetric(horizontal: SizeConfig.width! * 6),
                        height: SizeConfig.height! * 4,
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 0.5,color: Colors.grey.shade500),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextFormField(
                            onChanged: (val) {
                              if(val.isEmpty || val == ""){
                                context.read<user_details>().update_email(new_email) as String;
                              }
                              else{
                                context.read<user_details>().update_email(val) as String;
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty || value == "") {
                                return "Email should not be left empty";
                              }
                              return null;
                            },
                            autovalidate: _autovalidate,
                            decoration:
                            InputDecoration(
                                hintText: context.watch<user_details>().Email,
                                errorMaxLines: 1,
                                prefixIcon: Icon(Icons.mail,size: SizeConfig.height! * 3,),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                hintStyle: GoogleFonts.poppins(
                                    fontSize: SizeConfig.height! * 2.3,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                                border: InputBorder.none
                            ),
                            style: GoogleFonts.poppins(
                                fontSize: SizeConfig.height! * 2,
                                color: Colors.black),
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      child: Container(
                        padding:EdgeInsets.symmetric(horizontal: SizeConfig.width! * 6),
                        height: SizeConfig.height! * 4,
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 0.5,color: Colors.grey.shade500),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextFormField(
                            onChanged: (val) {
                              if(val.isEmpty || val == ""){
                                context.read<user_details>().update_loc(new_loc) as String;
                              }
                              else{
                                context.read<user_details>().update_loc(val) as String;
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty || value == "") {
                                return "Location should not be left empty";
                              }
                              return null;
                            },
                            autovalidate: _autovalidate,
                            decoration:
                            InputDecoration(
                                hintText: context.watch<user_details>().Loc,
                                errorMaxLines: 1,
                                prefixIcon: Icon(Icons.gps_fixed,size: SizeConfig.height! * 3,),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                hintStyle: GoogleFonts.poppins(
                                    fontSize: SizeConfig.height! * 2.3,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                                border: InputBorder.none
                            ),
                            style: GoogleFonts.poppins(
                                fontSize: SizeConfig.height! * 2,
                                color: Colors.black),
                          ),
                        ),
                      )
                  ),
                  Expanded(child: GestureDetector(
                    onTap: (){
                      _submitform();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(vertical: SizeConfig.height!*2,horizontal: SizeConfig.width!*5),
                      height: SizeConfig.height! * 2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xff23ADE8),
                      ),
                      child: Text("Update Details",style: Theme.of(context).textTheme.subtitle2,),
                    ),
                  ),),
                  Expanded(child: Container(
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>forgetpassword()));
                      },
                      child: Text("Change Password ??",style: GoogleFonts.poppins(
                        fontSize: SizeConfig.height! * 2,
                        color: Colors.black,
                      ),),
                    ),
                  ),),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
