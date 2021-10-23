import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_service/Animation/animation.dart';
import 'package:home_service/main.dart';


import '../sizeconfig.dart';
import 'Main_Page/signin.dart';

class forgetpassword extends StatefulWidget {
  const forgetpassword({Key? key}) : super(key: key);

  @override
  _forgetpasswordState createState() => _forgetpasswordState();
}

class _forgetpasswordState extends State<forgetpassword> {
  String? email;
  bool _autovalidate = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _alertDialogBox(String error) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Error",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            content: Container(
              child: Text(
                error,
                style: Theme.of(context).textTheme.headline3,
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
        appBar: AppBar(
          title: Text(
            "Change Password",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          backgroundColor: Color(0xff23ADE8),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: SizeConfig.height! * 30,
            width: double.infinity,
            //color: Colors.red,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                      child: FadeAnimation(
                    1.1,
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.width! * 6),
                      height: SizeConfig.height! * 4,
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.5, color: Colors.grey.shade500),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty && value == "") {
                              return "Email should not be left empty";
                            }
                            return null;
                          },
                          autovalidate: _autovalidate,
                          decoration: InputDecoration(
                              hintText: "Email",
                              errorMaxLines: 1,
                              prefixIcon: Icon(
                                Icons.mail,
                                size: SizeConfig.height! * 3,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: SizeConfig.height! * 2.3,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                              border: InputBorder.none),
                          style: GoogleFonts.poppins(
                              fontSize: SizeConfig.height! * 2,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  )),
                  Expanded(
                    child: FadeAnimation(
                      1.2,
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.width! * 10,
                            vertical: SizeConfig.height! * 4),
                        child: GestureDetector(
                          onTap: () async {
                            if (!_formKey.currentState!.validate()) {
                              _alertDialogBox("No field should be left Empty");
                            } else {
                              try{
                                print(email);
                                await FirebaseAuth.instance
                                    .sendPasswordResetEmail(email: email!);
                                showAnimatedDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: Color(0xffDCE8FF),
                                        ),
                                        height: SizeConfig.height! * 25,
                                        width: SizeConfig.width! * 70,
                                        child: Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(child: Text("INFO",style: Theme.of(context).textTheme.subtitle1,)),
                                              Expanded(child: Text("Check your mail to change the password",style: Theme.of(context).textTheme.headline3,)),
                                              Expanded(child: Container(
                                                  alignment: Alignment.centerRight,
                                                  child: GestureDetector(
                                                    onTap: ()
                                                    {
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => helperone()));
                                                    },
                                                    child: Container(
                                                        alignment: Alignment.center,
                                                        height: SizeConfig.height! * 5,
                                                        width: SizeConfig.width! * 20,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(15),
                                                          color: Color(0xff23ADE8),
                                                        ),
                                                        child: Text("ok",style: Theme.of(context).textTheme.subtitle2,)),
                                                  ))),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  animationType:DialogTransitionType.size,
                                  curve: Curves.easeInCirc,
                                  duration: Duration(seconds: 1),
                                );
                              }
                              catch(e){
                                _alertDialogBox(e.toString());
                              }
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xff23ADE8),
                            ),
                            child: Text(
                              "Change Password",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
