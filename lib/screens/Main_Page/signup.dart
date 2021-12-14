import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_service/Animation/animation.dart';
import 'package:home_service/screens/Main_Page/signin.dart';
import 'package:home_service/sizeconfig.dart';



class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  String? name = "";
  String? number = "";
  String? email = "";
  String? location = "";
  String? password = "";
  String? confirm_pass = "";
  bool obscure_text = true;
  bool _autovalidate = false;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    obscure_text = true;
  }



  Future<String?> _signup() async {
    try {
      final User? currentUSer = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: email!, password: password!))
          .user;
      Map<String, dynamic> data = {
        "Uid": currentUSer!.uid,
        "Name": name,
        "E-mail": email,
        "Mobile": number,
        "Password": password,
        "Role" : "user",
        "location" : location
      };
      FirebaseFirestore.instance
          .collection("userdetails")
          .doc(currentUSer.uid)
          .set(data);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak_passwod') {
        return "The password is too week";
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exist';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {

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

    void _submitform() async {
      String? feedback = await _signup();
      if (feedback != null) {
        _alertDialogBox(feedback);
      } else {
        Navigator.pop(context);
      }
    }
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Container(
              height: SizeConfig.height! * 120,
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                autovalidate: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: FadeAnimation(
                        1,Container(
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => signin()));
                                  },
                                  child: Container(
                                    child: Icon(Icons.chevron_left_sharp,size: SizeConfig.height! * 6,color: Colors.black,),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  child: Text("User Registration",style: Theme.of(context).textTheme.subtitle1,),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: CircleAvatar(
                                    child: Icon(Icons.person,size: SizeConfig.height! * 3,),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: FadeAnimation(
                          1.1,Container(
                            padding:EdgeInsets.symmetric(horizontal: SizeConfig.width! * 6),
                            height: SizeConfig.height! * 4,
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.5,color: Colors.grey.shade500),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: TextFormField(
                                onChanged: (val) {
                                  setState(() {
                                    name = val;
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty && value == "") {
                                    return "Name should not be left empty";
                                  }
                                  return null;
                                },
                                autovalidate: _autovalidate,
                                decoration:
                                InputDecoration(
                                    hintText: "Full Name",
                                    errorMaxLines: 1,
                                    prefixIcon: Icon(FontAwesomeIcons.idBadge,size: SizeConfig.height! * 3,),
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
                          ),
                        )
                    ),
                    Expanded(
                        child: FadeAnimation(
                          1.2,Container(
                            padding:EdgeInsets.symmetric(horizontal: SizeConfig.width! * 6),
                            height: SizeConfig.height! * 4,
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.5,color: Colors.grey.shade500),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: TextFormField(
                                onChanged: (val) {
                                  setState(() {
                                    number = val;
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty &&
                                      value == "" &&
                                      value.length != 10) {
                                    return "Phone number should not be left empty";
                                  } else {
                                    String patttern =
                                        r'(^(?:(?:\+|0{0,2})91(\s*[\-]\s*)?|[0]?)?[789]\d{9}$)';
                                    RegExp regExp = new RegExp(patttern);
                                    if (!regExp.hasMatch(value)) {
                                      return 'Please enter valid mobile number';
                                    }
                                  }

                                  return null;
                                },
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10)
                                ],
                                keyboardType: TextInputType.number,
                                autovalidate: _autovalidate,
                                decoration:InputDecoration(
                                    hintText: "Mobile",
                                    errorMaxLines: 1,
                                    prefixIcon: Icon(Icons.call,size: SizeConfig.height! * 3,),
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
                          ),
                        )
                    ),
                    Expanded(
                        child: FadeAnimation(
                          1.3,Container(
                            padding:EdgeInsets.symmetric(horizontal: SizeConfig.width! * 6),
                            height: SizeConfig.height! * 4,
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.5,color: Colors.grey.shade500),
                                  borderRadius: BorderRadius.circular(15)
                              ),
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
                                keyboardType: TextInputType.emailAddress,
                                autovalidate: _autovalidate,
                                decoration:
                                InputDecoration(
                                    hintText: "Email",
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
                          ),
                        )
                    ),
                    Expanded(
                        child: FadeAnimation(
                          1.4,Container(
                            padding:EdgeInsets.symmetric(horizontal: SizeConfig.width! * 6),
                            height: SizeConfig.height! * 4,
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.5,color: Colors.grey.shade500),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: TextFormField(
                                onChanged: (val) {
                                  setState(() {
                                    location = val;
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty && value == "") {
                                    return "Location should not be left empty";
                                  }
                                  return null;
                                },
                                autovalidate: _autovalidate,
                                decoration:
                                InputDecoration(
                                    hintText: "Location",
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
                          ),
                        )
                    ),
                    Expanded(
                      child: FadeAnimation(
                        1.5,Container(
                          height: SizeConfig.height! * 4,
                          padding: EdgeInsets.symmetric(horizontal: SizeConfig.width! * 6),
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 0.5,color: Colors.grey.shade500),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty && value == "") {
                                  return "Password should not be left empty";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: obscure_text,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: SizeConfig.height! * 2.3,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                  errorMaxLines: 1,
                                  prefixIcon: Icon(Icons.lock,size: SizeConfig.height! * 3,),
                                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscure_text = !obscure_text;
                                      });
                                    },
                                    icon: Icon(obscure_text
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    color: Colors.blue,
                                  ),
                                  border: InputBorder.none),
                              style: GoogleFonts.poppins(
                                  fontSize: SizeConfig.height! * 2,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FadeAnimation(
                        1.6,Container(
                          height: SizeConfig.height! * 4,
                          padding: EdgeInsets.symmetric(horizontal: SizeConfig.width! * 6),
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 0.5,color: Colors.grey.shade500),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  confirm_pass = val;
                                });
                              },
                              validator: (value) {
                                if (!(value == confirm_pass) || value!.isEmpty) {
                                  return "Confirm Password should not be left empty";
                                }
                                return null;
                              },
                              obscureText: obscure_text,
                              decoration: InputDecoration(
                                  hintText: " Confirm Password",
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: SizeConfig.height! * 2.3,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                  errorMaxLines: 1,
                                  prefixIcon: Icon(Icons.lock,size: SizeConfig.height! * 3,),
                                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscure_text = !obscure_text;
                                      });
                                    },
                                    icon: Icon(obscure_text
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    color: Colors.blue,
                                  ),
                                  border: InputBorder.none),
                              style: GoogleFonts.poppins(
                                  fontSize: SizeConfig.height! * 2,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FadeAnimation(
                        1.7,Padding(
                          padding: EdgeInsets.symmetric(horizontal: SizeConfig.width! * 10,vertical: SizeConfig.height! * 3.2),
                          child: GestureDetector(
                            onTap: () {
                              if (!_formKey.currentState!.validate()) {
                                _alertDialogBox("No field should be left Empty");
                              } else {
                                _submitform();
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xff23ADE8),
                              ),
                              child: Text("SignUp",style: Theme.of(context).textTheme.subtitle2,),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FadeAnimation(
                        1.8,Container(
                          alignment: Alignment.topCenter,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Text("Already have an account?",style: Theme.of(context).textTheme.headline3,))),
                              Expanded(child: InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => signin()));
                                  },
                                  child: Text("   SignIn",style: Theme.of(context).textTheme.headline3!.merge(TextStyle(color: Colors.blue)),)))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
